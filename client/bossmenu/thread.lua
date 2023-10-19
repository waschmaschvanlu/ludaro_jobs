

-- if Config.Marker then
--     local function decodeJsonStrings(table)
--         for _, entry in ipairs(table) do
--             if entry["ludaro_jobs_info"] then
--                 local decoded, _, err = json.decode(entry["ludaro_jobs_info"], 1, nil)
--                 if not err then
--                     entry["ludaro_jobs_info"] = decoded
--                 else
--                     print("Error decoding JSON:", err)
--                 end
--             end
--         end
--     end
    
-- function updateJobMarkers()
--     jobs = getalljobinfo()
--     --print(print(ESX.DumpTable(jobs)))
-- decodeJsonStrings(jobs)


--     for k,v in pairs(jobs) do 
--      v = v.ludaro_jobs_info
--      if v.markerenabled and v.bossmenu ~= nil and v.bossmenu.x and v.bossmenu.z and v.bossmenu.y then
--         marker = Config.DefaultMarker
--         Citizen.CreateThread(function()
--             while true do
--         Citizen.Wait(0)
--        -- print(v.markerType or marker.markerType, v.bossmenu.x or marker.x, v.bossmenu.y or marker.y, v.bossmenu.z or marker.z, v.xoffset or marker.xoffset, v.yoffset or marker.yoffset, v.zoffset or marker.zoffset, 0.0, 0.0, 0.0, v.scalex or marker.scalex, v.scaley or marker.scaley, v.scalez or marker.scalez, v.red or marker.red, v.green or marker.green, v.blue or marker.blue, v.alpha or marker.alpha, v.bobupanddown or marker.bobupanddown, v.facecamera or marker.facecamera, v.markerenabled or marker.markerenabled)
--         DrawMarker(v.markerType or marker.markerType, v.bossmenu.x or marker.x, v.bossmenu.y or marker.y, v.bossmenu.z or marker.z, v.xoffset or marker.xoffset, v.yoffset or marker.yoffset, v.zoffset or marker.zoffset, 0.0, 0.0, 0.0, v.scalex or marker.scalex, v.scaley or marker.scaley, v.scalez or marker.scalez, v.red or marker.red, v.green or marker.green, v.blue or marker.blue, v.alpha or marker.alpha, v.bobupanddown or marker.bobupanddown, v.facecamera or marker.facecamera, v.markerenabled or marker.markerenabled)
--             end
--         end)
       
--     end
-- end
-- end
-- end
-- updateJobMarkers()


-- -- updateJobMarkers()


