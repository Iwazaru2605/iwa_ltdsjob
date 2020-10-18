-- esx boilerplate
ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

-- starting code
--- menus

-- shop menu (without seller)
menuFrigoLS = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, HeaderColor = {255, 255, 255}, Title = "LTD LS" },
    Data = { currentMenu = "Frigo LTD LS", "iCore" },
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            local slide = btn.slidenum
            local btn = btn.name
            local check = btn.unkCheckbox

            if btn == "Bouteille d'eau" then
                TriggerServerEvent("iwa_ltdsjob:buyItem", "water", 15)
            elseif btn == "Sandwich" then
                TriggerServerEvent("iwa_ltdsjob:buyItem", "sandwich", 20)
            elseif btn == "GPS" then
                TriggerServerEvent("iwa_ltdsjob:buyItem", "gps", 200)
            elseif btn == "Téléphone" then
                TriggerServerEvent("iwa_ltdsjob:buyItem", "phone", 250)
            end
        end,
    },
    Menu = {
        ["Frigo LTD LS"] = {
            b = {
                { name = "Bouteille d'eau", ask = "~g~15$", askX = true },
                { name = "Sandwich", ask = "~g~20$", askX = true },
                { name = "GPS", ask = "~g~200$", askX = true },
                { name = "Téléphone", ask = "~g~250$", askX = true }
            }
        },
    }
}

-- stock menu (with new items for employees)
menuStock = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, HeaderColor = {255, 255, 255}, Title = "LTD LS" },
    Data = { currentMenu = "Stock LTD LS", "iCore" },
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            local slide = btn.slidenum
            local btn = btn.name
            local check = btn.unkCheckbox

            if btn == "Frigo" then
                OpenMenu("Frigo")
            elseif btn == "Bouteille d'eau" then
                TriggerServerEvent("iwa_ltdsjob:buyItem", "water", 1)
            elseif btn == "Sandwich" then
                TriggerServerEvent("iwa_ltdsjob:buyItem", "sandwich", 1)
            elseif btn == "GPS" then
                TriggerServerEvent("iwa_ltdsjob:buyItem", "gps", 2)
            elseif btn == "Téléphone" then
                TriggerServerEvent("iwa_ltdsjob:buyItem", "phone", 2)
            elseif btn == "Menus" then
                OpenMenu("Menus")
            elseif btn == "Kebab" then
                TriggerServerEvent("iwa_ltdsjob:buyItem", "kebab", 2)
            elseif btn == "Soda" then
                TriggerServerEvent("iwa_ltdsjob:buyItem", "soda", 2)
            elseif btn == "Huitre" then
                TriggerServerEvent("iwa_ltdsjob:buyItem", "huitre", 2)
            elseif btn == "Jus de carottes" then
                TriggerServerEvent("iwa_ltdsjob:buyItem", "jusdecarottes", 2)
            elseif btn == "Autres" then
                OpenMenu("Autres")
            elseif btn == "Kit de crochetage" then
                TriggerServerEvent("iwa_ltdsjob:buyItem", "kitdecrochetage", 1)
            elseif btn == "Canne à pêche" then
                TriggerServerEvent("iwa_ltdsjob:buyItem", "canneapeche", 2)
            elseif btn == "Planche de surf" then
                TriggerServerEvent("iwa_ltdsjob:buyItem", "surf", 2)
            end
        end,
    },
    Menu = {
        ["Stock LTD LS"] = {
            b = {
                { name = "Frigo", ask = ">", askX = true },
                { name = "Menus", ask = ">", askX = true },
                { name = "Autres", ask = ">", askX = true}
            }
        },
        ["Frigo"] = {
            b = {
                { name = "Bouteille d'eau", ask = "~g~1$", askX = true },
                { name = "Sandwich", ask = "~g~1$", askX = true },
                { name = "GPS", ask = "~g~2$", askX = true },
                { name = "Téléphone", ask = "~g~2$", askX = true }
            }
        },
        ["Menus"] = {
            b = {
                { name = "Kebab", ask = "~g~2$", askX = true },
                { name = "Soda", ask = "~g~2$", askX = true },
                { name = "Huitre", ask = "~g~2$", askX = true },
                { name = "Jus de carottes", ask = "~g~2$", askX = true }
            }
        },
        ["Autres"] = {
            b = {
                { name = "Kit de crochetage", ask = "~g~1$", askX = true },
                { name = "Canne à pêche", ask = "~g~2$", askX = true },
                { name = "Planche de surf", ask = "~g~2$", askX = true }
            }
        }
    } 
}

