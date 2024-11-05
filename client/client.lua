local VORPCore = exports.vorp_core:GetCore()
local lastTime = 0
local notices = true
local change = false

function getTime()
    lastTime =  VORPCore.Callback.TriggerAwait('hec-trainnotice:callback:gettime')
end

-- Command to disable train notifications
RegisterCommand('trainNotices', function(source)
    notices = not notices
    change = true
end, false)

Citizen.CreateThread(function()
    while true do
        if change then
            if notices then 
                VORPCore.NotifyRightTip('Train Notices: ~COLOR_GREEN~ACTIVE', 4000)
            else
                VORPCore.NotifyRightTip('Train Notices: ~COLOR_RED~INACTIVE', 4000)
            end
            change = false
        end
        Citizen.Wait(1000)
    end
end)

-- Check for job change every 15 seconds (if applicable)
Citizen.CreateThread(function()
    while true do
        
        if not IsEntityDead(PlayerPedId()) then
            if lastTime == 0 then
                getTime()
            else
                if notices then
                    TriggerServerEvent("hec-trainnotice:checknotice", lastTime)
                end
                getTime()
            end           
        end
        Citizen.Wait(10000)
    end

end)
