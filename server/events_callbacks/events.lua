-- RegisterNetEvent('ludaro_jobs:refreshjobs')
-- AddEventHandler('ludaro_jobs:refreshjobs', function()
--     debug2("refreshing jobs", 2)
-- refreshjobs()
-- end)

RegisterNetEvent('ludaro_jobs:createjob')
AddEventHandler('ludaro_jobs:createjob', function(job_name, job_label, grade)
    debug2("creating job", 2)
    --(job_name, job_label, grade, source)
    createjob(job_name, job_label, grade, source)
end)

RegisterNetEvent('ludaro_jobs:deletejob')
AddEventHandler('ludaro_jobs:deletejob', function(job_name)
    debug2("deleting job", 2)
    deletejob(job_name, source)
end)

RegisterNetEvent('ludaro_jobs:createsociety')
AddEventHandler('ludaro_jobs:createsociety', function(job_name)
    debug2("creating society..", 2)
    created = createsociety(job_name, source)
    --(created)
end)

RegisterNetEvent('ludaro_jobs:addgrade')
AddEventHandler('ludaro_jobs:addgrade', function(job_name, grades)
    debug2("creating grade", 2)
    addgrade(job_name, grades, source)
end)

RegisterNetEvent('ludaro_jobs:deletegrade')
AddEventHandler('ludaro_jobs:deletegrade', function(job_name, grade_name)
    debug2("creating grade", 2)
    deletegrade(job_name, grade_name, source)
end)


RegisterNetEvent('ludaro_jobs:changename')
AddEventHandler('ludaro_jobs:changename', function(old_name, new_name, grade)
    debug2("changing name", 2)
    if grade == nil then
        changename(old_name, new_name, source)
    else
        changegradename(old_name, new_name, grade, source)
    end
end)

RegisterNetEvent('ludaro_jobs:labelch')
AddEventHandler('ludaro_jobs:labelch', function(old_label, new_label, grade)
    debug2("changing label", 2)
    if grade == nil then
        changelabel(old_label, new_label, source)
    else
        changegradelabel(old_label, new_label, grade, source)
    end
end)


RegisterNetEvent('ludaro_jobs:setwhitelist')
AddEventHandler('ludaro_jobs:setwhitelist', function(jobname, value)
    --("ah")
    debug2("changing whitelist", 2)
    --(jobname, value)
    setwhitelist(jobname, value)
end)

RegisterNetEvent('ludaro_jobs:setbossmenu')
AddEventHandler('ludaro_jobs:setbossmenu', function(job, value)
    debug2("changing bossmenu", 2)
    setbossmenu(job, value)
end)


RegisterNetEvent('ludaro_jobs:setmarkerred')
AddEventHandler('ludaro_jobs:setmarkerred', function(job, value)
    debug2("changing marker red", 2)
    setmarkercolor(job, value, nil, nil)
end)

RegisterNetEvent('ludaro_jobs:setmarkergreen')
AddEventHandler('ludaro_jobs:setmarkergreen', function(job, value)
    debug2("changing marker green", 2)
    setmarkercolor(job, nil, value, nil)
end)


RegisterNetEvent('ludaro_jobs:setmarkerblue')
AddEventHandler('ludaro_jobs:setmarkerblue', function(job, value)
    debug2("changing marker blue", 2)
    setmarkercolor(job, nil, nil, value)
end)


RegisterNetEvent('ludaro_jobs:setmarkeralpha')
AddEventHandler('ludaro_jobs:setmarkeralpha', function(job, value)
    debug2("changing marker alpha", 2)
    updatejobinfo(job, nil, nil, nil, value)
end)

RegisterNetEvent('ludaro_jobs:setmarkerid')
AddEventHandler('ludaro_jobs:setmarkerid', function(job, value)
    debug2("changing marker", 2)
    setmarkerid(job, value)
end)


RegisterNetEvent('ludaro_jobs:setmarkerbobupanddown')
AddEventHandler('ludaro_jobs:setmarkerbobupanddown', function(job, value)
    debug2("changing marker bobupanddown", 2)
    setmarkerbobupanddown(job, value)
end)

RegisterNetEvent('ludaro_jobs:setmarkerfacecamera')
AddEventHandler('ludaro_jobs:setmarkerfacecamera', function(job, value)
    debug2("changing marker facecamera", 2)
    setmarkerfacecamera(job, value)
end)

-- scalex
RegisterNetEvent('ludaro_jobs:setmarkerscalex')
AddEventHandler('ludaro_jobs:setmarkerscalex', function(job, value)
    debug2("changing marker scalex", 2)
    setmarkerscalex(job, value)
end)

-- scaley
RegisterNetEvent('ludaro_jobs:setmarkerscaley')
AddEventHandler('ludaro_jobs:setmarkerscaley', function(job, value)
    debug2("changing marker scaley", 2)
    setmarkerscaley(job, value)
end)

-- scalez
RegisterNetEvent('ludaro_jobs:setmarkerscalez')
AddEventHandler('ludaro_jobs:setmarkerscalez', function(job, value)
    debug2("changing marker scalez", 2)
    setmarkerscalez(job, value)
end)


RegisterNetEvent('ludaro_jobs:setxoffset')
AddEventHandler('ludaro_jobs:setmarkerxoffset', function(job, value)
    debug2("changing marker xoffset", 2)
    setmarkerxoffset(job, value)
end)

RegisterNetEvent('ludaro_jobs:setyoffset')
AddEventHandler('ludaro_jobs:setmarkeryoffset', function(job, value)
    debug2("changing marker yoffset", 2)
    setmarkeryoffset(job, value)
end)

RegisterNetEvent('ludaro_jobs:setzoffset')
AddEventHandler('ludaro_jobs:setmarkerzoffset', function(job, value)
    debug2("changing marker zoffset", 2)
    setmarkerzoffset(job, value)
end)

RegisterNetEvent('ludaro_jobs:setmarkerenabled')
AddEventHandler('ludaro_jobs:setmarkerenabled', function(job, value)
    debug2("changing marker enabled", 2)
    setmarkerenabled(job, value)
end)


RegisterNetEvent('ludaro_jobs:setxoffsetnpc')
AddEventHandler('ludaro_jobs:setmarkerxoffsetnpc', function(job, value)
    debug2("changing marker xoffsetnpc", 2)
    setmarkerxoffsetnpc(job, value)
end)

RegisterNetEvent('ludaro_jobs:setyoffsetnpc')
AddEventHandler('ludaro_jobs:setmarkeryoffsetnpc', function(job, value)
    debug2("changing marker yoffsetnpc", 2)
    setmarkeryoffsetnpc(job, value)
end)

RegisterNetEvent('ludaro_jobs:setzoffsetnpc')
AddEventHandler('ludaro_jobs:setmarkerzoffsetnpc', function(job, value)
    debug2("changing marker zoffsetnpc", 2)
    setmarkerzoffsetnpc(job, value)
end)



RegisterNetEvent('ludaro_jobs:setnpcmodel')
AddEventHandler('ludaro_jobs:setnpcmodel', function(job, value)
    debug2("changing npc model", 2)
    setnpcmodel(job, value)
end)


RegisterNetEvent('ludaro_jobs:setnpcenabled')
AddEventHandler('ludaro_jobs:setnpcenabled', function(job, value)
    debug2("changing npc enabled", 2)
    setnpcenabled(job, value)
end)

-- "ludaro_jobs:setnpcheading
RegisterNetEvent('ludaro_jobs:setnpcheading')
AddEventHandler('ludaro_jobs:setnpcheading', function(job, value)
    debug2("changing npc heading", 2)
    setnpcheading(job, value)
end)
