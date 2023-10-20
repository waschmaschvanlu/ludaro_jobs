Config.Notify = function(txt, source)
    if source == nil then
        ESX.ShowNotification(txt)
    else
        xplayer = ESX.GetPlayerFromId(source)
        xplayer.showNotification(txt)
    end
end
Config.TextUI = {}

Config.TextUI.Enterzone = function()
end

Config.TextUI.ExitZone = function()
end

Config.TextUI.ThreadInZone = function()
end
