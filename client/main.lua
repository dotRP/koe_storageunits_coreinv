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
    
        exports['qtarget']:AddBoxZone("storageunit1", vector3(-73.26, -1196.35, 27.66), 2, 5.4, {
            name="storageunit1",
                heading=0,
                debugPoly=false,
                minZ=25.86,
                maxZ=29.86,
            }, {
                options = {
                {
                event = "trono_storageunits:checkOwned",
                icon = "fas fa-warehouse",
                label = "Storage Unit 1",
                id = 1
                },
            },
                job = {""},
                distance = 2.5
            })
            exports['qtarget']:AddBoxZone("storageunit2", vector3(-66.61, -1198.67, 27.74), 2, 5.4, {
                name="storageunit2",
                heading=314,
                debugPoly=false,
                minZ=25.94,
                maxZ=29.94
            }, {
                options = {
                {
                event = "trono_storageunits:checkOwned",
                icon = "fas fa-warehouse",
                label = "Storage Unit 2",
                id = 2
                },
            },
                job = {""},
                distance = 2.5
            })

        exports['qtarget']:AddBoxZone("storageunit3", vector3(-60.88, -1204.31, 27.79), 2, 5.4, {
            name="storageunit3",
            heading=313,
            --debugPoly=true,
            minZ=25.99,
            maxZ=29.99
        }, {
            options = {
            {
            event = "trono_storageunits:checkOwned",
            icon = "fas fa-warehouse",
            label = "Storage Unit 3",
            id = 3
            },
        },
            job = {""},
            distance = 2.5
        })

        exports['qtarget']:AddBoxZone("storageunit4", vector3(-55.63, -1209.76, 28.28), 2, 5.4, {
            name="storageunit4",
            heading=314,
            --debugPoly=true,
            minZ=26.48,
            maxZ=30.48
        }, {
            options = {
            {
            event = "trono_storageunits:checkOwned",
            icon = "fas fa-warehouse",
            label = "Storage Unit 4",
            id = 4
            },
        },
            job = {""},
            distance = 2.5
        })

        exports['qtarget']:AddBoxZone("storageunit5", vector3(-51.84, -1216.39, 28.7), 2, 5.4, {
            name="storageunit5",
            heading=270,
            --debugPoly=true,
            minZ=26.9,
            maxZ=30.9
        }, {
            options = {
            {
            event = "trono_storageunits:checkOwned",
            icon = "fas fa-warehouse",
            label = "Storage Unit 5",
            id = 5
            },
        },
            job = {""},
            distance = 2.5
        })

        exports['qtarget']:AddBoxZone("storageunit6", vector3(-55.88, -1229.75, 28.76), 2, 5.4, {
            name="storageunit6",
            heading=227,
            --debugPoly=true,
            minZ=26.96,
            maxZ=30.96
        }, {
            options = {
            {
            event = "trono_storageunits:checkOwned",
            icon = "fas fa-warehouse",
            label = "Storage Unit 6",
            id = 6
            },
        },
            job = {""},
            distance = 2.5
        })

        exports['qtarget']:AddBoxZone("storageunit7", vector3(-60.08, -1234.31, 28.89), 2, 5.4, {
            name="storageunit7",
            heading=226,
            --debugPoly=true,
            minZ=27.09,
            maxZ=31.09
        }, {
            options = {
            {
            event = "trono_storageunits:checkOwned",
            icon = "fas fa-warehouse",
            label = "Storage Unit 7",
            id = 7
            },
        },
            job = {""},
            distance = 2.5
        })

        exports['qtarget']:AddBoxZone("storageunit8", vector3(-65.34, -1240.06, 29.03), 2, 5.4, {
            name="storageunit8",
            heading=226,
            --debugPoly=true,
            minZ=27.23,
            maxZ=31.23
        }, {
            options = {
            {
            event = "trono_storageunits:checkOwned",
            icon = "fas fa-warehouse",
            label = "Storage Unit 8",
            id = 8
            },
        },
            job = {""},
            distance = 2.5
        })

        exports['qtarget']:AddBoxZone("storageunit9", vector3(-73.77, -1243.99, 29.11), 2, 5.4, {
            name="storageunit9",
            heading=179,
            --debugPoly=true,
            minZ=27.31,
            maxZ=31.31
        }, {
            options = {
            {
            event = "trono_storageunits:checkOwned",
            icon = "fas fa-warehouse",
            label = "Storage Unit 9",
            id = 9
            },
        },
            job = {""},
            distance = 2.5
        })

        exports['qtarget']:AddBoxZone("storageunit10", vector3(-73.07, -1233.18, 29.02), 2, 5.4, {
            name="storageunit10",
            heading=51,
            --debugPoly=true,
            minZ=27.22,
            maxZ=31.22
        }, {
            options = {
            {
            event = "trono_storageunits:checkOwned",
            icon = "fas fa-warehouse",
            label = "Storage Unit 10",
            id = 10
            },
        },
            job = {""},
            distance = 2.5
        })

        exports['qtarget']:AddBoxZone("storageunit11", vector3(-67.51, -1226.06, 28.86), 2, 5.4, {
            name="storageunit11",
            heading=51,
            --debugPoly=true,
            minZ=27.06,
            maxZ=31.06
        }, {
            options = {
            {
            event = "trono_storageunits:checkOwned",
            icon = "fas fa-warehouse",
            label = "Storage Unit 11",
            id = 11
            },
        },
            job = {""},
            distance = 2.5
        })

        exports['qtarget']:AddBoxZone("storageunit12", vector3(-66.55, -1212.4, 28.31), 2, 5.4, {
            name="storageunit12",
            heading=316,
            --debugPoly=true,
            minZ=26.51,
            maxZ=30.51
        }, {
            options = {
            {
            event = "trono_storageunits:checkOwned",
            icon = "fas fa-warehouse",
            label = "Storage Unit 12",
            id = 12
            },
        },
            job = {""},
            distance = 2.5
        })

        exports['qtarget']:AddBoxZone("storageunit13", vector3(-71.74, -1207.16, 27.89), 2, 5.4, {
            name="storageunit13",
            heading=316,
            --debugPoly=true,
            minZ=26.09,
            maxZ=30.09
        }, {
            options = {
            {
            event = "trono_storageunits:checkOwned",
            icon = "fas fa-warehouse",
            label = "Storage Unit 13",
            id = 13
            },
        },
            job = {""},
            distance = 2.5
        })

        exports['qtarget']:AddBoxZone("storageunit14", vector3(-78.6, -1205.21, 27.63), 2, 5.4, {
            name="storageunit14",
            heading=0,
            --debugPoly=true,
            minZ=25.83,
            maxZ=29.83
        }, {
            options = {
            {
            event = "trono_storageunits:checkOwned",
            icon = "fas fa-warehouse",
            label = "Storage Unit 14",
            id = 14
            },
        },
            job = {""},
            distance = 2.5
        })
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