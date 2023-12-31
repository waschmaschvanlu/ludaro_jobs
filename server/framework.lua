if (GetResourceState("es_extended") == "started") then
    if (exports["es_extended"] and exports["es_extended"].getSharedObject) then
        ESX = exports["es_extended"]:getSharedObject()
    else
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
end

function framework_cb_getGroup(id)
    return ESX.GetPlayerFromId(id).getGroup() or "user"
end

function framework_locale(msg)
    local translation = Config.Translation[Config.Locale][msg]
    if translation then
        return translation
    else
        return "translation not found: " .. msg
    end
end

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

function framework_getPlayer(source)
    return ESX.GetPlayerFromId(source)
end
