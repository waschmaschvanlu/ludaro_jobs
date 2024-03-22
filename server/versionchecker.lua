resource = GetCurrentResourceName()
Name = GetResourceMetadata(resource, 'name', 0)
Github = GetResourceMetadata(resource, 'github', 0)
Version = GetResourceMetadata(resource, 'version', 0)
rawfxmanifest = GetResourceMetadata(resource, 'fx_raw', 0)
updatefile = GetResourceMetadata(resource, 'changelogfile', 0)
function getNumberFromString(str)
    local number = tonumber(string.match(str, '%d+%.?%d*'))
    return number
end

PerformHttpRequest(rawfxmanifest, function(Error, V, Header)
if Error ~= 200 then
    print("ERROR WHILE CHECKING VERSION!! Error-Code: " .. Error)
    return
end
    local function getVersionFromV(V)
        local version = string.match(tostring(V), 'version "(.-)"')
        return version
    end
    newestversion = getVersionFromV(V)
    numberversion = getNumberFromString(Version)
    numbernewestversion = getNumberFromString(newestversion)

    
NewestVersion = 0

print('^0--------------------------------------------------------------------')
print("^3Ludaro-Jobs Version-Checker!")
print(numberversion, numbernewestversion)
if numberversion == nil or numbernewestversion == nil then
    print("Error with checking for updates! Current version: " .. Version .. " Newest Version:" .. numbernewestversion.. ' ^0('..Github..')')
elseif numberversion >= numbernewestversion  then

    print("^2"..resource.." ^1✓ ^5- Up to date! Version: ^0" .. Version .. ' Github: ^0('..Github..')')
    if Config.Debug >= 2 then
    print("Thanks for using Ludaro_Jobs ur Awesome!  because debug is on, here is a random message for  you:")
    printRandomString(randomfivemfunfacts)
    end
  
    
 
else
    print('^4' .. (resource) .. ' ^1✗ ^5- Outdated! ^0' .. " | your version: " .. Version .. " | Newest Version: " .. newestversion .. '| ^0('..Github..')')
    getchangelogabove(numberversion)
end
print('^0--------------------------------------------------------------------')
end)



function getchangelogabove(numberversion)
    PerformHttpRequest(updatefile, function(Error, Changelog, Header)
        if Error ~= 200 then
            print("ERROR WHILE CHECKING VERSION!! Error-Code: " .. Error)
            return
        end
       changelog = json.encode(Changelog)
    end)
    print('^6Changelog:')
    local sortedKeys = {}
    for k, _ in pairs(changelog) do
        table.insert(sortedKeys, k)
    end
    table.sort(sortedKeys, function(a, b)
        return getNumberFromString(a) < getNumberFromString(b)
    end)
    for _, k in ipairs(sortedKeys) do
        local v = changelog[k]
        if getNumberFromString(k) > numberversion then
        print('^3' .. k .. ' ^0- ' .. v)
        end
    end
end





