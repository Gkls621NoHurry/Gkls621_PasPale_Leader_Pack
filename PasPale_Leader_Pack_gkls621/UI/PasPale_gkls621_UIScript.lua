local ASTRONOMY_CLUB_INDEX = GameInfo.Districts["DISTRICT_ASTRONOMY_CLUB_gkls621"].Index or -1
local HARBOR_INDEX = GameInfo.Districts["DISTRICT_HARBOR"].Index or -1
local INDUSTRY_INDEX = GameInfo.Districts["DISTRICT_INDUSTRIAL_ZONE"].Index or -1
local HOLY_SITE_INDEX = GameInfo.Districts["DISTRICT_HOLY_SITE"].Index or -1
local IDOL_THEATER_INDEX = GameInfo.Districts["DISTRICT_IDOL_THEATER_gkls621"].Index or -1
local COMMERCE_INDEX = GameInfo.Districts["DISTRICT_COMMERCIAL_HUB"].Index or -1
--local SHADOW_INDEX = GameInfo.Units["UNIT_GREAT_IDOL_SHADOW_gkls621"].Index or -1
--local ACTIVATOR_OPERATION_INDEX = GameInfo.UnitCommands['UNITCOMMAND_ACTIVATE_GREAT_PERSON']

function PlayerHasLeaderTraitUI(playerID, sTraitType)
	local config = PlayerConfigurations[playerID]
	if config ~= nil then
		local sLeaderType = config:GetLeaderTypeName()
	    for tRow in GameInfo.LeaderTraits() do
			if tRow.LeaderType == sLeaderType and tRow.TraitType == sTraitType then 
				print("Has_LA:"..sTraitType)
				return true 
			end
		end
	end
    return false
end

--[[function PlayerHasCivTraitUI(playerID, sTraitType)
	local config = PlayerConfigurations[playerID]
	if config ~= nil then
		local sCivType = config:GetCivilizationTypeName()
	    for tRow in GameInfo.CivilizationTraits() do
			if tRow.CivilizationType == sCivType and tRow.TraitType == sTraitType then 
				print("Has_UA:"..sTraitType)
				return true 
			end
		end
	end
    return false
end]]--

--[[function GklsPasPaleOnShadowAddedToMap(playerID, unitID, unitX, unitY)
	if (playerID == -1) or (unitID == -1) then return; end
	local pPlayer = Players[playerID];
	local pUnit = UnitManager.GetUnit(playerID, unitID)
	if (GameInfo.Units[pUnit:GetUnitType()].Index == SHADOW_INDEX) then
		local individualID = pUnit:GetGreatPerson():GetIndividual()
		if individualID ~= nil and individualID ~= -1 then
			--print(pUnit:GetGreatPerson():GetIndividual())
			print("PasPale Activates Shadow Idol: ",pUnit:GetGreatPerson():GetIndividual());
			local pPlot = Map.GetPlot(unitX, unitY)
			local pCityBuildings = Cities.GetPlotPurchaseCity(pPlot):GetBuildings()
			for building in GameInfo.Buildings() do
            	local buildingIndex = building.Index
            	if (pCityBuildings:HasBuilding(buildingIndex)) then
                	local iNumSlots = pCityBuildings:GetNumGreatWorkSlots(buildingIndex)
                	if (iNumSlots > 0) then
                    	for idx = 0, iNumSlots - 1 do
                        
                            end
                        end
                    end
                end
            end
			local tParameters = {}
			tParameters.X = unitX
			tParameters.Y = unitY
			tParameters.OnStart = 'GklsPasPaleMoveOthers'
			UI.RequestPlayerOperation(playerID, PlayerOperations.EXECUTE_SCRIPT, tParameters)

			UnitManager.RequestCommand(pUnit, ACTIVATOR_OPERATION_INDEX.Hash)
			local SAYURI_INDEX = 
			local MARI_INDEX = 
			local YUKIKO_INDEX = 
			local MEGUMI_INDEX = 
			if not((individualID == SAYURI_INDEX) or (individualID == MARI_INDEX) or (individualID == YUKIKO_INDEX) or (MEGUMI_INDEX)) then
				UnitManager.RequestCommand(pUnit, ACTIVATOR_OPERATION_INDEX.Hash)
			end
		end
	end
end]]--

