function getinteractionname(interaction)
    interaction = interaction:match("%[\"(.-)\"%]")
    for k, v in pairs(Config.Interactions) do
        -- print(k .. "should be not the same as" .. interaction2)
        if k == interaction then
            return v.name
        else

        end
    end
end

function getinteractioneventtype(interaction)
    if Config.Interactions[string.lower(interaction)] == nil then
        return false
    end
    return Config.Interactions[string.lower(interaction)].eventtype
end

function getinteractioneventname(interaction)
    if Config.Interactions[string.lower(interaction)] == nil then
        return "ludaro_jobs:interactionserror"
    end
    return Config.Interactions[string.lower(interaction)].eventname
end

function getinteractionicon(interaction)
    if Config.Interactions[string.lower(interaction)] == nil then
        return interaction
    end
    return Config.Interactions[string.lower(interaction)].icon
end

function geteventargs(interaction)
    if Config.Interactions[string.lower(interaction)] == nil then
        return false
    end
    return Config.Interactions[string.lower(interaction)].eventargs
end

function getprio(interaction)
    if Config.Interactions[string.lower(interaction)] == nil then
        return false
    end
    return Config.Interactions[string.lower(interaction)].prio
end

function getallinteractions()
    local interactions = {}
    for k, v in pairs(Config.Interactions) do
        table.insert(interactions, k)
    end
    return interactions
end
