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
				label = "Open " .. storageName,
				id = storageid,
			},
            {
				event = "koe_storageunits:policeBreach",
				icon = "fas fa-warehouse",
				label = "Breach the unit",
				id = storageid,
                job = 'police', 
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
TriggerEvent('nh-context:sendMenu', {
        {
            header = "Storage Units",
            txt = "",
        },
        {
            header = "Purchase Storage Unit",
            txt = 'Purchase this unit for $' ..Config.UnitPrice,
            params = {
                event = 'koe_storageunits:buyStorage',
            }
        }

    })

end)

RegisterNetEvent('koe_storageunits:buyStorage')
AddEventHandler('koe_storageunits:buyStorage', function(data)
    local ox_inventory = exports.ox_inventory
    local count = ox_inventory:Search(2, 'money')
    if count >= Config.UnitPrice then
        local keyboard = exports["nh-keyboard"]:KeyboardInput({
            header = "Create a Pin for your storage", 
            rows = {
                {
                    id = 0, 
                    txt = "Pin for storage"
                },
            
            }
        })

        if keyboard ~= nil then
            TriggerServerEvent('koe_storageunits:buyUnit', storageID,keyboard[1].input)
        end
    else
        if Config.Swt then
            exports['swt_notifications']:Negative('error','Not enough money','top',8000,true)
        elseif Config.Okok then
            exports['okokNotify']:Alert("Storage Units", "Not enough money", 8000, 'error')
        end
    end
end)

RegisterNetEvent('koe_storageunits:changePin')
AddEventHandler('koe_storageunits:changePin', function(data)
local keyboard = exports["nh-keyboard"]:KeyboardInput({
    header = "Enter the pin for your storage", 
    rows = {
        {
            id = 0, 
            txt = "Pin for storage"
        },
      
    }
})

    if keyboard ~= nil then
           ESX.TriggerServerCallback('koe_storageunits:checkPin', function(pin)
        if pin then
           local keyboard2 = exports["nh-keyboard"]:KeyboardInput({
    header = "Create a new Pin for the storage", 
    rows = {
        {
            id = 0, 
            txt = "Pin for storage"
        },
      
    }
})

    if keyboard2 ~= nil then
          TriggerServerEvent('koe_storageunits:pinChange', storageID,keyboard2[1].input)
    end
        else
            if Config.Swt then
		        exports['swt_notifications']:Negative('error','You have entered the wrong pin. ','top',8000,true)
            end
            if Config.Okok then
                exports['okokNotify']:Alert("Storage Units", "You have entered the wrong pin.", 8000, 'error')
            end
        end
    end, storageID,keyboard[1].input)
    end

end)


--If the storage IS owned by YOU this menu pops up
RegisterNetEvent('koe_storageunits:ownerMenu')
AddEventHandler('koe_storageunits:ownerMenu',function(storageID)

TriggerEvent('nh-context:sendMenu', {
        {
            header = "Storage Management",
            txt = "",
        },
        {   
            id = 50,
            header = "Storage Unit",
            txt = "Open Storage",
            params = {
                event = 'koe_storageunits:registerStash',
            }
        },
        {   
            id = 51,
            header = "Pin Management",
            txt = "Change Pin",
            params = {
                event = 'koe_storageunits:changePin',
            }
        }, 
        {
            id = 52,
            header = "Sell this storage unit",
            txt = "Sell the storage unit",
            params = {
                event = 'koe_storageunits:sellConfirm',
            }
        }

    })
end)

RegisterNetEvent('koe_storageunits:registerStash')
AddEventHandler('koe_storageunits:registerStash', function(data)
local keyboard = exports["nh-keyboard"]:KeyboardInput({
    header = "Enter the pin for your storage", 
    rows = {
        {
            id = 0, 
            txt = "Pin for storage"
        },
      
    }
})

    if keyboard ~= nil then
           ESX.TriggerServerCallback('koe_storageunits:checkPin', function(pin)
        if pin then
           TriggerServerEvent('koe_storageunits:registerStash', storageID)
        else
            if Config.Swt then
		        exports['swt_notifications']:Negative('error','You have entered the wrong pin. ','top',8000,true)
            end
            if Config.Okok then
                exports['okokNotify']:Alert("Storage Units", "You have entered the wrong pin.", 8000, 'error')
            end
        end
    end, storageID,keyboard[1].input)
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

TriggerEvent('nh-context:sendMenu', {
        {   id = 1,
            header = "< Go Back",
            txt = "",
            params = {
                event = 'koe_storageunits:ownerMenu',
            }
        },
        {
            id = 2,
            header = "SELL",
            txt = "Click to sell the unit",
            params = {
                event = 'koe_storageunits:storageSell',
            }
        }

    })
end)

RegisterNetEvent('koe_storageunits:storageSell')
AddEventHandler('koe_storageunits:storageSell', function()
    TriggerServerEvent('koe_storageunits:sellUnit', storageID)
end)

--If the storage IS owned but not by you this menu pops up
RegisterNetEvent('koe_storageunits:otherMenu')
AddEventHandler('koe_storageunits:otherMenu',function(storageID)

TriggerEvent('nh-context:sendMenu', {
        {
            header = "Owned Storage",
            txt = "",
        },
        {   
            header = "Storage Unit",
            txt = "Open Storage",
            params = {
                event = 'koe_storageunits:registerStash',
            }
        },

    })

end)


RegisterNetEvent('koe_storageunits:policeBreach')
AddEventHandler('koe_storageunits:policeBreach', function(data)

    for k, v in pairs(Config.Policeraid.Jobs) do
        if v.job == ESX.PlayerData.job.name and ESX.PlayerData.job.grade >= v.grade then
            TriggerServerEvent('koe_storageunits:registerStash', storageID)
            TriggerServerEvent('koe_storageunits:breachLog', storageID)
        end
    end  
    for k, v in pairs(Config.Policeraid.Jobs) do
        if v.job == ESX.PlayerData.job.name and ESX.PlayerData.job.grade < v.grade then
            if Config.Swt then 
                exports['swt_notifications']:Negative('error','Not a high enough rank to do that.','top',8000,true)
            end
            if Config.Okok then
                exports['okokNotify']:Alert("Storage Units", "Not a high enough rank to do that.", 8000, 'error')
            end
        end
    end 
    if ESX.PlayerData.job.name ~= 'police' then
        if Config.Swt then
            exports['swt_notifications']:Negative('error','You cant do that, youre not a cop.','top',8000,true)
        end
        if Config.Okok then
            exports['okokNotify']:Alert("Storage Units", "You cant do that, youre not a cop.", 8000, 'error')
        end
    end  
end)