function GklsPasPaleHasHighAdjacency(playerID, cityID, districtType, yieldType)
    local pPlayer = Players[playerID]
    local pCity = CityManager.GetCity(playerID, cityID)
    local pCityDistricts = pCity:GetDistricts()
    local pDistrict = pCityDistricts:GetDistrict(districtType)
    -- Reference from Synora's Team PVP Tools
	local kDistrictYields :table = {};
	for yield in GameInfo.Yields() do
		kDistrictYields[yield.Index] = yield;
	end
	for i,yield in ipairs( kDistrictYields ) do
		if yield.YieldType == yieldType then
			print("GklsPasPaleHasHighAdjacency: "..districtType..yieldType.." = "..pDistrict:GetAdjacencyYield(i))
			return pDistrict:GetAdjacencyYield(i);
		end
	end
    return 0
end

function GklsPasPaleHasDarkAge(playerID)
	local pGameEras = Game.GetEras()
	local DarkAge = pGameEras:HasDarkAge(playerID)
	print("GklsPasPaleHsDarkAge( "..playerID.." ) = "..DarkAge)
	return DarkAge
end

function GklsHinaOnDistrictPlaced(playerID, cityID, orderType, objectID, bCancelled)
	if (playerID == -1) or (cityID == -1) then return; end
	if not PlayerHasLeaderTraitUI(playerID, "TRAIT_LEADER_HINA_gkls621") then return; end
	local pCity = CityManager.GetCity(iPlayer, iCity)
	if not pCity then return end
	local pCityBuildingQueue = pCity:GetBuildQueue()
	local districtType = GklsPasPaleGetDistrictType(playerID, cityID)
	if (districtType == -1) then 
		print("Hina's not building a district!")
		return
	end
	--local iCost
	local kPara = {}
	kPara.cityID = cityID
	kPara.cost = 0
	kPara.OnStart = "GklsPasPaleAddProduction"
	if districtType == ASTRONOMY_CLUB_INDEX then
		if GklsPasPaleHasHighAdjacency(playerID, cityID, districtType, "YIELD_SCIENCE") >= 3 then
			if (GklsPasPaleGetDistrictProgress(playerID, cityID, ASTRONOMY_CLUB_INDEX) == 0) then
				--iCost = pCityBuildingQueue:GetDistrictCost(objectID)
				kPara.cost = pCityBuildingQueue:GetDistrictCost(objectID)
				UI.RequestPlayerOperation(playerID, PlayerOperations.EXECUTE_SCRIPT, kPara)
				--pCityBuildingQueue:AddProgress(iCost* 0.5)
			end
		end
	elseif districtType == HARBOR_INDEX then
		if GklsPasPaleHasHighAdjacency(playerID, cityID, districtType, "YIELD_GOLD") >= 4 then
			if (GklsPasPaleGetDistrictProgress(playerID, cityID, HARBOR_INDEX) == 0) then
				--iCost = pCityBuildingQueue:GetDistrictCost(objectID)
				kPara.cost = pCityBuildingQueue:GetDistrictCost(objectID)
				UI.RequestPlayerOperation(playerID, PlayerOperations.EXECUTE_SCRIPT, kPara)
				--pCityBuildingQueue:AddProgress(iCost* 0.5)
			end
		end
	elseif districtType == INDUSTRY_INDEX then
		if GklsPasPaleHasHighAdjacency(playerID, cityID, districtType, "YIELD_PRODUCTION") >= 4 then
			if (GklsPasPaleGetDistrictProgress(playerID, cityID, INDUSTRY_INDEX) == 0) then
				--iCost = GklsPasPaleGetDistrictCost(playerID, cityID, objectID)
				kPara.cost = pCityBuildingQueue:GetDistrictCost(objectID)
				UI.RequestPlayerOperation(playerID, PlayerOperations.EXECUTE_SCRIPT, kPara)
				--pCityBuildingQueue:AddProgress(iCost* 0.5)
			end
		end
	elseif districtType == IDOL_THEATER_INDEX then
		if GklsPasPaleHasHighAdjacency(playerID, cityID, districtType, "YIELD_CULTURE") >= 3 then
			if (GklsPasPaleGetDistrictProgress(playerID, cityID, IDOL_THEATER_INDEX) == 0) then
				--iCost = GklsPasPaleGetDistrictCost(playerID, cityID, objectID)
				kPara.cost = pCityBuildingQueue:GetDistrictCost(objectID)
				UI.RequestPlayerOperation(playerID, PlayerOperations.EXECUTE_SCRIPT, kPara)
				--pCityBuildingQueue:AddProgress(iCost* 0.5)
			end
		end
	elseif districtType == HOLY_SITE_INDEX then
		if GklsPasPaleHasHighAdjacency(playerID, cityID, districtType, "YIELD_FAITH") >= 3 then
			if (GklsPasPaleGetDistrictProgress(playerID, cityID, HOLY_SITE_INDEX) == 0) then
				--iCost = GklsPasPaleGetDistrictCost(playerID, cityID, objectID)
				kPara.cost = pCityBuildingQueue:GetDistrictCost(objectID)
				UI.RequestPlayerOperation(playerID, PlayerOperations.EXECUTE_SCRIPT, kPara)
				--pCityBuildingQueue:AddProgress(iCost* 0.5)
			end
		end
	elseif districtType == COMMERCE_INDEX then
		if GklsPasPaleHasHighAdjacency(playerID, cityID, districtType, "YIELD_GOLD") >= 4 then
			if (GklsPasPaleGetDistrictProgress(playerID, cityID, COMMERCE_INDEX) == 0) then
				--iCost = GklsPasPaleGetDistrictCost(playerID, cityID, objectID)
				kPara.cost = pCityBuildingQueue:GetDistrictCost(objectID)
				UI.RequestPlayerOperation(playerID, PlayerOperations.EXECUTE_SCRIPT, kPara)
				--pCityBuildingQueue:AddProgress(iCost* 0.5)
			end
		end
	end
