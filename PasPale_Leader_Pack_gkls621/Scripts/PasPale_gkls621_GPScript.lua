local TYPE_AYA = "LEADER_AYA_gkls621"
local TYPE_HINA = "LEADER_HINA_gkls621"
local TYPE_EVE = "LEADER_EVE_gkls621"
local TYPE_CHISATO = "LEADER_CHISATO_gkls621"
local MASS_PRODUCTION_INDEX = GameInfo.Technologies["TECH_MASS_PRODUCTION"].Index or -1
local METAL_CASTING_INDEX = GameInfo.Technologies["TECH_METAL_CASTING"].Index or -1
local COMBUSTION_INDEX = GameInfo.Technologies["TECH_COMBUSTION"].Index or -1
local ASTRONOMY_CLUB_INDEX = GameInfo.Districts["DISTRICT_ASTRONOMY_CLUB_gkls621"].Index or -1
local HARBOR_INDEX = GameInfo.Districts["DISTRICT_HARBOR"].Index or -1
local INDUSTRY_INDEX = GameInfo.Districts["DISTRICT_INDUSTRIAL_ZONE"].Index or -1
local HOLY_SITE_INDEX = GameInfo.Districts["DISTRICT_HOLY_SITE"].Index or -1
local IDOL_THEATER_INDEX = GameInfo.Districts["DISTRICT_IDOL_THEATER_gkls621"].Index or -1
local COMMERCE_INDEX = GameInfo.Districts["DISTRICT_COMMERCIAL_HUB"].Index or -1
local GOVERNMENT_INDEX = GameInfo.Districts["DISTRICT_GOVERNMENT"].Index or -1
local DIPLOMACY_INDEX = GameInfo.Districts["DISTRICT_DIPLOMATIC_QUARTER"].Index or -1
local SAMURAI_INDEX = GameInfo.Units["UNIT_JAPANESE_SAMURAI"].Index or -1
local FINNISH_SNIPER_INDEX = GameInfo.Units["UNIT_FINNISH_SNIPER_gkls621"].Index or -1
local COMMUNISM_INDEX = GameInfo.Governments["GOVERNMENT_COMMUNISM"].Index or -1
-- about great idols↓
--local IDOL_CLASS_INDEX = GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_IDOL_gkls621"].Index or -1


function GklsCivTraitMatches(playerID, TraitType)
	local config = PlayerConfigurations[playerID]
	if config ~= nil then
		local CivType = config:GetCivilizationTypeName()
	    for tRow in GameInfo.CivilizationTraits() do
			if tRow.CivilizationType == CivType and tRow.TraitType == TraitType then 
				print("This game has civ trait: "..TraitType)
				return true 
			end
		end
	end
    return false
end

function GklsLeaderMatches(playerID, leaderType)
	if playerID == -1 then
		return false
	end
	local pPlayerConfig = PlayerConfigurations[playerID]
	if pPlayerConfig == nil then
		return false
	end
	if pPlayerConfig:GetLeaderTypeName() == leaderType then
		print("GklsLeaderMatches("..playerID.." "..leaderType..")")
		return true
	end
	print("GklsLeaderMatches("..playerID.." "..leaderType..") find it unmatchable")
	return false
end

function GklsPasPaleAddProduction(playerID, param)
	local cityID = param.cityID
	local progress = param.cost
	local pCity = CityManager.GetCity(playerID, cityID)
	local pCityBuildingQueue = pCity:GetBuildQueue()
	pCityBuildingQueue:AddProgress(math.ceil(progress* 0.5))
	print("PasPale added "..math.ceil(progress* 0.5).." to district production")
end