-- caisse menu (to send bills, announce, etc.)
menuCaisse = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, HeaderColor = {255, 255, 255}, Title = "LTD LS" },
    Data = { currentMenu = "Caisse LTD LS", "iCore" },
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
            PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            local slide = btn.slidenum
            local btn = btn.name
            local check = btn.unkCheckbox
            local result = GetOnscreenKeyboardResult()

            if btn == "Envoyer une facture" then
                local resultFacture = result
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer == -1 or closestDistance > 3.0 then
                    ESX.ShowNotification("~r~Aucun joueur à proximité")
                else
                    TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_ltds', 'LTD LS', resultFacture)
                    ESX.ShowNotification("~g~Facture envoyée")
                end
            elseif btn == "Annoncer l'ouverture du LTD" then
                TriggerServerEvent("iwa_ltdsjob:sendAnnounce", "ltdOpen")
            elseif btn == "Annoncer la fermeture du LTD" then
                TriggerServerEvent("iwa_ltdsjob:sendAnnounce", "ltdClose")
            elseif btn == "Gestion d'entreprise" then
                CloseMenu(true)
                TriggerEvent('esx_society:openBossMenu', 'ltds', function(data, menu)
                    menu.close()
                end)
            end
        end,
    },
    Menu = {
        ["Caisse LTD LS"] = {
            b = {
                { name = "Envoyer une facture", ask = ">", askX = true },
                { name = "Annoncer l'ouverture du LTD", ask = ">", askX = true },
                { name = "Annoncer la fermeture du LTD", ask = ">", askX = true }
            }
        }
    }
}

-- blip & marker
local antispam = 0

Citizen.CreateThread(function()
    -- blip
    for k,v in ipairs(posCaisseLS) do
        local blip = AddBlipForCoord(v)

        SetBlipSprite (blip, 59)
        SetBlipColour (blip, 32)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName("LTD LS")
        EndTextCommandSetBlipName(blip)
    end
    -- markers
    while true do
        Citizen.Wait(0)
        for k, v in pairs(posLS) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, posLS[k].x, posLS[k].y, posLS[k].z)

            if dist <= 2.0 then
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour ouvrir le ~b~frigo~w~.")                        
                if IsControlJustPressed(1,51) then 	
                    RefreshMenu()
                    CreateMenu(menuFrigoLS)
                end
            end
            if dist < 100.0 then
                DrawMarker(1, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 165, 253, 165, 100, false, true, 2, false, nil, nil, false)
            end        
        end
        if PlayerData.job ~= nil and PlayerData.job.name == "ltds" then
            for k, v in pairs(posStockLS) do
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, posStockLS[k].x, posStockLS[k].y, posStockLS[k].z)

                if dist <= 2.0 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder au ~b~stock~w~.")                        
                    if IsControlJustPressed(1,51) then 	
                        RefreshMenu()
                        CreateMenu(menuStock)
                    end
                end
                if dist < 100.0 then
                    DrawMarker(1, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 165, 253, 165, 100, false, true, 2, false, nil, nil, false)
                end        
            end
            for k, v in pairs(posCaisseLS) do
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, posCaisseLS[k].x, posCaisseLS[k].y, posCaisseLS[k].z)

                if dist <= 2.0 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour accéder à la ~b~caisse~w~.")                        
                    if IsControlJustPressed(1,51) then
                        if PlayerData.job ~= nil and PlayerData.job.grade >= 1 then
                            if antispam == 0 then
                                table.insert(menuCaisse.Menu["Caisse LTD LS"].b, { name = "Gestion d'entreprise", ask = ">", askX = true})
                                antispam = 1
                            end
                        end
                        RefreshMenu()
                        CreateMenu(menuCaisse)
                    end
                end
                if dist < 100.0 then
                    DrawMarker(1, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 165, 253, 165, 100, false, true, 2, false, nil, nil, false)
                end        
            end
        end
    end
end)
