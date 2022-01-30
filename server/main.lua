discord = {
  ['webhook'] = '',  ---PUT YOUR WEBHOOK URL HERE
  ['name'] = 'Storage Units'
}


----Gets ESX-----
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterNetEvent('trono_storageunits:checkUnit')
AddEventHandler('trono_storageunits:checkUnit', function(storageID)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier =  ESX.GetPlayerFromId(src).identifier

    MySQL.Async.fetchAll('SELECT * FROM storageunits WHERE id = @id',
    { 
      ['@identifier'] = owner,
      ['@id'] = storageID
    }, 
    function(result)
        -- print(json.encode(result))
        -- print(storageID)
        if result[1].identifier == nil then
          TriggerClientEvent('trono_storageunits:buyMenu', src, storageID)
        elseif result[1].identifier == identifier then
          TriggerClientEvent('trono_storageunits:ownerMenu', src, storageID)
        else
          TriggerClientEvent('trono_storageunits:otherMenu', src, storageID)
        end
    end)
end)

RegisterNetEvent('trono_storageunits:buyUnit')
AddEventHandler('trono_storageunits:buyUnit', function(storageID)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier =  ESX.GetPlayerFromId(src).identifier

    MySQL.Async.fetchAll('SELECT * FROM storageunits WHERE id = @id',
    { 
      ['@identifier'] = owner,
      ['@id'] = storageID
    }, 
    function(result2) 
      -- print(json.encode(result2))
            if xPlayer.getMoney() >= Config.UnitPrice then
              MySQL.Async.fetchAll("UPDATE storageunits SET identifier = @identifier WHERE id =@id",{['@identifier']  = identifier, ['@id'] = storageID}, function(result)
                xPlayer.removeMoney(Config.UnitPrice)
            end)
                TriggerClientEvent('okokNotify:Alert', src, "Storage", "You now own this storage unit", 10000, 'success')
            else    
              TriggerClientEvent('okokNotify:Alert', src, "Storage", "Not enough money", 10000, 'error')
            end

    end) 
end)

RegisterNetEvent('trono_storageunits:sellUnit')
AddEventHandler('trono_storageunits:sellUnit', function(storageID)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll('SELECT * FROM storageunits WHERE id = @id',
    { 
      ['@identifier'] = owner,
      ['@id'] = storageID
    }, 
    function(result2) 
      -- print(json.encode(result2))
    
              MySQL.Async.fetchAll("UPDATE storageunits SET identifier = @identifier WHERE id =@id",{['@identifier']  = identifier, ['@id'] = storageID}, function(result)
                xPlayer.addMoney(Config.SellPrice)
              end)
                TriggerClientEvent('okokNotify:Alert', src, "Storage", "You sold the unit", 10000, 'info')
    end)
end)

RegisterNetEvent('trono_storageunits:registerStash')
AddEventHandler('trono_storageunits:registerStash', function(storageID)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier =  ESX.GetPlayerFromId(src).identifier

    MySQL.Async.fetchAll('SELECT id FROM storageunits WHERE id = @id',
    { 
      ['@id'] = storageID
    }, 
    function(result3)
        stashID = json.encode(result3)
        exports.ox_inventory:RegisterStash(stashID, "Storage Unit", 70, 300000)
        TriggerClientEvent('trono_storageunits:openStash', src, stashID)
    end)
end)

RegisterNetEvent('trono_storageunits:breachLog')
AddEventHandler('trono_storageunits:breachLog', function(storageID)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    discordLog(xPlayer.getName() ..  ' - ' .. xPlayer.getIdentifier(), 'has breached the unit #' ..storageID)
end)

function discordLog(name, message)
  local data = {
      {
          ["color"] = '3553600',
          ["title"] = "**".. name .."**",
          ["description"] = message,
      }
  }
  PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = data}), { ['Content-Type'] = 'application/json' })
end