--[[function GklsPasPaleOnIdolCreated(playerID, unitID, greatPersonClassID, greatPersonIndividualID)
	if (playerID == nil) or (unitID == nil) or (greatPersonClassID == -1) then return; end
	if (not GklsCivTraitMatches(playerID, "TRAIT_CIVILIZATION_PASPALE_gkls621")) then return; end
	if greatPersonClassID == IDOL_CLASS_INDEX then
		local idolLocation = UnitManager.GetUnit(playerID, unitID):GetLocation()
		local iX = idolLocation.x; local iY = idolLocation.y;
		-- Reference: Pen's Kjerag
		local pUnitList:table = Units.GetUnitsInPlotLayerID(iX,iY,MapLayers.ANY)
		if iX ~= nil and iY ~= nil and pUnitList ~= nil then 
			--首先找一个好地方
			local Placeplot = nil
			local tNeighborPlots = Map.GetNeighborPlots(iX,iY, 1)
			if	tNeighborPlots ~= nil then
				for _, pPlot in pairs(tNeighborPlots) do
					if	not pPlot:IsImpassable() and (pPlot:GetX() ~= iX or pPlot:GetY() ~= iY) then
						Placeplot = pPlot
						break
					end
				end
			end
			--然后把杂七杂八的单位都移到好地方
			for	_,PlotUnit in ipairs(pUnitList) do
				if PlotUnit and PlotUnit:GetOwner() == playerID then
					local pUnitTable = GameInfo.Units[PlotUnit:GetType()]
					if pUnitTable and (pUnitTable.FormationClass == "FORMATION_CLASS_CIVILIAN" and pUnitTable.IgnoreMoves == false) then
						print("Place!!!",Placeplot:GetX(),Placeplot:GetY())
						UnitManager.PlaceUnit(PlotUnit,Placeplot:GetX(),Placeplot:GetY())
					end
				end
			end
		end
		local shadowIndividual = GameInfo.GreatPersonIndividuals[GameInfo.GreatPersonIndividuals[greatPersonIndividualID].GreatPersonClassType .. "_SHADOW"].Hash
		local class = GameInfo.GreatPersonClasses["GREAT_PERSON_CLASS_SHADOW_IDOL_gkls621"].Hash
		local era = GameInfo.Eras["ERA_ANCIENT"].Hash
		Game.GetGreatPeople():GrantPerson(shadowIndividual, class, era, cost, playerID, false);
	end
end]]--

function GklsAyaOnEraScoreChanged(playerID, amountAwarded)
    if (playerID == -1) then return; end
    if not GklsLeaderMatches(playerID, TYPE_AYA) then return; end
	local pPlayer = Players[playerID]
	local pUnits = pPlayer:GetUnits()
	if pUnits == nil then print("pUnits = nil!"); return; end
	for _, pUnit in pUnits:Members() do
		if (not pUnit:IsDead()) and (not pUnit:IsDelayedDeath()) then
			local unitInfo:table = GameInfo.Units[pUnit:GetType()]
			local unitInfo_XP2:table = GameInfo.Units_XP2[unitInfo.UnitType]
			if ((unitInfo_XP2 ~= nil) and (unitInfo_XP2.CanEarnExperience == 1)) or ((unitInfo_XP2 == nil) and (unitInfo.CanEarnExperience == 1)) then
				pUnit:GetExperience():ChangeExperience(amountAwarded *5)
				print("Aya's unit "..pUnit:GetType().." got 5*"..amountAwarded.." EXP")
				if (ExposedMembers.GklsPasPale.GklsPasPaleHasDarkAge(playerID)) then
					pUnit:GetExperience():ChangeExperience(amountAwarded *10)
					print("Aya's unit "..pUnit:GetType().." got an extra 10*"..amountAwarded.." EXP for dark age")
				end
			end
		end
	end
end

