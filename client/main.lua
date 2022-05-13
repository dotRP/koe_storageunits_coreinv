----Gets ESX-----
storageID = nil


ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()

end)

Citizen.CreateThread(function()
	RegisterNetEvent('esx:playerLoaded')
	AddEventHandler('esx:playerLoaded', function (xPlayer)
		while ESX == nil do
			Citizen.Wait(0)
		end
		ESX.PlayerData = xPlayer
		PlayerLoaded = true
		
	end)
end) 

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

end)

--Qtaret Zones for each storage
Citizen.CreateThread(function()

	local storageConfig = Config.Storages
	for i = 1, #storageConfig, 1 do
        local storageName = storageConfig[1].name
	local length, width = storageConfig[i].bt_length or 0.5, storageConfig[i].bt_width or 0.5
	local minZ, maxZ = storageConfig[i].bt_minZ or 10.0, storageConfig[i].bt_maxZ or 100.0
	local heading = storageConfig[i].bt_heading or 0.0
	local distance = storageConfig[i].bt_distance or 2.0
	local storageid = storageConfig[i].id

	exports['qtarget']:AddBoxZone(i .. storageName, storageConfig[i].coords, length, width, {
		name=i .. storageName,
		heading=heading,
		debugPoly=false,
		minZ=minZ,
		maxZ=maxZ
	}, {
		options = {
			{
				event = "koe_storageunits:checkOwned",
				icon = "fas fa-warehouse",
				label = "Open Storage Unit " .. storageid,
				id = storageid,
                canInteract = function()
                    local player = PlayerPedId()
                    return IsPedOnFoot(player)
                end,
			},
            {
				event = "koe_storageunits:policeBreach",
				icon = "fas fa-warehouse",
				label = "Breach the unit",
				id = storageid,
                job = 'police', 
                canInteract = function()
                    local player = PlayerPedId()
                    return IsPedOnFoot(player)
                end,
            },
		},
		distance = 2.5
	})
        end
end)
   
---Checks the IDs above to then check the status of the storage youre interacting with
RegisterNetEvent('koe_storageunits:checkOwned')
AddEventHandler('koe_storageunits:checkOwned', function(data)
    storageID = data.id
    TriggerServerEvent('koe_storageunits:checkUnit', storageID)
end)


--If the storage is NOT owned this menu pops up
RegisterNetEvent('koe_storageunits:buyMenu')
AddEventHandler('koe_storageunits:buyMenu',function(storageID)
    lib.registerContext({
        id = 'buymenu',
        title = 'Storage Units',
        options = {
            ['Purchase Unit'] = {
                description = 'Purchase this unit for $' ..Config.UnitPrice,
                arrow = true,
                event = 'koe_storageunits:buyStorage',
                metadata = {'Purchase with cash'}
            }
        }
    })
    lib.showContext('buymenu')

end)

RegisterNetEvent('koe_storageunits:buyStorage')
AddEventHandler('koe_storageunits:buyStorage', function(data)
    local ox_inventory = exports.ox_inventory
    local count = ox_inventory:Search(2, 'money')
    if count >= Config.UnitPrice then

        local input = lib.inputDialog('Enter a Pin number', {
            { type = "input", label = "UNIT PIN", password = true, icon = 'lock' },
        })

        if input then
            local pin = input[1]

            TriggerServerEvent('koe_storageunits:buyUnit', storageID, pin)
            if Config.Notify == 'swt' then
                exports['swt_notifications']:Success('success','Unit purchased!','top',8000,true)
            end
            if Config.Notify == 'okok' then
                exports['okokNotify']:Alert("Storage Units", "Unit purchased!", 8000, 'success')
            end
            if Config.Notify == 'esx' then
                ESX.ShowNotification('Unit purchased!')
            end
        end
    else
        if Config.Notify == 'swt' then
            exports['swt_notifications']:Negative('error','Not enough money','top',8000,true)
        end
        if Config.Notify == 'okok' then
            exports['okokNotify']:Alert("Storage Units", "Not enough money", 8000, 'error')
        end
        if Config.Notify == 'esx' then
            ESX.ShowNotification('Not enough money')
        end
    end

    
end)


RegisterNetEvent('koe_storageunits:changePin')
AddEventHandler('koe_storageunits:changePin', function(data)
    local keyboard = lib.inputDialog('Enter your current PIN', {
        { type = "input", label = "Unit PIN", password = true, icon = 'lock' },
    })
    if keyboard[1] ~= nil then
           ESX.TriggerServerCallback('koe_storageunits:checkPin', function(pin)
        if pin then
            local keyboard2 = lib.inputDialog('Enter a NEW PIN', {
                { type = "input", label = "NEW PIN", password = true, icon = 'lock' },
            })

    if keyboard2[1] ~= nil then
        TriggerServerEvent('koe_storageunits:pinChange', storageID,keyboard2[1])
        if Config.Notify == 'swt' then
            exports['swt_notifications']:Success('success','Your pin was changed!','top',8000,true)
        end
        if Config.Notify == 'okok' then
            exports['okokNotify']:Alert("Storage Units", "Your pin was changed!", 8000, 'success')
        end
        if Config.Notify == 'esx' then
            ESX.ShowNotification('Your pin was changed!')
        end
          
    end
        else
            if Config.Notify == 'swt' then
		        exports['swt_notifications']:Negative('error','You have entered the wrong pin. ','top',8000,true)
            end
            if Config.Notify == 'okok' then
                exports['okokNotify']:Alert("Storage Units", "You have entered the wrong pin.", 8000, 'error')
            end
            if Config.Notify == 'esx' then
                ESX.ShowNotification('You have entered the wrong pin.')
            end
        end
    end, storageID,keyboard[1])
    end

end)


