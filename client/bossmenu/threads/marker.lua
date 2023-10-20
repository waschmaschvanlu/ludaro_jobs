if Config.Marker then
    jobs = sql_getAllJobInfo()
    for k, v in pairs(jobs) do
        v.ludaro_jobs_info = json.decode(v.ludaro_jobs_info)
        v.ludaro_jobs_info = v.ludaro_jobs_info or {}
        jobs[k] = v
    end
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            for k, v in pairs(jobs) do
                if v.ludaro_jobs_info.markerenabled and v.ludaro_jobs_info.bossmenu ~= nil and v.ludaro_jobs_info.bossmenu.x and v.ludaro_jobs_info.bossmenu.z and v.ludaro_jobs_info.bossmenu.y then
                    marker = Config.DefaultMarker

                    DrawMarker(v.ludaro_jobs_info.markerType or marker.markerType,
                        v.ludaro_jobs_info.bossmenu.x or marker.x,
                        v.ludaro_jobs_info.bossmenu.y or marker.y,
                        v.ludaro_jobs_info.bossmenu.z or marker.z, v.ludaro_jobs_info.xoffset or marker.xoffset,
                        v.ludaro_jobs_info.yoffset or marker.yoffset,
                        v.ludaro_jobs_info.zoffset or marker.zoffset, 0.0, 0.0, 0.0,
                        v.ludaro_jobs_info.scalex or marker.scalex,
                        v.ludaro_jobs_info.scaley or marker.scaley,
                        v.ludaro_jobs_info.scalez or marker.scalez,
                        v.ludaro_jobs_info.markerred or marker.red,
                        v.ludaro_jobs_info.markergreen or marker.green,
                        v.ludaro_jobs_info.markerblue or marker.blue,
                        v.ludaro_jobs_info.markeralpha or marker.alpha,
                        v.ludaro_jobs_info.markerbobupanddown or marker.bobupanddown,
                        v.ludaro_jobs_info.markerfacecamera or marker.facecamera,
                        v.ludaro_jobs_info.markerenabled or marker.markerenabled)
                end
            end
        end
    end)
end
-- markeroffset still WIP in menu aswell, BUT YES IT WORKS!!!!!!!!!!
