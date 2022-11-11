local QBCore = exports[Config.Core]:GetCoreObject()

RegisterCommand('report', function()
    local dialog = exports['qb-input']:ShowInput({
        header = "Report System",
        submitText = "Submit Report",
        inputs = {
            {
                text = "Reason", 
                name = "motivo", 
                type = "select", 
                options = { 
                    { value = "antirp", text = "Anti-RP" }, 
                    { value = "powergaming", text = "Power-Gaming"}, 
                    { value = "nopain", text = "No-Pain" }, 
                    { value = "nofear", text = "No-Fear" }, 
                    { value = "general", text = "General" }, 
                    { value = "bug", text = "Bug" },
                    -- You can add more options
                    --{ value = "test", text = "Teste" },
                    --{ value = "test2", text = "Teste 2" },
                },
            },
            {
                text = "Description",
                name = "desc", 
                type = "text", 
                isRequired = true, 
            },
        },
    })

    if dialog ~= nil then
        if Config.Screenshot then
            exports['screenshot-basic']:requestScreenshotUpload(Config.Webhook, "files[]", function(data)
                local image = json.decode(data)
            end)
        end
        TriggerServerEvent("m-Reports:Server:SendReport", dialog.motivo, dialog.desc)
    end
end, false)


