local vehicleHistory = {}

function addVehicleToHistory(model)
    local time = string.format("%02d:%02d", GetClockHours(), GetClockMinutes())
    vehicleHistory[#vehicleHistory + 1] = { model = model, time = time }
end

RegisterNUICallback('spawnClick', function(data, cb)
    if data.model and data.model ~= "" then
        local hash = GetHashKey(data.model)
        if not IsModelInCdimage(hash) or not IsModelAVehicle(hash) then return cb('error') end

        RequestModel(hash)
        while not HasModelLoaded(hash) do Citizen.Wait(10) end

        local playerPed = PlayerPedId()
        local vehicle = CreateVehicle(hash, GetEntityCoords(playerPed), 0.0, true, false)
        SetPedIntoVehicle(playerPed, vehicle, -1)
        SetModelAsNoLongerNeeded(hash)
        addVehicleToHistory(data.model)

        cb('ok')
        toggleVisible(false)
    else
        TriggerEvent('QBCore:Notify', 'Please enter a vehicle model!', 'error')
        cb('error')
    end
end)

RegisterNUICallback('requestHistory', function(_, cb) 
    cb(vehicleHistory) 
end)

RegisterNUICallback('closeUI', function() 
    toggleVisible(false) 
end)

function toggleVisible(visible)
    SetNuiFocus(visible, visible)
    SendNUIMessage({ visible = visible })
end

RegisterKeyMapping('+spawn_vehicle', 'open spawn menu', 'keyboard', 'I')
RegisterCommand('+spawn_vehicle', function() toggleVisible(true) 
end)