function GklsAyaOnTechBoosted(playerID, techID)
    if (playerID == -1) or (techID == -1) then return; end
    if not GklsLeaderMatches(playerID, TYPE_AYA) then return; end
	local pPlayer = Players[playerID]
    local HAS_MP_BOOST = pPlayer:GetProperty("AYA_MP_BOOSTED") or 0
    local HAS_MC_BOOST = pPlayer:GetProperty("AYA_MC_BOOSTED") or 0
    --if (HAS_MP_BOOST == 1) and (HAS_MC_BOOST == 1) then return; end
    if techID == MASS_PRODUCTION_INDEX then
        local pPlayer = Players[playerID]      
        if HAS_MP_BOOST == 0 then pPlayer:SetProperty("AYA_MP_BOOSTED", 1); HAS_MP_BOOST = 1; print("Mass Production boosted"); end
    elseif techID == METAL_CASTING_INDEX then
        local pPlayer = Players[playerID]        
        if HAS_MC_BOOST == 0 then pPlayer:SetProperty("AYA_MC_BOOSTED", 1); HAS_MC_BOOST = 1; print("Metal Casting boosted"); end
    end
    if (HAS_MP_BOOST == 1) and (HAS_MC_BOOST == 1) then
        local playerTechs = pPlayer:GetTechs()
        if playerTechs == nil then return; end
        local AYA_HAS_COMBUSTION = playerTechs:HasTech(COMBUSTION_INDEX)
        if AYA_HAS_COMBUSTION then return; end
        playerTechs:SetResearchProgress(COMBUSTION_INDEX, playerTechs:GetResearchCost(COMBUSTION_INDEX))
		print("Combustion unlocked!")
    end
end

