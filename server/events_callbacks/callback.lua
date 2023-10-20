-- FRAMEWORK
lib.callback.register('ludaro_jobs:getGroup', function(source)
    return framework_cb_getGroup(source)
end)
-- FRAMEWORK END

-- ADDONACCOUNT DATA
lib.callback.register('ludaro_jobs:getsocietyaccount', function(source, name)
    return cb_getSocietyAccount(name)
end)

lib.callback.register('ludaro_jobs:setsocietyaccount', function(source, name, howmuch)
    return cb_setSocietyAccount(name, howmuch)
end)

lib.callback.register('ludaro_jobs:addtosocietyaccount', function(source, name, howmuch)
    return cb_AddSocietyAccount(name, howmuch)
end)


lib.callback.register('ludaro_jobs:takefromsocietyaccount', function(source, name, howmuch)
    return cb_takeFromSocietyAccount(name, howmuch)
end)
-- ADDON ACCOUNT DATA END


-- JOB STUFF
lib.callback.register('ludaro_jobs:doesjobexist', function(source, name)
    return lib.table.contains(ESX.GetJobs(), name)
end)


lib.callback.register('ludaro_jobs:getgrade', function(source, id)
    return ESX.GetPlayerFromId(id or source).job.grade
end)

lib.callback.register('ludaro_jobs:getjoblabel', function(source, id)
    return ESX.GetPlayerFromId(id or source).job.label
end)

lib.callback.register('ludaro_jobs:getgradename', function(source, id)
    return ESX.GetPlayerFromId(id or source).job.grade_name
end)

lib.callback.register('ludaro_jobs:getjobname', function(source, id)
    return sql_getJob(source or id)
end)

lib.callback.register('ludaro_jobs:getjobs', function(source, id)
    jobs = cb_getJobs()
    for k, v in pairs(jobs) do
        v.whitelist = false or sql_getWhitelist(v.name)
        v.society = false or cb_getSocietyAccount(v.name)
        v.jobinfo = sql_getJobInfo(v.label)
        --(v.jobinfo)
    end

    return jobs
end)
-- JOB STUFF END

-- INTERACTIONS
lib.callback.register('ludaro_jobs:getinteractions', function(source, job)
    return getinteractions(job)
end)

lib.callback.register('ludaro_jobs:getwhitelist', function(source, job)
    return sql_getWhitelist(job)
end)

lib.callback.register('ludaro_jobs:getjobinfo', function(source, job, value)
    return sql_getJobInfo(job)
end)


lib.callback.register('ludaro_jobs:getalljobinfo', function(source, job, value)
    return sql_getAllJobInfo()
end)
