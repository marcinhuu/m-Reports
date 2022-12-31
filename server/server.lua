local QBCore = exports[Config.Core]:GetCoreObject()

local Webhook = Config.Webhook

RegisterNetEvent("m-Reports:Server:SendReport")
AddEventHandler("m-Reports:Server:SendReport", function(motivo, desc)
    local src = source
    sendToDisc("**Player:** " ..GetPlayerName(src).. "\n" .."\n" .."**📃 Reason: ** " ..motivo.. "\n" .."**📃 Description: ** "..desc.. "\n");
end)

function sendToDisc(message)
    local embed = {}
    embed = {
        {
            ["color"] = 65280, -- GREEN = 65280 --- RED = 16711680
            ["title"] = "**NEW REPORT**",
            ["description"] = "" .. message ..  "",
            ["footer"] = { ["text"] = '[m-Reports] | Created By marcinhu#0001', },
        }
    }
    PerformHttpRequest(Webhook, 
    function(err, text, headers) end, 'POST', json.encode({username = '[m-Reports] - Logs', embeds = embed}), { ['Content-Type'] = 'application/json' })
end


CreateThread(function()
    --version check with github latest version
    PerformHttpRequest(
        "https://raw.githubusercontent.com/marcinhuu/m-Reports/fxmanifest.lua",
        function(err, text, headers)
            if err ~= 200 then
                return
            end
            local version = GetResourceMetadata(GetCurrentResourceName(), "version")
            local latestVersion = string.match(text, '%sversion \"(.-)\"')
            if version ~= latestVersion then
                print("Resource is outdated. Please update " .. GetCurrentResourceName() .. " to the newest version.")
            end
        end,
        "GET"
    )
end)