function GklsHinaOnDistrictCompleted(playerID, districtID, cityID, iX, iY,  districtType, era, civilization, percentComplete, iAppeal, isPillaged)
	if (percentComplete ~= 100) or (playerID == -1) or (districtID == -1) then return; end
	if not GklsLeaderMatches(playerID, TYPE_HINA) then return; end
	print("Hina has completed a district!")
	local pCity = CityManager.GetCity(playerID, cityID)
	local pPlayer = Players[playerID]
    if ((not pCity:GetProperty("HINA_CITY_ASTRONOMY_CLUB"))) and (districtType == ASTRONOMY_CLUB_INDEX) then
		if (not pPlayer:GetProperty("HINA_BUILT_ASTRONOMY_CLUB")) then
			pPlayer:AttachModifierByID("PASPALE_FUTURE_TECH_BOOST_gkls621")
			pPlayer:SetProperty("HINA_BUILT_ASTRONOMY_CLUB", true)
			print("FUTURE ERA eureka gifted to Hina!")
		end
		--pCity:GetBuildQueue():CreateBuilding(GameInfo.Buildings["BUILDING_BUILDING_BLOCK_HINA_gkls621"].Index)
		if (ExposedMembers.GklsPasPale.GklsPasPaleHasHighAdjacency(playerID, cityID, ASTRONOMY_CLUB_INDEX, 'YIELD_SCIENCE') < 3) then return; end
		pPlayer:AttachModifierByID("PASPALE_RANDOM_TECH_gkls621")
		pCity:SetProperty("HINA_CITY_ASTRONOMY_CLUB", true)
		print("Tech gifted to Hina!")
		if (not pPlayer:GetProperty("HINA_BUILT_ASTRONOMY_CLUB")) then
			pPlayer:AttachModifierByID("PASPALE_FUTURE_TECH_BOOST_gkls621")
			pPlayer:SetProperty("HINA_BUILT_ASTRONOMY_CLUB", true)
			print("FUTURE ERA eureka gifted to Hina!")
		end
	elseif ((not pCity:GetProperty("HINA_CITY_HARBOR"))) and (districtType == HARBOR_INDEX) then
		if (ExposedMembers.GklsPasPale.GklsPasPaleHasHighAdjacency(playerID, cityID, HARBOR_INDEX, 'YIELD_GOLD') < 4) then return; end
		pPlayer:AttachModifierByID("PASPALE_RANDOM_TECH_gkls621")
		pCity:SetProperty("HINA_CITY_HARBOR", true)
		print("Tech gifted to Hina!")
	elseif ((not pCity:GetProperty("HINA_CITY_INDUSTRY"))) and (districtType == INDUSTRY_INDEX) then
		if (ExposedMembers.GklsPasPale.GklsPasPaleHasHighAdjacency(playerID, cityID, INDUSTRY_INDEX, 'YIELD_PRODUCTION') < 4) then return; end
		pPlayer:AttachModifierByID("PASPALE_RANDOM_TECH_gkls621")
		pCity:SetProperty("HINA_CITY_INDUSTRY", true)
		print("Tech gifted to Hina!")
	elseif ((not pCity:GetProperty("HINA_CITY_IDOL_THEATER"))) and (districtType == IDOL_THEATER_INDEX) then
		if (not pPlayer:GetProperty("HINA_BUILT_IDOL_THEATER")) then
			pPlayer:AttachModifierByID("PASPALE_FUTURE_TECH_BOOST_gkls621")
			pPlayer:SetProperty("HINA_BUILT_IDOL_THEATER", true)
			print("FUTURE ERA eureka gifted to Hina!")
		end
		if (ExposedMembers.GklsPasPale.GklsPasPaleHasHighAdjacency(playerID, cityID, IDOL_THEATER_INDEX, 'YIELD_CULTURE') < 3) then return; end
		pPlayer:AttachModifierByID("PASPALE_RANDOM_CIVIC_gkls621")
		pCity:SetProperty("HINA_CITY_IDOL_THEATER", true)
		print("Civic gifted to Hina!")
	elseif ((not pCity:GetProperty("HINA_CITY_HOLY_SITE"))) and (districtType == HOLY_SITE_INDEX) then
		if (ExposedMembers.GklsPasPale.GklsPasPaleHasHighAdjacency(playerID, cityID, HOLY_SITE_INDEX, 'YIELD_FAITH') < 3) then return; end
		pPlayer:AttachModifierByID("PASPALE_RANDOM_CIVIC_gkls621")
		pCity:SetProperty("HINA_CITY_HOLY_SITE", true)
		print("Civic gifted to Hina!")
	elseif ((not pCity:GetProperty("HINA_CITY_COMMERCE"))) and (districtType == COMMERCE_INDEX) then
		if (ExposedMembers.GklsPasPale.GklsPasPaleHasHighAdjacency(playerID, cityID, COMMERCE_INDEX, 'YIELD_GOLD') < 4) then return; end
		pPlayer:AttachModifierByID("PASPALE_RANDOM_CIVIC_gkls621")
		pCity:SetProperty("HINA_CITY_COMMERCE", true)
		print("Civic gifted to Hina!")
	elseif (not pPlayer:GetProperty("HINA_BUILT_GOVERNMENT")) and (districtType == GOVERNMENT_INDEX) then
		pPlayer:AttachModifierByID("PASPALE_FUTURE_TECH_BOOST_gkls621")
		pPlayer:SetProperty("HINA_BUILT_GOVERNMENT", true)
		print("FUTURE ERA eureka gifted to Hina!")
	elseif (not pPlayer:GetProperty("HINA_BUILT_DIPLOMACY")) and (districtType == DIPLOMACY_INDEX) then
		pPlayer:AttachModifierByID("PASPALE_FUTURE_TECH_BOOST_gkls621")
		pPlayer:SetProperty("HINA_BUILT_DIPLOMACY", true)
		print("FUTURE ERA eureka gifted to Hina!")
	end
end

