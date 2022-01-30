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
				event = "trono_storageunits:checkOwned",
				icon = "fas fa-warehouse",
				label = "Open " .. storageName,
				id = storageid,
			},
		},
		distance = 2.5
	})
        end
end)
   
---Checks the IDs above to then check the status of the storage youre interacting with
RegisterNetEvent('trono_storageunits:checkOwned')
AddEventHandler('trono_storageunits:checkOwned', function(data)
    storageID = data.id
    TriggerServerEvent('trono_storageunits:checkUnit', storageID)
end)


--If the storage is NOT owned this menu pops up
RegisterNetEvent('trono_storageunits:buyMenu')
AddEventHandler('trono_storageunits:buyMenu',function(storageID)
TriggerEvent('nh-context:sendMenu', {
        {
            header = "Storage Units",
            txt = "",
        },
        {
            header = "Purchase Storage Unit",
            txt = 'Purchase this unit for $' ..Config.UnitPrice,
            params = {
                event = 'trono_storageunits:buyStorage',
            }
        }

    })

end)

RegisterNetEvent('trono_storageunits:buyStorage')
AddEventHandler('trono_storageunits:buyStorage', function()
    TriggerServerEvent('trono_storageunits:buyUnit', storageID)
end)


--If the storage IS owned by YOU this menu pops up
RegisterNetEvent('trono_storageunits:ownerMenu')
AddEventHandler('trono_storageunits:ownerMenu',function(storageID)

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
                event = 'trono_storageunits:registerStash',
            }
        },
        {
            id = 51,
            header = "Sell this storage unit",
            txt = "Sell the storage unit",
            params = {
                event = 'trono_storageunits:sellConfirm',
            }
        }

    })
end)

RegisterNetEvent('trono_storageunits:registerStash')
AddEventHandler('trono_storageunits:registerStash', function(data)
    TriggerServerEvent('trono_storageunits:registerStash', storageID)
end)

RegisterNetEvent('trono_storageunits:openStash')
AddEventHandler('trono_storageunits:openStash', function(stashID)
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

RegisterNetEvent('trono_storageunits:sellConfirm')
AddEventHandler('trono_storageunits:sellConfirm',function(storageID)

TriggerEvent('nh-context:sendMenu', {
        {   id = 1,
            header = "< Go Back",
            txt = "",
            params = {
                event = 'trono_storageunits:ownerMenu',
            }
        },
        {
            id = 2,
            header = "SELL",
            txt = "Click to sell the unit",
            params = {
                event = 'trono_storageunits:storageSell',
            }
        }

    })
end)

RegisterNetEvent('trono_storageunits:storageSell')
AddEventHandler('trono_storageunits:storageSell', function()
    TriggerServerEvent('trono_storageunits:sellUnit', storageID)
end)

--If the storage IS owned but not by you this menu pops up
RegisterNetEvent('trono_storageunits:otherMenu')
AddEventHandler('trono_storageunits:otherMenu',function(storageID)

TriggerEvent('nh-context:sendMenu', {
        {
            header = "This unit is owned.",
            txt = "",
        },
        {
            header = "POLICE",
            txt = "Breach the unit",
            params = {
                event = 'trono_storageunits:policeBreach',
            }
        }

    })

end)


RegisterNetEvent('trono_storageunits:policeBreach')
AddEventHandler('trono_storageunits:policeBreach', function(data)

    for k, v in pairs(Config.Policeraid.Jobs) do
        if v.job == ESX.PlayerData.job.name and ESX.PlayerData.job.grade >= v.grade then
            TriggerServerEvent('trono_storageunits:registerStash', storageID)
            TriggerServerEvent('trono_storageunits:breachLog', storageID)
        end
    end  
    for k, v in pairs(Config.Policeraid.Jobs) do
        if v.job == ESX.PlayerData.job.name and ESX.PlayerData.job.grade < v.grade then
            exports['okokNotify']:Alert("Storage", "Not a high enough rank to do that.", 8000, 'error')
        end
    end 
    if ESX.PlayerData.job.name ~= 'police' then
        exports['okokNotify']:Alert("Storage", "You cant do that, youre not a cop.", 8000, 'error')
    end  
end)