function printRandomString(table)
    local randomIndex = math.random(1, #table)
    print(table[randomIndex])
end




randomfivemfunfacts = {
    "Did you know that FiveM was originally developed as a multiplayer modification for Grand Theft Auto IV?",
    "Never gonna give you up",
    "Never gonna let you down",
    "Never gonna run around and desert you",
    "Never gonna make you cry",
    "Never gonna say goodbye",
    "Never gonna tell a lie and hurt you",
    "Why did the scarecrow win an award? Because he was outstanding in his field!",
    "Why don't scientists trust atoms? Because they make up everything!",
    "What do you call a bear with no teeth? A gummy bear!",
    "Why don't skeletons fight each other? They don't have the guts!",
    "What do you call a snowman with a six-pack? An abdominal snowman!",
    "Why did the bicycle fall over? Because it was two-tired!",
    "What do you call a fish wearing a crown? King Neptune!",
    "Why did the tomato turn red? Because it saw the salad dressing!",
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣶⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⠿⠟⠛⠻⣿⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣆⣀⣀⠀⣿⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠻⣿⣿⣿⠅⠛⠋⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢼⣿⣿⣿⣃⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣟⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣛⣛⣫⡄⠀⢸⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⡆⠸⣿⣿⣿⡷⠂⠨⣿⣿⣿⣿⣶⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣾⣿⣿⣿⣿⡇⢀⣿⡿⠋⠁⢀⡶⠪⣉⢸⣿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⡏⢸⣿⣷⣿⣿⣷⣦⡙⣿⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣇⢸⣿⣿⣿⣿⣿⣷⣦⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣵⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    you just got rickrolled, your awesome
    ]],
    [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣿⠽⠭⣥⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡴⠞⠉⠁⠀⠀⠀⠀⠉⠉⠛⠶⣤⣀⠀⠀⢀⣤⠴⠞⠛⠉⠉⠉⠛⠶⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠳⣏⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⣆⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠏⠀⠀⠀⠀⠀⠀⢀⣠⠤⠤⠤⠤⢤⣄⡀⠀⠀⠹⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡄⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⢀⡾⠁⠀⠀⠀⠀⠀⠐⠈⠁⠀⠀⠀⠀⠀⠀⠀⠉⠛⠶⢤⣽⡦⠐⠒⠒⠂⠀⠀⠀⠀⠐⠒⠀⢿⣦⣀⡀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⢀⡞⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⡤⠤⠤⠤⠤⠠⠌⢻⣆⡀⠀⠀⠀⣀⣀⣀⡀⠤⠤⠄⠠⢉⣙⡿⣆⡀⠀
    ⠀⠀⠀⠀⣀⣴⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⢶⣛⣩⣶⣶⡾⢯⠿⠷⣖⣦⣤⣍⣿⣴⠖⣋⠭⣷⣶⣶⡶⠒⠒⣶⣒⣠⣀⣙⣿⣆
    ⠀⠀⢀⠞⠋⠀⡇⠀⠀⠀⠀⠀⠀⢀⣠⡶⣻⡯⣲⡿⠟⢋⣵⣛⣾⣿⣷⡄⠀⠈⠉⠙⠛⢻⣯⠤⠚⠋⢉⣴⣻⣿⣿⣷⣼⠁⠉⠛⠺⣿
    ⠀⣠⠎⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣟⣫⣿⠟⠉⠀⠀⣾⣿⣻⣿⣤⣿⣿⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⣿⣿⣻⣿⣼⣿⣿⠇⠀⠀⠀⢙
    ⢠⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⡶⣄⠀⠀⢻⣿⣿⣿⣿⣿⡏⠀⠀⠀⣀⣤⣾⣁⠀⠀⠀⠸⢿⣿⣿⣿⡿⠋⠀⣀⣠⣶⣿
    ⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠺⢿⣶⣶⣮⣭⣭⣭⣭⡴⢶⣶⣾⠿⠟⠋⠉⠉⠙⠒⠒⠊⠉⠈⠉⠚⠉⠉⢉⣷⡾⠯
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠀⠀⠀⢈⣽⠟⠁⠀⠀⠀⠀⣄⡀⠀⠀⠀⠀⠀⠀⢀⣴⡾⠟⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⡴⠞⠋⠁⠀⠀⠀⠀⠀⠀⠈⠙⢷⡀⠉⠉⠉⠀⠙⢿⣵⡄⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢷⡀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣧⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⠟⠋⠉⠀⠀⠉⠛⠛⠛⠛⠷⠶⠶⠶⠶⠤⢤⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⡤⢿⣆⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡶⠋⠀⠀⠀⠸⠿⠛⠛⠛⠓⠒⠲⠶⢤⣤⣄⣀⠀⠀⠀⠈⠙⠛⠛⠛⠛⠒⠶⠶⠶⣶⠖⠛⠛⠁⢠⣸⡟⠀
    ⠀⠀⠀⠀⠀⠀⢰⣆⠀⢸⣧⣤⣤⣤⣤⣤⣤⣤⣤⣤⣀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠓⠒⠲⠦⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣤⣾⠋⠀⠀
    ⡀⠀⠀⠀⠀⠀⠀⠙⢷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠛⠲⠶⣶⣤⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡾⠃⠀⠀⠀
    ⣿⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⠛⠛⣳⣶⡶⠟⠉⠀⠀⠀⠀⠀
    ⠛⢷⣿⣷⠤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠈⠙⠻⢷⣬⣗⣒⣂⡀⠠⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣤⡴⠾⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠿⠶⠶⠶⠶⣤⣤⣭⣭⣍⣉⣉⣀⣀⣀⣀⣼⣯⡽⠷⠿⠛⠙⠿⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠈⠻⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
    [[`;-.          ___,
    `.`\_...._/`.-"`
      \        /      ,
      /()   () \    .' `-._
     |)  .    ()\  /   _.'
     \  -'-     ,; '. <
      ;.__     ,;|   > \
     / ,    / ,  |.-'.-'
    (_/    (_/ ,;|.<`
      \    ,     ;-`
       >   \    /
      (_,-'`> .'
        (_,']],
[[────────╠███████───███████╠─────────────
───────╠█████████─╠█████████────────────
───────█████████████████████╠───────────
──────╠██████████████████████───────────
──────███████████████████████───────────
──────███████████████████████╠──────────
──────███████████████████████╠──────────
──────███████████████████████───────────
──────╠██████████████████████───────────
──────╠█████████████████████╠───────────
───────█████████████████████────────────
───────╠███████████████████╠────────────
────────╠███████████──╠████─────────────
─────────██████████─────╠█╠─────────────
─────────╠████████──███─────────────────
──────────╠███████─╠█████───────────────
─────╠╠────╠██████─╠███████─────────────
──█████╠────╠█████╠─╠███████╠───────────
─╠███████╠█╠─╠█████╠──████████╠─────────
╠███████████╠──█████───╠████████╠───────
╠█████████████──╠██╠─────╠████████╠─────
─██████████████───────────█████████╠────
──╠█████████████╠───────╠███████████╠───
───╠█████████████████████████████████╠──
────╠█████████████████████████████████──
─────╠█████████████████████████████████─
───────████████████████████████████████╠
────────╠███████████████████████████████
─────────╠██████████████████████████████
───────────█████████████████████████████
────────────╠██████████████████████████─
───────────────────────────────╠██████──
─────────────────────────────────███╠───
─────────────────────────────────╠█╠────
]],
[[─────────▀▀▀▀▀▀──────────▀▀▀▀▀▀▀
──────▀▀▀▀▀▀▀▀▀▀▀▀▀───▀▀▀▀▀▀▀▀▀▀▀▀▀
────▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀──────────▀▀▀
───▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀──────────────▀▀
──▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀──────────────▀▀
─▀▀▀▀▀▀▀▀▀▀▀▀───▀▀▀▀▀▀▀───────────────▀▀
─▀▀▀▀▀▀▀▀▀▀▀─────▀▀▀▀▀▀▀──────────────▀▀
─▀▀▀▀▀▀▀▀▀▀▀▀───▀▀▀▀▀▀▀▀──────────────▀▀
─▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀───────────────▀▀
─▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀───────────────▀▀
─▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀───────────────▀▀
──▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀───────────────▀▀
───▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀───────────────▀▀▀
─────▀▀▀▀▀▀▀▀▀▀▀▀▀───────────────▀▀▀
──────▀▀▀▀▀▀▀▀▀▀▀───▀▀▀────────▀▀▀
────────▀▀▀▀▀▀▀▀▀──▀▀▀▀▀────▀▀▀▀
───────────▀▀▀▀▀▀───▀▀▀───▀▀▀▀
─────────────▀▀▀▀▀─────▀▀▀▀
────────────────▀▀▀──▀▀▀▀
──────────────────▀▀▀▀
───────────────────▀▀
]],
[[
       _,........__
    ,-'            "`-.
  ,'                   `-.
,'                        \
,'                           .
.'\               ,"".       `
._.'|             / |  `       \
|   |            `-.'  ||       `.
|   |            '-._,'||       | \
.`.,'             `..,'.'       , |`-.
l                       .'`.  _/  |   `.
`-.._'-   ,          _ _'   -" \  .     `
`."""""'-.`-...,---------','         `. `....__.
.'        `"-..___      __,'\          \  \     \
\_ .          |   `""""'    `.           . \     \
`.          |              `.          |  .     L
`.        |`--...________.'.        j   |     |
`._    .'      |          `.     .|   ,     |
 `--,\       .            `7""' |  ,      |
    ` `      `            /     |  |      |    _,-'"""`-.
     \ `.     .          /      |  '      |  ,'          `.
      \  v.__  .        '       .   \    /| /              \
       \/    `""\"""""""`.       \   \  /.''                |
        `        .        `._ ___,j.  `/ .-       ,---.     |
        ,`-.      \         ."     `.  |/        j     `    |
       /    `.     \       /         \ /         |     /    j
      |       `-.   7-.._ .          |"          '         /
      |          `./_    `|          |            .     _,'
      `.           / `----|          |-............`---'
        \          \      |          |
       ,'           )     `.         |
        7____,,..--'      /          |
                          `---.__,--.'
]],
[[             ."-,.__
`.     `.  ,
.--'  .._,'"-' `.
.    .'         `'
`.   /          ,'
`  '--.   ,-"'
`"`   |  \
  -. \, |
   `--Y.'      ___.
        \     L._, \
_.,        `.   <  <\                _
,' '           `, `.   | \            ( `
../, `.            `  |    .\`.           \ \_
,' ,..  .           _.,'    ||\l            )  '".
, ,'   \           ,'.-.`-._,'  |           .  _._`.
,' /      \ \        `' ' `--/   | \          / /   ..\
.'  /        \ .         |\__ - _ ,'` `        / /     `.`.
|  '          ..         `-...-"  |  `-'      / /        . `.
| /           |L__           |    |          / /          `. `.
, /            .   .          |    |         / /             ` `
/ /          ,. ,`._ `-_       |    |  _   ,-' /               ` \
/ .           \"`_/. `-_ \_,.  ,'    +-' `-'  _,        ..,-.    \`.
.  '         .-f    ,'   `    '.       \__.---'     _   .'   '     \ \
' /          `.'    l     .' /          \..      ,_|/   `.  ,'`     L`
|'      _.-""` `.    \ _,'  `            \ `.___`.'"`-.  , |   |    | \
||    ,'      `. `.   '       _,...._        `  |    `/ '  |   '     .|
||  ,'          `. ;.,.---' ,'       `.   `.. `-'  .-' /_ .'    ;_   ||
|| '              V      / /           `   | `   ,'   ,' '.    !  `. ||
||/            _,-------7 '              . |  `-'    l         /    `||
. |          ,' .-   ,' ||               | .-.        `.      .'     ||
`'        ,'    `".'    |               |    `.        '. -.'       `'
/      ,'      |               |,'    \-.._,.'/'
.     /        .               .       \    .''
.`.    |         `.             /         :_,'.'
\ `...\   _     ,'-.        .'         /_.-'
`-.__ `,  `'   .  _.>----''.  _  __  /
.'        /"'          |  "'   '_
/_|.-'\ ,".             '.'`__'-( \
/ ,"'"\,'               `/  `-.|"]],
[[                      /@
                     __        __   /\/
                    /==\      /  \_/\/   
                  /======\    \/\__ \__
                /==/\  /\==\    /\_|__ \
             /==/    ||    \=\ / / / /_/
           /=/    /\ || /\   \=\/ /     
        /===/   /   \||/   \   \===\
      /===/   /_________________ \===\
   /====/   / |                /  \====\
 /====/   /   |  _________    /  \   \===\    THE LEGEND OF 
 /==/   /     | /   /  \ / / /  __________\_____      ______       ___
|===| /       |/   /____/ / /   \   _____ |\   /      \   _ \      \  \
 \==\             /\   / / /     | |  /= \| | |        | | \ \     / _ \
 \===\__    \    /  \ / / /   /  | | /===/  | |        | |  \ \   / / \ \
   \==\ \    \\ /____/   /_\ //  | |_____/| | |        | |   | | / /___\ \
   \===\ \   \\\\\\\/   /////// /|  _____ | | |        | |   | | |  ___  |
     \==\/     \\\\/ / //////   \| |/==/ \| | |        | |   | | | /   \ |
     \==\     _ \\/ / /////    _ | |==/     | |        | |  / /  | |   | |
       \==\  / \ / / ///      /|\| |_____/| | |_____/| | |_/ /   | |   | |
       \==\ /   / / /________/ |/_________|/_________|/_____/   /___\ /___\
         \==\  /               | /==/
         \=\  /________________|/=/    OCARINA OF TIME
           \==\     _____     /==/ 
          / \===\   \   /   /===/
         / / /\===\  \_/  /===/
        / / /   \====\ /====/
       / / /      \===|===/
       |/_/         \===/]],
       [[      ____   Turned invader               Normal invader
       /___/\_                                __
      _\   \/_/\__                          _|  |_
    __\       \/_/\                       _|      |_
    \   __    __ \ \                     |  _    _  |
   __\  \_\   \_\ \ \   __               | |_|  |_| |
  /_/\\   __   __  \ \_/_/\           _  |  _    _  |  _
  \_\/_\__\/\__\/\__\/_\_\/          |_|_|_| |__| |_|_|_|
     \_\/_/\       /_\_\/              |_|_        _|_|
        \_\/       \_\/                  |_|      |_|]],
        [[                                                       ,-,-.
                                                       _(    _)
                                                      (__,`-'
                                            ,'`.   .-----,
                             __           ,','`.`.  |   |
                  _____    ,'  `.       ,','    `.`.|---|
              _,-'     \  /      \    ,',' _____  `.`.  |
           ,-'          \ \      /  ,','  |  |  |   `.`.|
         ,'           ___\ `.__.' ,','__  |--|--|   __'.`.         _
        /         _,-'     .----. \|    \ |__|__|  /    |/      ,-' \ TM
       |        ,'         |    |  |     \        /     |    ,-'    _\
       |        |          |    |  |      \      /      |  ,'    ,-'
        \       \          |    |  |       \    /       | /     /
         \       \         |    |  |        \  /        | |    ( 
          \       `.       |    |  |         \/         |  \    \
 ____ _    `.       `.     |    |  |    \          /    |   `.   `.
'-..-'||     `.       `.   |    |  |    |\        /|    |     `.   `.
  ||  ||__   __`.       \  |    |  |    | \      / |    |       \    \
  ||  |.-.\ /__\ \       \ |    |  |    |  \    /  |    |      ,'    /
  ||  || || \__, /       | |    |  |    |   \__/   |    | __,-'    ,'
               ,'        / |    |  |    |          |    | \     ,-'
        ____,-'        ,'  |____|  |    |          |    |  \_,-'
        \            ,'            |____|          |____|
         \       _,-'
          \___,-']],
          [[  _      _      _
          >(.)__ <(.)__ =(.)__
           (___/  (___/  (___/]],
           [[    __
           ___( o)>
           \ <_. )
            `---' ]],
            [[          . --- .
            /        \
           |  O  _  O |
           |  ./   \. |
           /  `-._.-'  \
         .' /         \ `.
     .-~.-~/           \~-.~-.
 .-~ ~    |             |    ~ ~-.
 `- .     |             |     . -'
      ~ - |             | - ~
          \             /
        ___\           /___
        ~;_  >- . . -<  _i~
           `'         `']],
           "we all miss club penguin :(",
           [[        ,----,
           ___.`      `,
           `===  D     :
             `'.      .'
                )    (                   ,
               /      \_________________/|
              /                          |
             |                           ;
             |               _____       /
             |      \       ______7    ,'
             |       \    ______7     /
              \       `-,____7      ,'   
        ^~^~^~^`\                  /~^~^~^~^
          ~^~^~^ `----------------' ~^~^~^
         ~^~^~^~^~^^~^~^~^~^~^~^~^~^~^~^~]],
        [[_nnnn_                      
         dGGGGMMb     ,"""""""""""""".
        @p~qp~~qMb    | Linux Rules! |
        M|@||@) M|   _;..............'
        @,----.JM| -'
       JS^\__/  qKL
      dZP        qKRb
     dZP          qKKb
    fZP            SMMb
    HZM            MMMM
    FqM            MMMM
  __| ".        |\dS"qML
  |    `.       | `' \Zq
 _)      \.___.,|     .'
 \____   )MMMMMM|   .'
      `-'       `--' hjm]],
      [[   _______________                        |*\_/*|________
      |  ___________  |     .-.     .-.      ||_/-\_|______  |
      | |           | |    .****. .****.     | |           | |
      | |   0   0   | |    .*****.*****.     | |   0   0   | |
      | |     -     | |     .*********.      | |     -     | |
      | |   \___/   | |      .*******.       | |   \___/   | |
      | |___     ___| |       .*****.        | |___________| |
      |_____|\_/|_____|        .***.         |_______________|
        _|__|/ \|_|_.............*.............._|________|_
       / ********** \                          / ********** \
     /  ************  \                      /  ************  \
    --------------------                    --------------------]],
}