function GklsHinaOnCityInitialised(playerID, cityID)
	if (playerID == -1) or (cityID == -1) then return; end
	if not GklsLeaderMatches(playerID, TYPE_HINA) then 
		local pCity = CityManager.GetCity(playerID, cityID)
		if pCity == nil then return; end
		if pCity:GetBuildings():HasBuilding(GameInfo.Buildings["BUILDING_BUILDING_BLOCK_HINA_gkls621"].Index) then
			pCity:GetBuildings():RemoveBuilding(GameInfo.Buildings["BUILDING_BUILDING_BLOCK_HINA_gkls621"].Index)
			print("Hina's building block removed for losing city")
		end
		return
	end
	local pCity = CityManager.GetCity(playerID, cityID)
	if pCity:GetDistricts():GetNumDistricts() <= 1 then return; end
	for tRow in GameInfo.Buildings() do
		if tRow.PrereqDistrict == "DISTRICT_CAMPUS" and tRow.BuildingType ~= "BUILDING_BUILDING_BLOCK_HINA_gkls621" then
			if pCity:GetBuildings():HasBuilding(tRow.Index) then
				pCity:GetBuildings():RemoveBuilding(tRow.Index)
				print("Hina removed "..tRow.BuildingType.." in captured city "..cityID)
			end
		end
	end
end

--[[function GklsHinaOnHighAdjacencyDistrictPlaced(playerID, cityID, orderType, objectID, bCancelled)
	if (playerID == -1) or (cityID == -1) then return; end
	if not GklsCivTraitMatches(playerID, TYPE_HINA) then return; end
	local pCity = CityManager.GetCity(iPlayer, iCity)
	if not pCity then return end
	local pCityBuildingQueue = pCity:GetBuildQueue()
	local districtType = ExposedMembers.GklsPasPale.GklsPasPaleGetDistrictType(playerID, cityID)
	if (districtType == -1) then return end
	local iCost
	if districtType == ASTRONOMY_CLUB_INDEX then
		if ExposedMembers.GklsPasPale.GklsPasPaleHasHighAdjacency(playerID, cityID, districtType, "YIELD_SCIENCE") >= 3 then
			if (ExposedMembers.GklsPasPale.GklsPasPaleGetDistrictProgress(playerID, cityID, ASTRONOMY_CLUB_INDEX) == 0) then
				iCost = pCityBuildingQueue:GetDistrictCost(objectID)
				pCityBuildingQueue:AddProgress(iCost* 0.5)
			end
		end
	elseif districtType == HARBOR_INDEX then
		if ExposedMembers.GklsPasPale.GklsPasPaleHasHighAdjacency(playerID, cityID, districtType, "YIELD_GOLD") >= 4 then
			if (ExposedMembers.GklsPasPale.GklsPasPaleGetDistrictProgress(playerID, cityID, HARBOR_INDEX) == 0) then
				iCost = pCityBuildingQueue:GetDistrictCost(objectID)
				pCityBuildingQueue:AddProgress(iCost* 0.5)
			end
		end
	elseif districtType == INDUSTRY_INDEX then
		if ExposedMembers.GklsPasPale.GklsPasPaleHasHighAdjacency(playerID, cityID, districtType, "YIELD_PRODUCTION") >= 4 then
			if (ExposedMembers.GklsPasPale.GklsPasPaleGetDistrictProgress(playerID, cityID, INDUSTRY_INDEX) == 0) then
				iCost = ExposedMembers.GklsPasPale.GklsPasPaleGetDistrictCost(playerID, cityID, objectID)
				pCityBuildingQueue:AddProgress(iCost* 0.5)
			end
		end
	elseif districtType == IDOL_THEATER_INDEX then
		if ExposedMembers.GklsPasPale.GklsPasPaleHasHighAdjacency(playerID, cityID, districtType, "YIELD_CULTURE") >= 3 then
			if (ExposedMembers.GklsPasPale.GklsPasPaleGetDistrictProgress(playerID, cityID, IDOL_THEATER_INDEX) == 0) then
				iCost = ExposedMembers.GklsPasPale.GklsPasPaleGetDistrictCost(playerID, cityID, objectID)
				pCityBuildingQueue:AddProgress(iCost* 0.5)
			end
		end
	elseif districtType == HOLY_SITE_INDEX then
		if ExposedMembers.GklsPasPale.GklsPasPaleHasHighAdjacency(playerID, cityID, districtType, "YIELD_FAITH") >= 3 then
			if (ExposedMembers.GklsPasPale.GklsPasPaleGetDistrictProgress(playerID, cityID, HOLY_SITE_INDEX) == 0) then
				iCost = ExposedMembers.GklsPasPale.GklsPasPaleGetDistrictCost(playerID, cityID, objectID)
				pCityBuildingQueue:AddProgress(iCost* 0.5)
			end
		end
	elseif districtType == COMMERCE_INDEX then
		if ExposedMembers.GklsPasPale.GklsPasPaleHasHighAdjacency(playerID, cityID, districtType, "YIELD_GOLD") >= 4 then
			if (ExposedMembers.GklsPasPale.GklsPasPaleGetDistrictProgress(playerID, cityID, COMMERCE_INDEX) == 0) then
				iCost = ExposedMembers.GklsPasPale.GklsPasPaleGetDistrictCost(playerID, cityID, objectID)
				pCityBuildingQueue:AddProgress(iCost* 0.5)
			end
		end
	end
end]]--

