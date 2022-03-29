ESX = nil

identityStats = nil
local plate = {}

PlayerData = {}
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(50)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


vehicleStats = nil
local colorVar = "~o~"
local PlyID = PlayerPedId()
local playerItem = {}
local playerBlackMoney = {}
local playerWeapon = {}
closestDistance, closestEntity = -1, nil
local IsHandcuffed, DragStatus = false, {}
DragStatus.IsDragged          = false


local rajouterp = nil

function getInformations(player)
	ESX.TriggerServerCallback('identity:getOtherPlayerData', function(data)
		identityStats = data
	end, GetPlayerServerId(player))
end

local function MarquerJoueur()
        local ped = GetPlayerPed(ESX.Game.GetClosestPlayer())
        local pos = GetEntityCoords(ped)
        local target, distance = ESX.Game.GetClosestPlayer()
        if distance <= 4.0 then
        DrawMarker(2, pos.x, pos.y, pos.z+1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 149, 230, 170, 0, 1, 2, 1, nil, nil, 0)
    end
end

RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(_source)
    draggedBy = _source
    drag = not drag
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if drag then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 73, true) -- X

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
            wasDragged = true
            AttachEntityToEntity(PlayerPedId(), GetPlayerPed(GetPlayerFromServerId(draggedBy)), 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        else
            if not IsPedInParachuteFreeFall(PlayerPedId()) and wasDragged then
                wasDragged = false
                DetachEntity(PlayerPedId(), true, false)    
            end
        end
    end
end)
Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if IsHandcuffed then
			playerPed = PlayerPedId()

			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 73, true) -- X

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, 36, true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end

		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_policejob:putInVehicle')
AddEventHandler('esx_policejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	if not IsHandcuffed then
		return
	end
	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)
		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)
			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				DragStatus.isDragged = false
			end
		end
	end
end)

function GetClosestVehicle(coords)
	local vehicles        = GetVehicles()
	local closestDistance = -1
	local closestVehicle  = -1
	local coords          = coords

	if coords == nil then
		local playerPed = PlayerPedId()
		coords          = GetEntityCoords(playerPed)
	end

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end

	return closestVehicle, closestDistance
end

function IsSpawnPointClear(coords, radius)
	local vehicles = GetVehiclesInArea(coords, radius)
	return #vehicles == 0
end

function GetVehiclesInArea (coords, area)
	local vehicles       = GetVehicles()
	local vehiclesInArea = {}

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if distance <= area then
			table.insert(vehiclesInArea, vehicles[i])
		end
	end

	return vehiclesInArea
end

service = false
WantedVehList = {}
Matricule = nil
NomDeLagent = ""


