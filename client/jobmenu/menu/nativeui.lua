if Config.Menu == "ox_lib" then
    -- TO BE DONE
end



if Config.Menu == "NativeUI" then
    middleitem = true
    _menuPool = NativeUI.CreatePool()


    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            if _menuPool:IsAnyMenuOpen() then
                _menuPool:ProcessMenus()
            else
                Citizen.Wait(150) -- this small line
            end
        end
    end)

    ----(ESX.DumpTable(jobs))
    deletedjobs = {}
    function openadminmenu()
        menuclosed = false
        jobs = getjobs()
        number = 1
        if not _menuPool:IsAnyMenuOpen() then
            mainmenu = NativeUI.CreateMenu(locale("adminmenu"), "")
            _menuPool:Add(mainmenu)
            _menuPool:RefreshIndex()
            _menuPool:MouseControlsEnabled(false)
            _menuPool:MouseEdgeEnabled(false)
            _menuPool:ControlDisablingEnabled(false)
            changestuff = {}

            for k, v in pairs(jobs) do
                --(v.jobinfo)


                if lib.table.contains(deletedjobs, v.name) then
                    debug2("job is deleted " .. v.name)
                else
                    jobsmenu = _menuPool:AddSubMenu(mainmenu, v.label, v.name)
                    _menuPool:RefreshIndex()
                    _menuPool:MouseControlsEnabled(false)
                    _menuPool:MouseEdgeEnabled(false)
                    _menuPool:ControlDisablingEnabled(false)
                    jobsmenu.Item:RightLabel(">")
                    local name = NativeUI.CreateItem(locale("name"), "")
                    jobsmenu.SubMenu:AddItem(name)
                    name:RightLabel(v.name)


                    jobsmenu.SubMenu.OnMenuClosed = function(menu)
                        if #changestuff > 0 then
                            -- do something
                            local alert = lib.alertDialog({
                                header = locale("unsaved"),
                                content = locale("you have unsaved content"),
                                centered = true,
                                cancel = true
                            })
                            if alert == "confirm" then
                                for k, v in pairs(changestuff) do
                                    if v.name then
                                        --("ah")
                                        TriggerServerEvent("ludaro_jobs:changename", v.job, v.name)
                                    end
                                    if v.label then
                                        TriggerServerEvent("ludaro_jobs:labelch", v.job, v.label)
                                    end
                                    if v.whitelist ~= nil then
                                        TriggerServerEvent("ludaro_jobs:setwhitelist", v.job, v.whitelist)
                                    end

                                    if v.bossmenu then
                                        menuclosed = true
                                        TriggerServerEvent("ludaro_jobs:setbossmenu", v.job, v.bossmenu)
                                    end
                                end
                            else
                                changestuff = {}
                                _menuPool:CloseAllMenus()
                                openadminmenu()
                            end
                        end
                    end
                    name.Activated = function(sender, index)
                        newname = KeyboardInput(locale("insertname"), "", 30)
                        if newname then
                            name:RightLabel(newname)
                            table.insert(changestuff, { job = v.name, name = newname })
                        end
                    end
                    local label = NativeUI.CreateItem(locale("label"), "")
                    jobsmenu.SubMenu:AddItem(label)
                    label:RightLabel(v.label)
                    label.Activated = function(sender, index)
                        newlabel = KeyboardInput(locale("insertlabel"), "", 30)
                        if newlabel then
                            label:RightLabel(newlabel)
                            table.insert(changestuff, { job = v.label, label = newlabel })
                        end
                    end
                    isWhitelistedadd = NativeUI.CreateCheckboxItem(locale("whitelisted"), false, "")
                    jobsmenu.SubMenu:AddItem(isWhitelistedadd)
                    isWhitelistedadd.Checked = v.whitelisted or false

                    isWhitelistedadd.CheckboxEvent = function(menu, item, checked)
                        table.insert(changestuff, { job = v.label, whitelist = checked })
                    end

                    grade = _menuPool:AddSubMenu(jobsmenu.SubMenu, locale("grade"), "")
                    _menuPool:RefreshIndex()
                    _menuPool:MouseControlsEnabled(false)
                    _menuPool:MouseEdgeEnabled(false)
                    _menuPool:ControlDisablingEnabled(false)





                    local sortedGrades = {}
                    for k, v in pairs(v.grades) do
                        table.insert(sortedGrades, v)
                    end
                    table.sort(sortedGrades, function(a, b) return a.grade < b.grade end)
                    for _, grad in ipairs(sortedGrades) do
                        gradeitem = _menuPool:AddSubMenu(grade.SubMenu, grad.name .. "(" .. grad.label .. ")", "")
                        gradeitem.Item:RightLabel(grad.grade .. " || " .. grad.salary .. locale("$"))
                        local salary = NativeUI.CreateItem(locale("salary"), "")
                        local name = NativeUI.CreateItem(locale("name"), "")
                        local label = NativeUI.CreateItem(locale("label"), "")
                        salary:RightLabel(grad.salary .. locale("$"))
                        name:RightLabel(grad.name)
                        label:RightLabel(grad.label)
                        gradeitem.SubMenu:AddItem(salary)
                        gradeitem.SubMenu:AddItem(name)
                        gradeitem.SubMenu:AddItem(label)



                        name.Activated = function(sender, index)
                            newgradename = KeyboardInput(locale("insertname"), "", 30)
                            if newgradename then
                                name:RightLabel(newgradename)
                            end
                        end
                        label.Activated = function(sender, index)
                            newgradelabel = KeyboardInput(locale("insertlabel"), "", 30)
                            if newgradelabel then
                                label:RightLabel(newgradelabel)
                            end
                        end
                        local deletegrade = _menuPool:AddSubMenu(gradeitem.SubMenu, locale("deletegrade"), "")
                        deletegrade.Item:RightLabel(">")
                        if middleitem then
                            deletegrade.Item._Text.Padding = { X = 180 }
                        end
                        local yes = NativeUI.CreateItem(locale("yes"), "")
                        deletegrade.SubMenu:AddItem(yes)
                        yes.Activated = function(sender, index)
                            TriggerServerEvent("ludaro_jobs:deletegrade", v.name, grad.name)
                            _menuPool:CloseAllMenus()
                            openadminmenu()
                        end

                        local confirm = _menuPool:AddSubMenu(gradeitem.SubMenu, locale("confirm"), "")
                        confirm.Item:RightLabel(">")
                        if middleitem then
                            confirm.Item._Text.Padding = { X = 180 }
                        end
                        local yes = NativeUI.CreateItem(locale("yes"), "")
                        confirm.SubMenu:AddItem(yes)
                        yes.Activated = function(sender, index)
                            if newgradename then
                                TriggerServerEvent("ludaro_jobs:changename", v.name, grad.name, newgradename)
                            end
                            if newgradelabel then
                                TriggerServerEvent("ludaro_jobs:labelch", v.name, grad.name, newgradelabel)
                            end
                            _menuPool:CloseAllMenus()
                            openadminmenu()
                        end
                    end

                    creategrade = NativeUI.CreateItem(locale("creategrade"), "")

                    creategrade.Activated = function(sender, index)
                        -- create a grade
                        newgrade = KeyboardInput(locale("insertname"), "", 30)
                        newgradelabel = KeyboardInput(locale("insertlabel"), "", 30)
                        if newgrade ~= "" and newgradelabel ~= "" then
                            newgradesalary = KeyboardInput(locale("insertsalary"), "", 30)
                            if tonumber(newgradesalary) ~= nil then
                            else
                                -- Code to execute if newgradesalary is not a number
                                Config.Notify(locale("nonumber"))
                                newgradesalary = KeyboardInput(locale("insertsalary"), "", 30)
                            end

                            if tonumber(newgradesalary) ~= nil then
                                salary = 0
                            end

                            newid = KeyboardInput(locale("insertid"), "", 30)


                            newGradeTable = {
                                id = newid or 0,
                                grade = 0,
                                name = newgrade,
                                label = newgradelabel,
                                salary = newgradesalary,
                                skin_male = {},
                                skin_female = {}
                            }
                            debug2(ESX.DumpTable(newGradeTable))
                            TriggerServerEvent("ludaro_jobs:addgrade", v.name, newGradeTable)
                            _menuPool:CloseAllMenus()
                            openadminmenu()
                        end
                    end
                    grade.SubMenu:AddItem(creategrade)

                    interactions = _menuPool:AddSubMenu(jobsmenu.SubMenu, locale("interactions"), "")
                    interactions.Item:RightLabel(">")

                    local sortedInteractions = {}
                    for k, v in pairs(Config.Interactions) do
                        table.insert(sortedInteractions, v)
                    end
                    table.sort(sortedInteractions, function(a, b) return a.prio < b.prio end)
                    for _, inter in ipairs(sortedInteractions) do
                        interactionitem = _menuPool:AddSubMenu(interactions.SubMenu, inter.name, "")
                        -- interactionss = lib.callback.await('ludaro_jobs:getinteractions', false, v.name)
                        if tonumber(interactionss) == 0 or interactionss == false or interactionss == true
                            or interactionss == nil then
                            isiconinjob = "❌"
                        else
                            interactionss = json.decode(interactionss)
                            local foundMatch = false
                            for z, u in pairs(interactionss) do
                                ----(getinteractionname(u), inter.name)
                                if getinteractionname(u) == inter.name then
                                    foundMatch = true
                                    break
                                end
                            end
                            if foundMatch then
                                isiconinjob = "✅"
                            else
                                isiconinjob = "❌"
                            end
                        end

                        interactionitem.Item:RightLabel(isiconinjob or "|" .. inter.prio .. " | " .. isiconinjob)
                        local prio = NativeUI.CreateItem(locale("prio"), "")
                        local name = NativeUI.CreateItem(locale("name"), "")
                        local icon = NativeUI.CreateItem(locale("icon"), "")
                        prio:RightLabel(inter.prio)
                        name:RightLabel(inter.name)
                        icon:RightLabel(inter.icon)
                        interactionitem.SubMenu:AddItem(prio)
                        interactionitem.SubMenu:AddItem(name)
                        interactionitem.SubMenu:AddItem(icon)
                        if isiconinjob == "❌" then
                            local deleteinter = _menuPool:AddSubMenu(interactionitem.SubMenu, locale("addinteraction"),
                                "")
                            deleteinter.Item:RightLabel(">")
                            if middleitem then
                                deleteinter.Item._Text.Padding = { X = 180 }
                            end
                            local yes = NativeUI.CreateItem(locale("yes"), "")
                            deleteinter.SubMenu:AddItem(yes)
                            yes.Activated = function(sender, index)
                                TriggerServerEvent("ludaro_jobs:addinteraction", v.name, inter.name)
                                _menuPool:CloseAllMenus()
                                openadminmenu()
                            end
                        else
                            local deleteinter = _menuPool:AddSubMenu(interactionitem.SubMenu, locale("removeinteraction"),
                                "")
                            deleteinter.Item:RightLabel(">")
                            if middleitem then
                                deleteinter.Item._Text.Padding = { X = 180 }
                            end
                            local yes = NativeUI.CreateItem(locale("yes"), "")
                            deleteinter.SubMenu:AddItem(yes)
                            yes.Activated = function(sender, index)
                                TriggerServerEvent("ludaro_jobs:removeinteraction", v.name, inter.name)
                                _menuPool:CloseAllMenus()
                                openadminmenu()
                            end
                        end
                    end

                    society = v.society

                    if society == false then
                        local createsociety = NativeUI.CreateItem(locale("createsociety"), "")
                        jobsmenu.SubMenu:AddItem(createsociety)
                        createsociety.Activated = function(sender, index)
                            TriggerServerEvent("ludaro_jobs:createsociety", v.name)
                            _menuPool:CloseAllMenus()
                            openadminmenu()
                        end
                    else
                        local societymoney = NativeUI.CreateItem(locale("society-money"), "")
                        societymoney:RightLabel(society or 0 .. locale("$"))

                        societymoney.Activated = function(sender, index)
                            newsocietymoney = KeyboardInput(locale("insertmoney"), "", 30)
                            if newsocietymoney == nil then
                                newsocietymoney = society
                            end
                            societymoney:RightLabel(newsocietymoney .. locale("$"))
                        end
                        jobsmenu.SubMenu:AddItem(societymoney)
                    end



                    --  coords2 = NativeUI.CreateItem(locale("coords"), VectorToString(GetEntityCoords(PlayerPedId())))
                    --     coords2.Activated = function(sender, index)
                    --         coords2:RightLabel(VectorToString(GetEntityCoords(PlayerPedId())))
                    --         table.insert(changestuff, { job = v.label, bossmenu = GetEntityCoords(PlayerPedId())})
                    --     end
                    --     jobsmenu.SubMenu:AddItem(coords2)

                    bossmenumenu = _menuPool:AddSubMenu(jobsmenu.SubMenu, locale("bossmenu"), "")
                    bossmenumenu.Item:RightLabel(">")
                    bossmenu = NativeUI.CreateItem(locale("bossmenucoords"), "")
                    bossmenumenu.SubMenu:AddItem(bossmenu)

                    jobinfoo = json.decode(v.jobinfo)

                    if Config.Marker then
                        marker = _menuPool:AddSubMenu(bossmenumenu.SubMenu, locale("marker"), "")
                        marker.Item:RightLabel(">")

                        markertypes = {}
                        for i = 1, 43 do
                            table.insert(markertypes, i)
                        end

                        colors = {}
                        for i = 1, 255 do
                            table.insert(colors, i)
                        end

                        markertype = NativeUI.CreateListItem(locale("markerid"), markertypes, 1, "")
                        marker.SubMenu:AddItem(markertype)

                        scale = _menuPool:AddSubMenu(marker.SubMenu, locale("scale"), "")
                        scale.Item:RightLabel(">")

                        scalex = NativeUI.CreateItem(locale("scalex"), "")
                        scale.SubMenu:AddItem(scalex)
                        scaley = NativeUI.CreateItem(locale("scaley"), "")
                        scale.SubMenu:AddItem(scaley)
                        scalez = NativeUI.CreateItem(locale("scalez"), "")
                        scale.SubMenu:AddItem(scalez)


                        offset = _menuPool:AddSubMenu(marker.SubMenu, locale("offset"), "")
                        offset.Item:RightLabel(">")

                        xoffset = NativeUI.CreateItem(locale("xoffset"), "")
                        offset.SubMenu:AddItem(xoffset)
                        yoffset = NativeUI.CreateItem(locale("yoffset"), "")
                        offset.SubMenu:AddItem(yoffset)
                        zoffset = NativeUI.CreateItem(locale("zoffset"), "")
                        offset.SubMenu:AddItem(zoffset)


                        color = _menuPool:AddSubMenu(marker.SubMenu, locale("color"), "")
                        color.Item:RightLabel(">")

                        red = NativeUI.CreateListItem(locale("red"), colors, jobinfoo.markerred or 255, "")
                        color.SubMenu:AddItem(red)
                        green = NativeUI.CreateListItem(locale("green"), colors, jobinfoo.markergreen or 255, "")
                        color.SubMenu:AddItem(green)
                        blue = NativeUI.CreateListItem(locale("blue"), colors, jobinfoo.markerblue or 255, "")
                        color.SubMenu:AddItem(blue)
                        alpha = NativeUI.CreateListItem(locale("alpha"), colors, jobinfoo.markeralpha or 255, "")
                        color.SubMenu:AddItem(alpha)
                        coloritem = NativeUI.CreateItem(locale("color"), "")

                        -- here
                        color.SubMenu.OnListChange = function(sender, index, number)
                            if index.Base.Text._Text == locale("red") then
                                local found = false
                                for i, y in ipairs(changestuff) do
                                    --(y.job, v.label, y.markerred)

                                    if y.job == v.label and y.markerred ~= nil then
                                        y.markerred = number
                                        found = true
                                    end
                                end
                                if not found then
                                    table.insert(changestuff, { job = v.label, markerred = number })
                                end
                            elseif index.Base.Text._Text == locale("green") then
                                local found = false
                                for i, y in ipairs(changestuff) do
                                    --   --(y.job == v.label and y.markergreen ~= nil)

                                    if y.job == v.label and y.markergreen ~= nil then
                                        -- --("ah")
                                        y.markergreen = number
                                        found = true
                                    end
                                end
                                if not found then
                                    table.insert(changestuff, { job = v.label, markergreen = number })
                                end
                            elseif index.Base.Text._Text == locale("blue") then
                                local found = false
                                for i, y in ipairs(changestuff) do
                                    if y.job == v.label and y.markerblue ~= nil then
                                        y.markerblue = number
                                        found = true
                                    end
                                end
                                if not found then
                                    table.insert(changestuff, { job = v.label, markerblue = number })
                                end
                            elseif index.Base.Text._Text == locale("alpha") then
                                local found = false
                                for i, y in ipairs(changestuff) do
                                    if y.job == v.label and y.markeralpha ~= nil then
                                        y.markeralpha = alpha
                                        found = true
                                    end
                                end
                                if not found then
                                    table.insert(changestuff, { job = v.label, markeralpha = number })
                                end
                            end
                            --coloritem:SetTextHoveredColor(redindex or 255, greenindex or 255, blueindex or 255, alphaindex or 255)
                        end





                        -- marker.SubMenu:AddItem(red)
                        -- marker.SubMenu:AddItem(green)
                        -- marker.SubMenu:AddItem(blue)
                        -- marker.SubMenu:AddItem(alpha)
                        bobupanddown = NativeUI.CreateCheckboxItem(locale("bobupanddown"), false, "")
                        marker.SubMenu:AddItem(bobupanddown)

                        facecamera = NativeUI.CreateCheckboxItem(locale("facecamera"), false, "")
                        marker.SubMenu:AddItem(facecamera)
                        markerenabled = NativeUI.CreateCheckboxItem(locale("markerenabled"), false, "")
                        marker.SubMenu:AddItem(markerenabled)
                        bobupanddown.Checked = json.decode(v.jobinfo).markerbobupanddown or false
                        facecamera.Checked = json.decode(v.jobinfo).markerfacecamera or false
                        markerenabled.Checked = json.decode(v.ludaro_jobs_info).markerenabled or false

                        marker.SubMenu.OnListChange = function(sender, index, number)
                            table.insert(changestuff, { job = v.label, markerid = number })
                        end

                        scalex.Activated = function(sender, index)
                            newscalex = KeyboardInput(locale("insertscale"), "", 30)
                            if tonumber(newscalex) ~= nil then
                                index.Label.Text._Text = newscalex
                                table.insert(changestuff, { job = v.label, scalex = newscalex })
                                --("what")
                            else
                                Config.Notify(locale("nonumber"))
                            end
                        end

                        scaley.Activated = function(sender, index)
                            newscaley = KeyboardInput(locale("insertscale"), "", 30)
                            if tonumber(newscaley) ~= nil then
                                index.Label.Text._Text = newscaley
                                table.insert(changestuff, { job = v.label, scaley = newscaley })
                            else
                                Config.Notify(locale("nonumber"))
                            end
                        end

                        scalez.Activated = function(sender, index)
                            newscalez = KeyboardInput(locale("insertscale"), "", 30)
                            if tonumber(newscalez) ~= nil then
                                index.Label.Text._Text = newscalez
                                table.insert(changestuff, { job = v.label, scalez = newscalez })
                            else
                                Config.Notify(locale("nonumber"))
                            end
                        end

                        xoffset.Activated = function(sender, index)
                            newxoffset = KeyboardInput(locale("insertscale"), "", 30)
                            if tonumber(newxoffset) ~= nil then
                                index.Label.Text._Text = newxoffset
                                table.insert(changestuff, { job = v.label, xoffset = newxoffset })
                            else
                                Config.Notify(locale("nonumber"))
                            end
                        end

                        yoffset.Activated = function(sender, index)
                            newyoffset = KeyboardInput(locale("insertscale"), "", 30)
                            if tonumber(newyoffset) ~= nil then
                                index.Label.Text._Text = newyoffset
                                table.insert(changestuff, { job = v.label, yoffset = newyoffset })
                            else
                                Config.Notify(locale("nonumber"))
                            end
                        end

                        zoffset.Activated = function(sender, index)
                            newzoffset = KeyboardInput(locale("insertscale"), "", 30)
                            if tonumber(newzoffset) ~= nil then
                                index.Label.Text._Text = newzoffset
                                table.insert(changestuff, { job = v.label, zoffset = newzoffset })
                            else
                                Config.Notify(locale("nonumber"))
                            end
                        end

                        bobupanddown.CheckboxEvent = function(menu, item, checked)
                            table.insert(changestuff, { job = v.label, markerbobupanddown = checked })
                        end

                        -- rotate.CheckboxEvent = function(menu, item, checked)
                        --     table.insert(changestuff, { job = v.label, markerrotate = checked})
                        -- end

                        facecamera.CheckboxEvent = function(menu, item, checked)
                            table.insert(changestuff, { job = v.label, markerfacecamera = checked })
                        end

                        markerenabled.CheckboxEvent = function(menu, item, checked)
                            table.insert(changestuff, { job = v.label, markerenabled = checked })
                        end
                    end
                    if Config.NPC then
                        npc = _menuPool:AddSubMenu(bossmenumenu.SubMenu, locale("NPC"), "")
                        npc.Item:RightLabel(">")

                        offset = _menuPool:AddSubMenu(npc.SubMenu, locale("offset"), "")
                        offset.Item:RightLabel(">")

                        xoffset = NativeUI.CreateItem(locale("xoffset"), "")
                        offset.SubMenu:AddItem(xoffset)
                        yoffset = NativeUI.CreateItem(locale("yoffset"), "")
                        offset.SubMenu:AddItem(yoffset)
                        zoffset = NativeUI.CreateItem(locale("zoffset"), "")
                        offset.SubMenu:AddItem(zoffset)

                        xoffset.Activated = function(sender, index)
                            newxoffset = KeyboardInput(locale("insertscale"), "", 30)
                            if tonumber(newxoffset) ~= nil then
                                index.Label.Text._Text = newxoffset
                                table.insert(changestuff, { job = v.label, xoffsetnpc = newxoffset })
                            else
                                Config.Notify(locale("nonumber"))
                            end
                        end

                        yoffset.Activated = function(sender, index)
                            newyoffset = KeyboardInput(locale("insertscale"), "", 30)
                            if tonumber(newyoffset) ~= nil then
                                index.Label.Text._Text = newyoffset
                                table.insert(changestuff, { job = v.label, yoffsetnpc = newyoffset })
                            else
                                Config.Notify(locale("nonumber"))
                            end
                        end

                        zoffset.Activated = function(sender, index)
                            newzoffset = KeyboardInput(locale("insertscale"), "", 30)
                            if tonumber(newzoffset) ~= nil then
                                index.Label.Text._Text = newzoffset
                                table.insert(changestuff, { job = v.label, zoffsetnpc = newzoffset })
                            else
                                Config.Notify(locale("nonumber"))
                            end
                        end

                        model = NativeUI.CreateItem(locale("model"), "")
                        npc.SubMenu:AddItem(model)
                        model.Activated = function(sender, index)
                            newmodel = KeyboardInput(locale("insertmodel"), "", 30)
                            if tostring(newmodel) ~= nil then
                                index.Label.Text._Text = newmodel
                                table.insert(changestuff, { job = v.label, npcmodel = newmodel })
                            else
                                Config.Notify(locale("nonumber"))
                            end
                        end


                        heading = NativeUI.CreateItem(locale("heading"), "")
                        npc.SubMenu:AddItem(heading)
                        heading.Activated = function(sender, index)
                            newheading = KeyboardInput(locale("insertheading"), "", 30)
                            if tonumber(newheading) ~= nil then
                                index.Label.Text._Text = newheading
                                table.insert(changestuff, { job = v.label, npcheading = newheading })
                            else
                                Config.Notify(locale("nonumber"))
                            end
                        end

                        npcenabled = NativeUI.CreateCheckboxItem(locale("npcenabled"), false, "")
                        npc.SubMenu:AddItem(npcenabled)
                        npcenabled.CheckboxEvent = function(menu, item, checked)
                            table.insert(changestuff, { job = v.label, npcenabled = checked })
                        end


                        -- merken: xoffsetnpc, yoffsetnpc, zoffsetnpc, npcmodel, npcheading
                    end



                    ----(bossmenucoords)
                    bossmenucoords_table = json.decode(v.jobinfo).bossmenu
                    if type(bossmenucoords_table) == "table" then
                        bossmenucoords = VectorToString(vector3(bossmenucoords_table.x, bossmenucoords_table.y,
                            bossmenucoords_table.z))
                        bossmenu:RightLabel(bossmenucoords)
                    end


                    bossmenu.Activated = function(sender, index)
                        index.Label.Text._Text = VectorToString(GetEntityCoords(PlayerPedId()))
                        table.insert(changestuff, { job = v.label, bossmenu = GetEntityCoords(PlayerPedId()) })
                    end






                    deletejob = _menuPool:AddSubMenu(jobsmenu.SubMenu, locale("deletejob"), "")
                    if middleitem then
                        deletejob.Item._Text.Padding = { X = 180 }
                    end

                    deletejob.Item:RightLabel(">")

                    yes = NativeUI.CreateItem(locale("yes"), "")
                    deletejob.SubMenu:AddItem(yes)

                    yes.Activated = function(sender, index)
                        TriggerServerEvent("ludaro_jobs:deletejob", v.name)
                        table.insert(deletedjobs, v.name)
                        _menuPool:CloseAllMenus()
                        openadminmenu()
                    end



                    confirm = _menuPool:AddSubMenu(jobsmenu.SubMenu, locale("confirm"), "")
                    confirm.Item:RightLabel(">")
                    if middleitem then
                        confirm.Item._Text.Padding = { X = 180 }
                    end








                    yes = NativeUI.CreateItem(locale("yes"), "")
                    confirm.SubMenu:AddItem(yes)

                    yes.Activated = function(sender, index)
                        print(ESX.DumpTable(changestuff))
                        for k, v in pairs(changestuff) do
                            if v.name then
                                --("ah")
                                TriggerServerEvent("ludaro_jobs:changename", v.job, v.name)
                                Citizen.Wait(1000)
                            end
                            if v.label then
                                TriggerServerEvent("ludaro_jobs:labelch", v.job, v.label)
                                Citizen.Wait(1000)
                            end
                            if v.whitelist ~= nil then
                                TriggerServerEvent("ludaro_jobs:setwhitelist", v.job, v.whitelist)
                                Citizen.Wait(1000)
                            end
                            if v.bossmenu then
                                menuclosed = true
                                TriggerServerEvent("ludaro_jobs:setbossmenu", v.job, v.bossmenu)
                                Citizen.Wait(1000)
                            end
                            if v.markerred then
                                TriggerServerEvent("ludaro_jobs:setmarkerred", v.job, v.markerred)
                                Citizen.Wait(1000)
                            end
                            if v.markerblue then
                                TriggerServerEvent("ludaro_jobs:setmarkerblue", v.job, v.markerblue)
                                Citizen.Wait(1000)
                            end
                            if v.markergreen then
                                TriggerServerEvent("ludaro_jobs:setmarkergreen", v.job, v.markergreen)
                                Citizen.Wait(1000)
                            end
                            if v.markeralpha then
                                TriggerServerEvent("ludaro_jobs:setmarkeralpha", v.job, v.markeralpha)
                                Citizen.Wait(1000)
                            end
                            if v.markerid then
                                TriggerServerEvent("ludaro_jobs:setmarkerid", v.job, v.markerid)
                                Citizen.Wait(1000)
                            end
                            if v.markerbobupanddown then
                                TriggerServerEvent("ludaro_jobs:setmarkerbobupanddown", v.job, v.markerbobupanddown)
                                Citizen.Wait(1000)
                            end
                            if v.markerfacecamera then
                                TriggerServerEvent("ludaro_jobs:setmarkerfacecamera", v.job, v.markerfacecamera)
                                Citizen.Wait(1000)
                            end
                            if v.scalex then
                                --("what")
                                TriggerServerEvent("ludaro_jobs:setmarkerscalex", v.job, v.scalex)
                                Citizen.Wait(1000)
                            end
                            if v.scaley then
                                TriggerServerEvent("ludaro_jobs:setmarkerscaley", v.job, v.scaley)
                                Citizen.Wait(1000)
                            end
                            if v.scalez then
                                TriggerServerEvent("ludaro_jobs:setmarkerscalez", v.job, v.scalez)
                                Citizen.Wait(1000)
                            end
                            if v.xoffset then
                                TriggerServerEvent("ludaro_jobs:setmarkerxoffset", v.job, v.xoffset)
                                Citizen.Wait(1000)
                            end
                            if v.yoffset then
                                TriggerServerEvent("ludaro_jobs:setmarkeryoffset", v.job, v.yoffset)
                                Citizen.Wait(1000)
                            end
                            if v.zoffset then
                                TriggerServerEvent("ludaro_jobs:setmarkerzoffset", v.job, v.zoffset)
                                Citizen.Wait(1000)
                            end
                            if v.markerenabled then
                                TriggerServerEvent("ludaro_jobs:setmarkerenabled", v.job, v.markerenabled)
                                Citizen.Wait(1000)
                            end
                            if v.xoffsetnpc then
                                TriggerServerEvent("ludaro_jobs:setxoffsetnpc", v.job, v.xoffsetnpc)
                                Citizen.Wait(1000)
                            end
                            if v.yoffsetnpc then
                                TriggerServerEvent("ludaro_jobs:setyoffsetnpc", v.job, v.yoffsetnpc)
                                Citizen.Wait(1000)
                            end
                            if v.zoffsetnpc then
                                TriggerServerEvent("ludaro_jobs:setzoffsetnpc", v.job, v.zoffsetnpc)
                                Citizen.Wait(1000)
                            end
                            print(v.npcmodel)
                            if v.npcmodel then
                                TriggerServerEvent("ludaro_jobs:setnpcmodel", v.job, v.npcmodel)
                                Citizen.Wait(1000)
                            end
                            if v.npcheading then
                                TriggerServerEvent("ludaro_jobs:setnpcheading", v.job, v.npcheading)
                                Citizen.Wait(1000)
                            end
                            if v.npcenabled then
                                TriggerServerEvent("ludaro_jobs:setnpcenabled", v.job, v.npcenabled)
                                Citizen.Wait(1000)
                            end
                        end
                        _menuPool:CloseAllMenus()
                        openadminmenu()
                    end
                end
            end

            mainmenu:Visible(true)
            -- lib.hideTextUI()

            addjob = _menuPool:AddSubMenu(mainmenu, locale("addjob"), "")
            addjob.Item:RightLabel(">")
            -- to add new job
            _menuPool:RefreshIndex()
            _menuPool:MouseControlsEnabled(false)
            _menuPool:MouseEdgeEnabled(false)
            _menuPool:ControlDisablingEnabled(false)
            name = NativeUI.CreateItem(locale("name"), "")
            addjob.SubMenu:AddItem(name)
            label = NativeUI.CreateItem(locale("label"), "")
            label.Activated = function(sender, index)
                newlabel = KeyboardInput(locale("insertname"), "", 30)
                if newlabel then
                    label:RightLabel(newlabel)
                end
            end
            name.Activated = function(sender, index)
                newname = KeyboardInput(locale("insertname"), "", 30)
                if newname then
                    name:RightLabel(newname)
                end
            end
            addjob.SubMenu:AddItem(label)
            isWhitelistedadd = NativeUI.CreateCheckboxItem(locale("whitelisted"), false, "")
            addjob.SubMenu:AddItem(isWhitelistedadd)

            grades = _menuPool:AddSubMenu(addjob.SubMenu, locale("grades"), "")
            _menuPool:RefreshIndex()
            _menuPool:MouseControlsEnabled(false)
            _menuPool:MouseEdgeEnabled(false)
            _menuPool:ControlDisablingEnabled(false)

            grades.Item:RightLabel(">")
            addgrade = NativeUI.CreateItem(locale("addgrade"), "")




            grades.SubMenu:AddItem(addgrade)
            confirm = _menuPool:AddSubMenu(addjob.SubMenu, locale("confirm"), "")
            confirm.Item:RightLabel(">")


            _menuPool:RefreshIndex()
            _menuPool:MouseControlsEnabled(false)
            _menuPool:MouseEdgeEnabled(false)
            _menuPool:ControlDisablingEnabled(false)
            yes = NativeUI.CreateItem(locale("yes"), "")
            confirm.SubMenu:AddItem(yes)



            yes.Activated = function(sender, index)
                TriggerServerEvent("ludaro_jobs:createjob", newname, newlabel, gradess)
                --    Config.Notify(locale("success"))
                if newsocietymoney then
                    TriggerServerEvent("ludaro_jobs:setsocietyaccount", v.name or newname, newsocietymoney)
                end
                _menuPool:CloseAllMenus()
                openadminmenu()
            end
        end
        gradess = {}
        addgrade.Activated = function(sender, index)
            -- create a grade
            newgrade = KeyboardInput(locale("insertname"), "", 30)
            newgradelabel = KeyboardInput(locale("insertlabel"), "", 30)

            if newgrade ~= "" and newgradelabel ~= "" then
                newgradesalary = KeyboardInput(locale("insertsalary"), "", 30)
                if tonumber(newgradesalary) ~= nil then
                else
                    -- Code to execute if newgradesalary is not a number
                    Config.Notify(locale("nonumber"))
                    newgradesalary = KeyboardInput(locale("insertsalary"), "", 30)
                end

                if tonumber(newgradesalary) ~= nil then
                    salary = 0
                end


                local newGradeTable = {
                    grade = 0,
                    name = newgrade,
                    label = newgradelabel,
                    salary = 0,
                    skin_male = {},
                    skin_female = {}
                }
                table.insert(gradess, newGradeTable)

                -- Insert the new grade table under name, salary, and label
                createdItems = {}
                for k, v in pairs(gradess) do
                    for k, v in pairs(gradess) do
                        if not createdItems[v.name] then
                            gradecreated = NativeUI.CreateItem(v.name .. " (" .. v.label .. ")", "")
                            grades.SubMenu:AddItem(gradecreated)
                            gradecreated:RightLabel(k - 1 .. " | " .. v.salary .. locale("$"))
                            createdItems[v.name] = true
                        end
                    end
                end
            end
        end
    end
end
function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

function VectorToString(vector)
    if type(vector) == "vector3" then
        return "(" .. math.round(vector.x) .. ", " .. math.round(vector.y) .. ", " .. math.round(vector.z) .. ")"
    elseif type(vector) == "vector4" then
        return "(" ..
            math.round(vector.x) ..
            ", " .. math.round(vector.y) .. ", " .. math.round(vector.z) .. ", " .. math.round(vector.w) .. ")"
    else
        return "NONE"
    end
end
