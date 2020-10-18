-- esx boilerplate
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- starting code
TriggerEvent('esx_phone:registerNumber', 'ltdls', "LTD LS", true, true)
TriggerEvent('esx_society:registerSociety', 'ltdls', 'LTD LS', 'society_ltdls', 'society_ltdls', 'society_ltdls', {type = 'private'})

RegisterServerEvent("iwa_ltdsjob:buyItem")
AddEventHandler("iwa_ltdsjob:buyItem", function(item, price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xItem = xPlayer.getInventoryItem(item)

    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent("esx:showAdvancedNotification", source, "LTD LS", "Merci de votre achat", "Vous avez acheté un(e) ~b~" ..xItem.label.. " ~w~à ~b~" ..price.. "$", "CHAR_BANK_MAZE", 8)
    else
        TriggerClientEvent("esx:showNotification", source, "~r~Vous n'avez pas assez d'argent")
    end
end)

RegisterServerEvent("iwa_ltdsjob:sendAnnounce")
AddEventHandler("iwa_ltdsjob:sendAnnounce", function(announce)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers	= ESX.GetPlayers()
    local announceType = announce

    if announceType == "ltdClose" then
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'LTD', 'LTD LS', 'Le LTD est ~r~fermé ~w~!', 'CHAR_BLOCKED', 8)
        end
    elseif announceType == "ltdOpen" then
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'LTD', 'LTD LS', 'Le LTD est ~b~ouvert ~w~!\nUn employé est ~b~disponible ~w~pour vous y accueillir', 'CHAR_CHAT_CALL', 8)
        end
    end
end)

-- items
ESX.RegisterUsableItem('sandwich', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sandwich', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
end)

ESX.RegisterUsableItem('kebab', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('kebab', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 500000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
end)

ESX.RegisterUsableItem('huitre', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('huitre', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 500000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
end)

ESX.RegisterUsableItem('soda', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('soda', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 500000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
end)

ESX.RegisterUsableItem('jusdecarottes', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('jusdecarottes', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 500000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
end)