function SpawnObj(obj)
    local playerPed = PlayerPedId()
	local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    local Ent = nil

    SpawnObject(obj, objectCoords, function(obj)
        SetEntityCoords(obj, objectCoords, 0.0, 0.0, 0.0, 0)
        SetEntityHeading(obj, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(obj)
        Ent = obj
        Wait(1)
    end)
    Wait(1)
    while Ent == nil do Wait(1) end
    SetEntityHeading(Ent, GetEntityHeading(playerPed))
    PlaceObjectOnGroundProperly(Ent)
    local placed = false
    while not placed do
        Citizen.Wait(1)
        local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
        local objectCoords = (coords + forward * 2.0)
        SetEntityCoords(Ent, objectCoords, 0.0, 0.0, 0.0, 0)
        SetEntityHeading(Ent, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(Ent)
        SetEntityAlpha(Ent, 170, 170)

        if IsControlJustReleased(1, 38) then
            placed = true
        end
    end

    FreezeEntityPosition(Ent, true)
    SetEntityInvincible(Ent, true)
    ResetEntityAlpha(Ent)
    local NetId = NetworkGetNetworkIdFromEntity(Ent)
    table.insert(object, NetId)

end


function RemoveObj(id, k)
    Citizen.CreateThread(function()
        SetNetworkIdCanMigrate(id, true)
        local entity = NetworkGetEntityFromNetworkId(id)
        NetworkRequestControlOfEntity(entity)
        local test = 0
        while test > 100 and not NetworkHasControlOfEntity(entity) do
            NetworkRequestControlOfEntity(entity)
            Wait(1)
            test = test + 1
        end
        SetEntityAsNoLongerNeeded(entity)

        local test = 0
        while test < 100 and DoesEntityExist(entity) do 
            SetEntityAsNoLongerNeeded(entity)
            TriggerServerEvent("DeleteEntity", NetworkGetNetworkIdFromEntity(entity))
            DeleteEntity(entity)
            DeleteObject(entity)
            if not DoesEntityExist(entity) then 
                table.remove(object, k)
            end
            SetEntityCoords(entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0)
            Wait(1)
            test = test + 1
        end
    end)
end

function GoodName(hash)
    if hash == GetHashKey("prop_roadcone02a") then
        return "Cone"
    elseif hash == GetHashKey("prop_barrier_work05") then
        return "Barrier"
    else
        return hash
    end

end



function SpawnObject(model, coords, cb)
	local model = GetHashKey(model)

	Citizen.CreateThread(function()
		RequestModels(model)
        Wait(1)
		local obj = CreateObject(model, coords.x, coords.y, coords.z, true, false, true)

		if cb then
			cb(obj)
		end
	end)
end


function RequestModels(modelHash)
	if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
		RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
		end
	end
end


local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

function GetVehicles()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

RegisterNetEvent('esx_policejob:OutVehicle')
AddEventHandler('esx_policejob:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

local function LoadAnimDict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end

RegisterNetEvent('policejob:mettrelesmenottes')
AddEventHandler('policejob:mettrelesmenottes', function(playerheading, playercoords, playerlocation)
	playerPed = PlayerPedId()
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	SetPedCanPlayGestureAnims(playerPed, false)
	DisablePlayerFiring(playerPed, true)
	DisplayRadar(false)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	Wait(500)
	SetEntityCoords(PlayerPedId(), x, y, z)
	--SetEntityHeading(PlayerPedId(), playerheading)
	Wait(250)
	LoadAnimDict('mp_arrest_paired')
	TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Wait(3760)
	IsHandcuffed = true
	TriggerEvent('jek_policejob:handcuff')
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
end)

RegisterNetEvent('policejob:arret')
AddEventHandler('policejob:arret', function()
	Wait(250)
	LoadAnimDict('mp_arrest_paired')
	TaskPlayAnim(PlayerPedId(), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Wait(3000)
end) 

RegisterNetEvent('policejob:enlevermenoottes')
AddEventHandler('policejob:enlevermenoottes', function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(PlayerPedId(), x, y, z)
	--SetEntityHeading(PlayerPedId(), playerheading)
	SetPedCanPlayGestureAnims(playerPed, true)
	DisablePlayerFiring(playerPed, false)
	DisplayRadar(true)
	Wait(250)
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Wait(5500)
	IsHandcuffed = false
	TriggerEvent('jek_policejob:handcuff')
	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(playerPed, false)
end)

RegisterNetEvent('policejob:animenlevermenottes')
AddEventHandler('policejob:animenlevermenottes', function()
	Wait(250)
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Wait(5500)
	ClearPedTasks(PlayerPedId())
end)


local function MarqueurVehicule()
        local pos = GetEntityCoords(PlayerPedId())
        local veh, dst = ESX.Game.GetClosestVehicle({x = pos.x, y = pos.y, z = pos.z})
        pos = GetEntityCoords(veh)
        local target, distance = ESX.Game.GetClosestVehicle()
        if distance <= 8.0 then
        DrawMarker(2, pos.x, pos.y, pos.z+1.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 0, 0, 170, 0, 1, 2, 1, nil, nil, 0)
    end
end
local function LoadAnimDict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end


local function getPlayerInv(player)
    playerItem = {}
    playerWeapon = {}
    playerBlackMoney = {}

    ESX.TriggerServerCallback('npolice:getOtherPlayerData', function(data)
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
                table.insert(playerBlackMoney, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'black_money',
                    itemType = 'item_account',
                    amount   = data.accounts[i].money
                })

                break
            end
        end

        for i=1, #data.weapons, 1 do
            table.insert(playerWeapon, {
                label    = ESX.GetWeaponLabel(data.weapons[i].name),
                value    = data.weapons[i].name,
                right    = data.weapons[i].ammo,
                itemType = 'item_weapon',
                amount   = data.weapons[i].ammo
            })
        end

        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(playerItem, {
                    label    = data.inventory[i].label,
                    right    = data.inventory[i].count,
                    value    = data.inventory[i].name,
                    itemType = 'item_standard',
                    amount   = data.inventory[i].count
                })
            end
        end
    end, GetPlayerServerId(player))
end
object = {}
OtherItems = {}local inventaire = false
local status = true

local PoliceMenuF6Open = false
RMenu.Add('Police', 'main', RageUI.CreateMenu("~b~LSPD", "~b~Interactions", 10, 80))
RMenu:Get('Police', 'main').Closed = function()
    PoliceMenuF6Open = false
end
RMenu.Add('Police', 'citoyens', RageUI.CreateSubMenu(RMenu:Get('Police', 'main'), "Citizen interactions", "~b~Citizen interactions"))
RMenu.Add('Police', 'nplaque', RageUI.CreateSubMenu(RMenu:Get('Police', 'main'), "Vehicle interactions", "~b~Vehicle interactions"))
RMenu.Add('Police', 'nplaqueinfos', RageUI.CreateSubMenu(RMenu:Get('Police', 'main'), "Vehicle information", "~b~Vehicle information"))
RMenu.Add('Police', 'fouiller', RageUI.CreateSubMenu(RMenu:Get('Police', 'main'), "Search", "Search"))
RMenu.Add('Police', 'traffic', RageUI.CreateSubMenu(RMenu:Get('Police', 'main'), "Search", "Search"))
RMenu.Add('Police', 'regarderidentity', RageUI.CreateSubMenu(RMenu:Get('Police', 'main'), "Identity", "Identity"))
RMenu.Add('Police', 'props', RageUI.CreateSubMenu(RMenu:Get('Police', 'main'), "Props", "Press [~ g ~ E ~ w ~] to place the objects"))
RMenu.Add('Police', 'suppression', RageUI.CreateSubMenu(RMenu:Get('Police', 'props'), "Deleting objects", "Deleting objects"))
RMenu:Get('Police', 'main'):SetRectangleBanner(0, 0, 0, 255)
RMenu:Get('Police', 'citoyens'):SetRectangleBanner(0, 0, 0, 255)
RMenu:Get('Police', 'nplaque'):SetRectangleBanner(0, 0, 0, 255)
RMenu:Get('Police', 'nplaqueinfos'):SetRectangleBanner(0, 0, 0, 255)
RMenu:Get('Police', 'fouiller'):SetRectangleBanner(0, 0, 0, 255)
RMenu:Get('Police', 'traffic'):SetRectangleBanner(0, 0, 0, 255)

RMenu:Get('Police', 'regarderidentity'):SetRectangleBanner(0, 0, 0, 255)
RMenu:Get('Police', 'props'):SetRectangleBanner(0, 0, 0, 255)
RMenu:Get('Police', 'suppression'):SetRectangleBanner(0, 0, 0, 255)



local name = GetPlayerName(PlayerId())

function openPoliceMenu()
	if PoliceMenuF6Open then
        PoliceMenuF6Open = false
    else
		PoliceMenuF6Open = true
		RageUI.Visible(RMenu:Get('Police', 'main'), true)
	CreateThread(function()
		while PoliceMenuF6Open do
			Wait(1)
				RageUI.IsVisible(RMenu:Get('Police', 'main'), true, true, true, function()

                        --   RageUI.Separator("? ~o~Citizen interactions ~s~?")

                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                RageUI.ButtonWithStyle("Handcuff", nil, {RightLabel = "→→→"},true, function(h, a, s)
                    if a then 
                        MarquerJoueur()
                    end
                    if s then 
                        local target, distance = ESX.Game.GetClosestPlayer()
                        local target_id = GetPlayerServerId(target)
                        playerheading = GetEntityHeading(PlayerPedId())
                        playerlocation = GetEntityForwardVector(PlayerPedId())
                        playerCoords = GetEntityCoords(PlayerPedId())
                        if distance <= 2.0 then
                           ExecuteCommand("imdekrmkk ~r~Vendos Prangat")
                            TriggerServerEvent('policejob:mettremenotte', target_id, playerheading, playerCoords, playerlocation)
                        else
                            ESX.ShowNotification("No player nearby")
                        end
                    end
                end)
            else
                RageUI.ButtonWithStyle('Handcuff', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end)
            end

            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                RageUI.ButtonWithStyle("Remove handcuffs", nil, {RightLabel = "→→→"},true, function(h, a, s)
                    if a then 
                        MarquerJoueur()
                    end
                    if s then
                        local target, distance = ESX.Game.GetClosestPlayer()
                        local target_id = GetPlayerServerId(target)
                        playerheading = GetEntityHeading(PlayerPedId())
                        playerlocation = GetEntityForwardVector(PlayerPedId())
                        playerCoords = GetEntityCoords(PlayerPedId())
                        if distance <= 2.0 then
			 ExecuteCommand("imdekrmkk ~r~Heq prangat")
                        TriggerServerEvent('policejob:enlevermenotte', target_id, playerheading, playerCoords, playerlocation)
                    else
                        ESX.ShowNotification("No player nearby")
                        end
                    end
                end)
            else
                RageUI.ButtonWithStyle('Remove handcuffs', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end)
            end

                local closestPlayer = ESX.Game.GetClosestPlayer()

                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                RageUI.ButtonWithStyle("Drag", nil, {RightLabel = "→→→"},true, function(h, a, s)
                    if a then 
                        MarquerJoueur()
                    end
                    if s then
                        local target, distance = ESX.Game.GetClosestPlayer()
                        if distance <= 2.0 then
			ExecuteCommand("imdekrmkk ~r~Kap personin per krahu")
                        TriggerServerEvent('policejob:drag', GetPlayerServerId(closestPlayer))
                    else
                        ESX.ShowNotification("No player nearby")
                    end
                    end
                end)
            else
                RageUI.ButtonWithStyle('Drag', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end)
            end

            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                RageUI.ButtonWithStyle("Put in vehicle", nil, {RightLabel = "→→→"},true, function(h, a, s)
                    if a then 
                        MarquerJoueur()
                    end
                    if s then
                        local target, distance = ESX.Game.GetClosestPlayer()
                        if distance <= 2.0 then
                        TriggerServerEvent('esx_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
                        print('1')
                    else
                        ESX.ShowNotification("No player nearby")
                    end
                    end
                end)
            else
                RageUI.ButtonWithStyle('Put in vehicle', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end)
            end

                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    RageUI.ButtonWithStyle("Drag out from vehicle", nil, {RightLabel = "→→→"},true, function(h, a, s)
                        if a then 
                            MarquerJoueur()
                        end
                        if s then
                            local target, distance = ESX.Game.GetClosestPlayer()
                            if distance <= 2.0 then
                            TriggerServerEvent('esx_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification("No player nearby")
                        end
                        end
                    end)
                --end)
            else
                RageUI.ButtonWithStyle('Drag out from vehicle', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                end)
            end
		RageUI.ButtonWithStyle("", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
		if (Selected) then
			--TriggerServerEvent('EMS:Ouvert')
		  end
		end)

                    RageUI.ButtonWithStyle("~b~Citizen Interactions", nil, {RightLabel = "→→→"}, true, function()
                    end, RMenu:Get('Police', 'citoyens'))

                    RageUI.ButtonWithStyle("~o~Vehicle Interactions", nil, {RightLabel = "→→→"}, true, function()
                    end, RMenu:Get('Police', 'nplaque'))

                    RageUI.ButtonWithStyle("~b~Traffic Control", nil, {RightLabel = "→→→"}, true, function()
                    end, RMenu:Get('Police', 'traffic'))

		RageUI.ButtonWithStyle("", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
		if (Selected) then
			--TriggerServerEvent('EMS:Ouvert')
		  end
		end)

                    RageUI.ButtonWithStyle("Objects", nil, {RightLabel = "→→→"}, true, function()
                    end, RMenu:Get('Police', 'props'))


                end, function() end)


            RageUI.IsVisible(RMenu:Get('Police', 'citoyens'), true, true, true, function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                RageUI.ButtonWithStyle("Take ID card", nil, {RightLabel = "→→"}, true, function(h,a,s)
                    if a then
                        MarquerJoueur()
                    if s then
                        identityStats = nil
                        getInformations(closestPlayer)
                    end
                end
                end, RMenu:Get('Police', 'regarderidentity'))
            else
                RageUI.ButtonWithStyle('Take ID card', nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
                end)
            end

                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                RageUI.ButtonWithStyle('Search', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Active then
                        MarquerJoueur()
                        if Selected then
                        getPlayerInv(closestPlayer)
                    end
                end
                end, RMenu:Get('Police', 'fouiller'))
            else
                RageUI.ButtonWithStyle('Search', nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
                end)
            end

            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                RageUI.ButtonWithStyle('Revive Player', nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                    if Active then
                        MarquerJoueur()
                        if Selected then
                            TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
                    end
                end
                end, RMenu:Get('Police', 'revive'))
            else
                RageUI.ButtonWithStyle('Revive', nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
                end)
            end

            RageUI.ButtonWithStyle("Jail", nil, {RightLabel = "→→"}, true, function(h,a,s)
                if a then
                    MarquerJoueur()
                    if s then
                        local id = KeyBoArdPolice("ID ?", '' , '', maxLength or 255)
                        local days = KeyBoArdPolice("Days ?", '' , '', maxLength or 255)
                        local raison = KeyBoArdPolice("Why ? Duheni me shkru midis thojzave ", '"Arsyja ketu"' , '', maxLength or 255)
                        
                        if id and days and raison then
                            ExecuteCommand("jail "..id.. " " ..days.. " " ..raison)
                        end
                    end
                end
            end)

            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
            RageUI.ButtonWithStyle("Bill", nil, {RightLabel = "→→"}, true, function(h,a,s)
                if a then
                    MarquerJoueur()
                if s then
                    local Montant = KeyBoArdPolice("How much ?", '' , '', maxLength or 255)
                    if Montant then
                        ExecuteCommand('fine '..Montant)
                    end
                end
            end
            end)
        else
            RageUI.ButtonWithStyle('Bill', nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
            end)
        end

                
        end) 

            RageUI.IsVisible(RMenu:Get("Police",'nplaque'),true,true,true,function()
                local coords  = GetEntityCoords(PlayerPedId())
                local vehicle = ESX.Game.GetVehicleInDirection()
				local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
                local pos = GetEntityCoords(PlayerPedId())
                local veh, dst = ESX.Game.GetClosestVehicle({x = pos.x, y = pos.y, z = pos.z+1.0})
                pos = GetEntityCoords(veh)
                local target, distanceveh = ESX.Game.GetClosestVehicle()
                if distanceveh <= 2.0 then
                RageUI.ButtonWithStyle("Vehicle information", nil, {RightLabel = "→→"}, true, function(h,a,s)
                        if a then
                        MarqueurVehicule()
                        end
                    if s then
                        vehicleStats = nil
                        local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
                        TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
                        getVehicleInfos(vehicleData)
                    end
                end,RMenu:Get('Police', 'nplaqueinfos'))
            else
                RageUI.ButtonWithStyle("Vehicle information", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(h,a,s)
                if s then
                    ESX.ShowNotification("No vehicle nearby")
                    end
                end)
            end

RageUI.ButtonWithStyle("Impound Vehicle", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
        if (Selected) then
        local playerPed = PlayerPedId()
        local coords  = GetEntityCoords(playerPed)
        local vehicle = ESX.Game.GetVehicleInDirection()
        if DoesEntityExist(vehicle) then
            RequestModel(GetHashKey('a_m_m_hillbilly_01'))
            while not HasModelLoaded(GetHashKey('a_m_m_hillbilly_01')) do
                Wait(1)
            end
            npc = CreatePedInsideVehicle(vehicle, 4, GetHashKey('a_m_m_hillbilly_01'), -1, 1, 1)
            print('Vehicle license plate is', GetVehicleNumberPlateText(vehicle))
            TriggerServerEvent('eden_garage:modifystate', GetVehicleNumberPlateText(vehicle), 3)
            SetVehicleHasBeenOwnedByPlayer(vehicle, true)

            TaskVehicleDriveWander(npc, vehicle, 20.0, 16777216)
            
            Wait(5000)
            ImpoundVehicle(vehicle)
        else
            ESX.ShowNotification('No cars nearby')
        end
    end
end)
                local pos = GetEntityCoords(PlayerPedId())
                local veh, dst = ESX.Game.GetClosestVehicle({x = pos.x, y = pos.y, z = pos.z})
                pos = GetEntityCoords(veh)
                local target, distance = ESX.Game.GetClosestVehicle()
                if distance <= 2.0 then
                RageUI.ButtonWithStyle("Crochet the ~b~vehicle", nil, {RightLabel = "→→"}, true, function(h,a,s)
                    if a then 
                        MarqueurVehicule()
                    end
                    if s then
                            local playerPed = PlayerPedId()
                            vehicle = ESX.Game.GetVehicleInDirection()
                            local coords = GetEntityCoords(playerPed)
                
                            if IsPedSittingInAnyVehicle(playerPed) then
                                ESX.ShowNotification("You cannot do this inside a vehicle")
                                return
                            end
                
                            if DoesEntityExist(vehicle) then
                                isBusy = true
                                TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
                                Citizen.Wait(20000)
            
                                ClearPedTasksImmediately(playerPed)
                                SetVehicleDoorsLocked(vehicle, 1)
                                SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                                ClearPedTasksImmediately(playerPed)
            
                                ESX.ShowNotification("The vehicle has been opened")
                                isBusy = false
                            else
                                ESX.ShowNotification("No vehicle nearby")
                            end
                        end
                    end)
                else
                RageUI.ButtonWithStyle("Crochet the ~b~vehicle", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(h,a,s)
                    if s then
                        ESX.ShowNotification("No vehicle nearby")
                    end
                end)    
            end
            end, function() end)

            RageUI.IsVisible(RMenu:Get("Police",'props'),true,true,true,function()

                RageUI.ButtonWithStyle("~o~Medic Bag", nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SpawnObj("xm_prop_x17_bag_med_01a")
                    end
                end)
                RageUI.ButtonWithStyle("~o~Big Help", nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SpawnObj("v_ind_cf_flour")
                    end
                end)
                
                RageUI.ButtonWithStyle("~o~Tool Box", nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SpawnObj("v_ind_cs_toolbox4")
                    end
                end)
    
                RageUI.ButtonWithStyle("~o~Stinger", nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        SpawnObj("p_ld_stinger_s")
                    end
                end)


                RageUI.ButtonWithStyle("Objects", nil, {RightLabel = "→→"}, true, function()
                end, RMenu:Get('Police', 'suppression'))
            end, function() end)

            RageUI.IsVisible(RMenu:Get("Police",'suppression'),true,true,true,function()

                for k,v in pairs(object) do
                    if GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))) == 0 then table.remove(object, k) end
                    RageUI.ButtonWithStyle("Objects: "..GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))).." ["..v.."]", nil, {}, true, function(Hovered, Active, Selected)
                        if Active then
                            local entity = NetworkGetEntityFromNetworkId(v)
                            local ObjCoords = GetEntityCoords(entity)
                            DrawMarker(0, ObjCoords.x, ObjCoords.y, ObjCoords.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 1, 0, 2, 1, nil, nil, 0)
                        end
                        if Selected then
                            RemoveObj(v, k)
                        end
                    end)
                end

            end, function() end)

            RageUI.IsVisible(RMenu:Get("Police",'traffic'),true,true,true,function()

                RageUI.ButtonWithStyle("Slow Traffic", nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                TriggerEvent("slowtraffic")
                    end
                end)

                RageUI.ButtonWithStyle("Stop Traffic", nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                TriggerEvent("stoptraffic")
                    end
                end)

                RageUI.ButtonWithStyle("Resume Traffic", nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                TriggerEvent("resumetraffic")
                    end
                end)

            end, function() end)


            RageUI.IsVisible(RMenu:Get("Police",'fouiller'),true,true,true,function()

                for k,v  in pairs(playerBlackMoney) do
                    RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~r~$"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            TriggerServerEvent('npolice_1:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, v.amount)
                            RageUI.GoBack()
                        end
                    end)
                end

                RageUI.Separator("                                                       ~b~Objects ~s~")
                for k,v  in pairs(playerItem) do
                    RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~r~x"..v.right}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            TriggerServerEvent('npolice_1:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, v.amount)
                            RageUI.GoBack()
                        end
                    end)
                end

                RageUI.Separator("                                                       ~o~Armes ~s~")
                for k,v  in pairs(playerWeapon) do
                    RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "with ~r~"..v.right.. " ~s~ammo(s)"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            TriggerServerEvent('npolice_1:confiscatePlayerItem', GetPlayerServerId(closestPlayer), v.itemType, v.value, v.amount)
                            RageUI.GoBack()
                        end
                    end)
                end

        end, function() end)

                RageUI.IsVisible(RMenu:Get("Police",'regarderidentity'),true,true,true,function()
                        if identityStats then
                            RageUI.Separator("                                   ~b~ID card ~s~")
                            RageUI.ButtonWithStyle("Name : ", nil, {RightLabel = identityStats.firstname}, true, function(h, a, s)
                            end)
                            RageUI.ButtonWithStyle("First name : ", nil, {RightLabel = identityStats.lastname}, true, function(h, a, s)
                            end)
                            RageUI.ButtonWithStyle("DOB : ", nil, {RightLabel = identityStats.dob}, true, function(h, a, s)
                            end)
                            RageUI.ButtonWithStyle("Size : ", nil, {RightLabel = identityStats.height}, true, function(h, a, s)
                            end)
                            if identityStats.sex == 'm' then
                            RageUI.ButtonWithStyle("Gender : ", nil, {RightLabel = "Man"}, true, function(h, a, s)
                            end) 
                        else
                        if identityStats.sex == 'f' then
                            RageUI.ButtonWithStyle("Gender : ", nil, {RightLabel = "Women"}, true, function(h, a, s)
                            end) 
                        end
                    end
                end
            end, function()    
            end, 1)

                RageUI.IsVisible(RMenu:Get("Police",'nplaqueinfos'),true,true,true,function()
                    if vehicleStats == nil then
                        RageUI.Separator("")
                        RageUI.Separator("~b~Searching for data in progress...")
                        RageUI.Separator("")
                    else
                        local owner = ""
                        if not vehicleStats.owner then owner = "Unknown" else owner = vehicleStats.owner end
                        RageUI.Separator("                                                    ~b~License plate : ~s~"..vehicleStats.plate)
                        RageUI.Separator("                                              ~b~Owner : ~s~"..owner)
                    end
                end, function() end)
            end
        end)
    end
