local QBCore = exports['qb-core']:GetCoreObject()
local onDutyTimestamps = {}


QBCore.Functions.CreateCallback('qb-admin:isAdmin', function(src, cb)
    cb(QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command'))
end)

RegisterCommand('staffon', function(source, args, rawCommand)
    QBCore.Functions.TriggerCallback('qb-admin:isAdmin', source, function(isAdmin)
        if not isAdmin then
            TriggerClientEvent('QBCore:Notify', source, 'Access denied.', 'error')
            return
        end

        local playerName = GetPlayerName(source)
        local currentTime = os.time()
        local currentDate = os.date("%Y-%m-%d", currentTime)
        local currentClockTime = os.date("%H:%M:%S", currentTime)

        TriggerEvent("qb-log:server:CreateLog", "staff", "Staff On Duty", "blue", ("Player: **%s**\nTime: **%s**\nDate: **%s**"):format(playerName, currentClockTime, currentDate))

        onDutyTimestamps[source] = currentTime
        TriggerClientEvent('toggleStaffMode', source, true)
    end)
end)

RegisterCommand('staffoff', function(source, args, rawCommand)
    QBCore.Functions.TriggerCallback('qb-admin:isAdmin', source, function(isAdmin)
        if not isAdmin then
            TriggerClientEvent('QBCore:Notify', source, 'Access denied.', 'error')
            return
        end

        local playerName = GetPlayerName(source)
        local currentTime = os.time()
        local currentDate = os.date("%Y-%m-%d", currentTime)
        local currentClockTime = os.date("%H:%M:%S", currentTime)

        local startTime = onDutyTimestamps[source] or currentTime
        local totalTime = os.difftime(currentTime, startTime)
        local hours = math.floor(totalTime / 3600)
        local minutes = math.floor((totalTime % 3600) / 60)
        local seconds = totalTime % 60
        local formattedTotalTime = string.format("%02d:%02d:%02d", hours, minutes, seconds)

        TriggerEvent("qb-log:server:CreateLog", "staff", "Staff Off Duty", "red", ("Player: **%s**\nTime: **%s**\nDate: **%s**\nTotal Time On Duty: **%s**"):format(playerName, currentClockTime, currentDate, formattedTotalTime))

        onDutyTimestamps[source] = nil
        TriggerClientEvent('toggleStaffMode', source, false)
    end)
end)