function GklsEveOnUnitKilledInCombat(killedPlayerID, killedUnitID, playerID, unitID)
	if (killedPlayerID == -1) or (playerID == -1) then return; end
    if (killedUnitID == -1) or (unitID == -1) then return; end
	if GklsLeaderMatches(playerID, TYPE_EVE) then
		local pPlayer = Players[playerID]
		local EveMartyrNum = pPlayer:GetProperty("EVE_DEATH_FAITH") or 0
		if EveMartyrNum >= 255*2 then return; end -- In case of overflow
		pPlayer:SetProperty("EVE_DEATH_FAITH", EveMartyrNum +1)
		print("Eve victory property ++")
		local pUnit = UnitManager.GetUnit(playerID, unitID)
		local killedUnit = UnitManager.GetUnit(killedPlayerID, killedUnitID)
		if pUnit == nil or killedUnit == nil then return; end
		if GameInfo.Units[pUnit:GetType()].Combat < GameInfo.Units[killedUnit:GetType()].Combat then
			pPlayer:GetCulture():ChangeCurrentCulturalProgress(GameInfo.Units[killedUnit:GetType()].Combat)
			pPlayer:GetTechs():ChangeCurrentResearchProgress(GameInfo.Units[killedUnit:GetType()].Combat)
			pPlayer:GetReligion():ChangeFaithBalance(GameInfo.Units[killedUnit:GetType()].Combat)
			EveMartyrNum = pPlayer:GetProperty("EVE_DEATH_FAITH") or 0
			if EveMartyrNum >= 255*2 then return; end -- In case of overflow
	    	pPlayer:SetProperty("EVE_DEATH_FAITH", EveMartyrNum +1)
			print("Eve victory property EXTRA ++")
		end
	end
 	if GklsLeaderMatches(killedPlayerID, TYPE_EVE) then
		local pPlayer = Players[killedPlayerID]
		local EveMartyrNum = pPlayer:GetProperty("EVE_DEATH_FAITH") or 0
		if EveMartyrNum >= 255*2 then return; end -- In case of overflow
		pPlayer:SetProperty("EVE_DEATH_FAITH", EveMartyrNum +1)
		print("Eve martyr property ++")
		local pUnit = UnitManager.GetUnit(playerID, unitID)
		local killedUnit = UnitManager.GetUnit(killedPlayerID, killedUnitID)
		if pUnit == nil or killedUnit == nil then return; end
		if GameInfo.Units[pUnit:GetType()].Combat > GameInfo.Units[killedUnit:GetType()].Combat then
			EveMartyrNum = pPlayer:GetProperty("EVE_DEATH_FAITH") or 0
	    	pPlayer:SetProperty("EVE_DEATH_FAITH", EveMartyrNum +1)
			print("Eve martyr property EXTRA ++")
		end
	end
end