end

function IsAnyJobs(array)
    if (ESX ~= nil and ESX.GetPlayerData() ~= nil and ESX.GetPlayerData().job ~= nil) then
        for i, v in pairs (array) do
            if (v == ESX.GetPlayerData().job.name) then
                return true
            end
        end
    end
    return false
end

function getVehicleInfos(vehicleData)
	ESX.TriggerServerCallback('esx_policejob:getVehicleInfos', function(data)
		Citizen.SetTimeout(1800, function()
		vehicleStats = data
		end)
	end, vehicleData.plate)
end

function KeyBoArdPolice(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", maxLength or 255) 
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500) 
		blockinput = false
		return result
	else
		Citizen.Wait(500) 
		blockinput = false 
		return nil 
	end
end

function ImpoundVehicle(vehicle)
    TriggerServerEvent('DeleteEntityServer', NetworkGetNetworkIdFromEntity(vehicle))
    TriggerServerEvent('DeleteEntityServer', NetworkGetNetworkIdFromEntity(npc))
    Wait(100)
    if DoesEntityExist(npc) then
        DeleteEntity(npc)
    end
    if DoesEntityExist(vehicle) then
        ESX.Game.DeleteVehicle(vehicle)
    end
    ESX.ShowNotification('Impound success')
end

Keys.Register("F6", "Policemenu", "Police", function()
    if (IsAnyJobs({'police'})) then
        if PoliceMenuF6Open == false then
            openPoliceMenu()
        end
end
end)