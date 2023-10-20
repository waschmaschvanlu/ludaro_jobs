Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        consoleLog("Updating jobinfo..", 4)
        jobs = sql_getAllJobInfo()
        for k, v in pairs(jobs) do
            v.ludaro_jobs_info = json.decode(v.ludaro_jobs_info)
            v.ludaro_jobs_info = v.ludaro_jobs_info or {}
            jobs[k] = v
        end
    end
end)