--If the storage IS owned by YOU this menu pops up
RegisterNetEvent('koe_storageunits:ownerMenu')
AddEventHandler('koe_storageunits:ownerMenu',function(storageID)

    lib.registerContext({
        id = 'ownermenu',
        title = 'Storage Management',
        options = {
            ['Open Storage'] = {
                description = 'Open your storage unit',
                arrow = true,
                event = 'koe_storageunits:registerStash',
                metadata = {'Open this unit'}
            },
            ['Pin Management'] = {
                description = 'Change your Pin',
                arrow = true,
                event = 'koe_storageunits:changePin',
                metadata = {'You will enter current pin to change it.'}
            },
            ['Sell this unit'] = {
                description = 'Put the unit back on the market',
                arrow = true,
                event = 'koe_storageunits:sellConfirm',
                metadata = {'This will take you to another menu to sell the unit'}
            },
        }
    })
    lib.showContext('ownermenu')
end)

RegisterNetEvent('koe_storageunits:registerStash')
AddEventHandler('koe_storageunits:registerStash', function(data)
    local keyboard = lib.inputDialog('Enter your current PIN', {
        { type = "input", label = "Unit PIN", password = true, icon = 'lock' },
    })

    if keyboard[1] then
           ESX.TriggerServerCallback('koe_storageunits:checkPin', function(pin)
        if pin then
           TriggerServerEvent('koe_storageunits:registerStash', storageID)
        else
            if Config.Notify == 'swt' then
		        exports['swt_notifications']:Negative('error','You have entered the wrong pin.','top',8000,true)
            end
            if Config.Notify == 'okok' then
                exports['okokNotify']:Alert("Storage Units", "You have entered the wrong pin.", 8000, 'error')
            end
            if Config.Notify == 'esx' then
                ESX.ShowNotification('You have entered the wrong pin.')
            end
        end
    end, storageID,keyboard[1])
    end
end)

RegisterNetEvent('koe_storageunits:openStash')
AddEventHandler('koe_storageunits:openStash', function(stashID)
    TriggerEvent('ox_inventory:openInventory', 'stash', stashID)
    Wait(2000)
    LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
    TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
end)

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

RegisterNetEvent('koe_storageunits:sellConfirm')
AddEventHandler('koe_storageunits:sellConfirm',function(storageID)

    lib.registerContext({
        id = 'sellmenu',
        title = 'Sell Unit',
        options = {
            ['Go Back'] = {
                description = 'Go back to the other menu',
                event = 'koe_storageunits:ownerMenu',
                metadata = {'This will take you back'}
            },
            ['Sell Unit'] = {
                description = 'Sell the unit',
                arrow = true,
                event = 'koe_storageunits:storageSell',
                metadata = {'This will sell the unit!'}
            },
        }
    })
    lib.showContext('sellmenu')
end)

RegisterNetEvent('koe_storageunits:storageSell')
AddEventHandler('koe_storageunits:storageSell', function()
    TriggerServerEvent('koe_storageunits:sellUnit', storageID)
    if Config.Notify == 'swt' then
        exports['swt_notifications']:Success('success','You sold the unit!','top',8000,true)
    end
    if Config.Notify == 'okok' then
        exports['okokNotify']:Alert("Storage Units", "You sold the unit!", 8000, 'success')
    end
    if Config.Notify == 'esx' then
        ESX.ShowNotification('You sold the unit!')
    end
end)

--If the storage IS owned but not by you this menu pops up
RegisterNetEvent('koe_storageunits:otherMenu')
AddEventHandler('koe_storageunits:otherMenu',function(storageID)

    lib.registerContext({
        id = 'othermenu',
        title = 'Owned Storage',
        options = {
            ['Open Storage Unit'] = {
                description = 'Open unit with pin',
                event = 'koe_storageunits:registerStash'
            }
        }
    })
    lib.showContext('othermenu')

end)


RegisterNetEvent('koe_storageunits:policeBreach')
AddEventHandler('koe_storageunits:policeBreach', function(storageID)
    
    for k, v in pairs(Config.Policeraid.Jobs) do
        if v.job == ESX.PlayerData.job.name and ESX.PlayerData.job.grade >= v.grade then
            TriggerServerEvent('koe_storageunits:registerStash', storageID.id)
            TriggerServerEvent('koe_storageunits:breachLog', storageID.id)
        end
    end  
    for k, v in pairs(Config.Policeraid.Jobs) do
        if v.job == ESX.PlayerData.job.name and ESX.PlayerData.job.grade < v.grade then
            if Config.Notify == 'swt' then 
                exports['swt_notifications']:Negative('error','Not a high enough rank to do that.','top',8000,true)
            end
            if Config.Notify == 'okok' then
                exports['okokNotify']:Alert("Storage Units", "Not a high enough rank to do that.", 8000, 'error')
            end
            if Config.Notify == 'esx' then
                ESX.ShowNotification('Not a high enough rank to do that.')
            end
        end
    end 
    if ESX.PlayerData.job.name ~= 'police' then
        if Config.Notify == 'swt' then
            exports['swt_notifications']:Negative('error','You cant do that, youre not a cop.','top',8000,true)
        end
        if Config.Notify == 'okok' then
            exports['okokNotify']:Alert("Storage Units", "You cant do that, youre not a cop.", 8000, 'error')
        end
        if Config.Notify == 'esx' then
            ESX.ShowNotification('You cant do that, youre not a cop.')
        end
    end  
end)