end

--[[function GklsPasPaleGetGovernment(playerID)
	local pPlayer = Players[playerID]
	local GovernmentType = pPlayer:GetCulture():GetCurrentGovernment()
	return GovernmentType
end]]--

function GklsPasPaleGetDistrictType(playerID, cityID)
	local pCity = CityManager.GetCity(playerID, cityID)
	local pCityBuildingQueue = pCity:GetBuildQueue()
	local tBuildEntry = pCityBuildingQueue:GetAt(0)
	if (not tBuildEntry) then return -1; end
	if (not tBuildEntry.DistrictType) then return -1; end
	print("GklsPasPaleGetDistrictType = "..tBuildEntry.DistrictType)
	return tBuildEntry.DistrictType
end

function GklsPasPaleGetDistrictCost(playerID, cityID, objectID)
	local pCity = CityManager.GetCity(playerID, cityID)
	local pCityBuildingQueue = pCity:GetBuildQueue()
	local iCost = pCityBuildingQueue:GetDistrictCost(objectID)
	return iCost
end

function GklsPasPaleGetDistrictProgress(playerID, cityID, districtType)
	local pCity = CityManager.GetCity(playerID, cityID)
	local pCityBuildingQueue = pCity:GetBuildQueue()
	local iProgress = pCityBuildingQueue:GetDistrictProgress(districtType)
	return iProgress
end

function GklsPasPaleInitialise_UI()
	Events.CityProductionChanged.Add(GklsHinaOnDistrictPlaced)
	ExposedMembers.GklsPasPale = ExposedMembers.GklsPasPale or {}
	ExposedMembers.GklsPasPale.GklsPasPaleHasHighAdjacency = GklsPasPaleHasHighAdjacency
	ExposedMembers.GklsPasPale.GklsPasPaleHasDarkAge = GklsPasPaleHasDarkAge
end

Events.LoadGameViewStateDone.Add(GklsPasPaleInitialise_UI)

--[[ExposedMembers.GklsPasPale.GklsPasPaleGetGovernment = GklsPasPaleGetGovernment
ExposedMembers.GklsPasPale.GklsPasPaleGetDistrictType = GklsPasPaleGetDistrictType
ExposedMembers.GklsPasPale.GklsPasPaleGetDistrictCost = GklsPasPaleGetDistrictCost
ExposedMembers.GklsPasPale.GklsPasPaleGetDistrictProgress = GklsPasPaleGetDistrictProgress]]--