--[[function GklsChisatoOnPlayerEraChanged(playerID, eraID)
	if (playerID == -1) or (eraID == -1) or (eraID == 0) then return; end
	if not GklsLeaderMatches(playerID, TYPE_CHISATO) then return; end
	local pPlayer = Players[playerID];
	if not(pPlayer:IsMajor() and pPlayer:IsAlive()) then return; end
	local GovernmentType = ExposedMembers.GklsPasPale.GklsPasPaleGetGovernment(playerID)
	if (GovernmentType == nil) or (GovernmentType ~= COMMUNISM_INDEX) then return; end
	local playerCities = pPlayer:GetCities()
	for _, pCity in playerCities:Members() do
		if pCity ~= nil then
			local location = pCity:GetLocation()
			local iX = location.x; local iY = location.y;
			UnitManager.InitUnitValidAdjacentHex(playerID, "UNIT_ROCK_BAND", iX, iY, 1)
		end
	end
end]]--

function GklsChisatoOnGovernmentChanged(playerID, governmentID)
	if (playerID == -1) or (governmentID == -1) then return; end
	if not GklsLeaderMatches(playerID, TYPE_CHISATO) then return; end
	local pPlayer = Players[playerID]
	local FirstCommunism = pPlayer:GetProperty("CHISATO_COMMUNISM_FLAG") or 0
	if FirstCommunism ~= 0 then return; end
	if governmentID == COMMUNISM_INDEX then
		local playerCities = pPlayer:GetCities()
		for _, pCity in playerCities:Members() do
			if pCity ~= nil then
				local location = pCity:GetLocation()
				local iX = location.x; local iY = location.y;
				UnitManager.InitUnitValidAdjacentHex(playerID, "UNIT_ROCK_BAND", iX, iY, 1)
			end
		end
		pPlayer:SetProperty("CHISATO_COMMUNISM_FLAG", 1)
		print("Chisato switched to Communism for the first time. УРА!")
	end
end


function GklsPasPaleInitialise()
	Events.PlayerEraScoreChanged.Add(GklsAyaOnEraScoreChanged)
    Events.TechBoostTriggered.Add(GklsAyaOnTechBoosted)
    Events.ResearchCompleted.Add(GklsAyaOnTechBoosted)
	Events.DistrictBuildProgressChanged.Add(GklsHinaOnDistrictCompleted)
	Events.CityInitialized.Add(GklsHinaOnCityInitialised)
	Events.UnitKilledInCombat.Add(GklsEveOnUnitKilledInCombat)
	Events.GovernmentChanged.Add(GklsChisatoOnGovernmentChanged)
	GameEvents.GklsPasPaleAddProduction.Add(GklsPasPaleAddProduction)
	local RELOAD_PREVENTION = Game:GetProperty("PASPALE_GAME_RELOADED") or 0
	if RELOAD_PREVENTION == 1 then return; end
	local tMajors = PlayerManager.GetAliveMajorIDs()
	local currentTurn = Game.GetCurrentGameTurn()
	local startTurn = GameConfiguration.GetStartTurn()
	Game:SetProperty("PASPALE_GAME_RELOADED", 1)
	for _, playerID in ipairs(tMajors) do
		if GklsCivTraitMatches(playerID, "TRAIT_CIVILIZATION_PASPALE_gkls621") then
			if currentTurn == startTurn then
				local pPlayer = Players[playerID]
				local civicID = GameInfo.Civics["CIVIC_DRAMA_POETRY"].Index
				if not (pPlayer:GetCulture():HasCivic(civicID)) then
					if (GklsLeaderMatches(playerID, TYPE_CHISATO)) then
						pPlayer:GetCulture():SetCulturalProgress(civicID, 0.8*pPlayer:GetCulture():GetCultureCost(civicID))
						print("DRAMA AND POETRY: 80 percent progress for Chisato!")
					else
						pPlayer:GetCulture():SetCulturalProgress(civicID, 0.5*pPlayer:GetCulture():GetCultureCost(civicID))
						print("DRAMA AND POETRY: 50 percent progress for other Paspales!")
					end
				end
			end
		end
	end
end

Events.LoadGameViewStateDone.Add(GklsPasPaleInitialise)