Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        debug2("Updating jobinfo..", 4)
        jobs = getalljobinfo()
        for k, v in pairs(jobs) do
            v.ludaro_jobs_info = json.decode(v.ludaro_jobs_info)
            v.ludaro_jobs_info = v.ludaro_jobs_info or {}
            jobs[k] = v
        end
    end
end)
