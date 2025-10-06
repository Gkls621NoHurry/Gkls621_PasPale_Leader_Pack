local TYPE_MAYA = "LEADER_MAYA_gkls621"
local CITY_CENTRE_INDEX = GameInfo.Districts["DISTRICT_CITY_CENTER"].Index or -1
local WONDER_INDEX = GameInfo.Districts["DISTRICT_WONDER"].Index or -1

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

-- Based on Ruivo's New Adjacency
function Gkls_RuivoGetRingPlotIndexes(iX, iY, maxRing)
    --print("Gkls_RuivoGetRingPlotIndexes( "..iX.." , "..iY.." , "..maxRing..") starts")
    local resultPlotIndex = {}   -- 存储最终结果的格子索引列表
    local visited = {}           -- 标记已经访问过的格子，防止重复访问
    local queue = {}             -- 用于广度优先搜索的队列（FIFO）

    local centerPlot = Map.GetPlot(iX, iY)  -- 获取中心格对象
    if not centerPlot then return resultPlotIndex end  -- 如果中心格无效，返回空结果

    local centerIndex = centerPlot:GetIndex()  -- 获取中心格的索引
    visited[centerIndex] = true                -- 标记中心格为已访问
    --table.insert(resultPlotIndex, centerIndex) -- 加入结果列表
    table.insert(queue, centerIndex)           -- 加入队列，开始BFS搜索

    -- 广度优先搜索，逐层扩展格子
    while #queue > 0 do
        local currentIndex = table.remove(queue, 1)        -- 取出当前处理的格子索引
        local plot = Map.GetPlotByIndex(currentIndex)      -- 获取对应格子对象
        local dist = Map.GetPlotDistance(iX, iY, plot:GetX(), plot:GetY()) -- 计算该格子与中心格的距离

        -- 如果该格子在 maxRing 范围内，继续扩展它的相邻格子
        if dist < maxRing then
            local adjPlots = Map.GetAdjacentPlots(plot:GetX(), plot:GetY()) -- 获取相邻格子
            for _, adj in ipairs(adjPlots) do
                if adj then
                    local adjIndex = adj:GetIndex()  -- 获取相邻格子的索引
                    if not visited[adjIndex] then   -- 如果未访问过
                        visited[adjIndex] = true    -- 标记为已访问
                        table.insert(queue, adjIndex)           -- 加入队列以便后续扩展
                    end
                end
            end
        elseif dist == maxRing then
            table.insert(resultPlotIndex, currentIndex);
            --print(currentIndex.." inserted into "..maxRing.." plots!")
        end
    end
    if #resultPlotIndex == 0 then print("Gkls_RuivoRetRingPlotIndexes gets NO TILES"); end
    return resultPlotIndex  -- 返回所有在 maxRing 范围内的格子索引
end
-- Original function, containing plots of all these rings
function Vanilla_RuivoGetRingPlotIndexes(iX, iY, maxRing)
    --print("Vanilla_RuivoGetRingPlotIndexes( "..iX.." , "..iY.." , "..maxRing..") starts")
    local resultPlotIndex = {}   -- 存储最终结果的格子索引列表
    local visited = {}           -- 标记已经访问过的格子，防止重复访问
    local queue = {}             -- 用于广度优先搜索的队列（FIFO）

    local centerPlot = Map.GetPlot(iX, iY)  -- 获取中心格对象
    if not centerPlot then return resultPlotIndex end  -- 如果中心格无效，返回空结果

    local centerIndex = centerPlot:GetIndex()  -- 获取中心格的索引
    visited[centerIndex] = true                -- 标记中心格为已访问
    table.insert(resultPlotIndex, centerIndex) -- 加入结果列表
    table.insert(queue, centerIndex)           -- 加入队列，开始BFS搜索

    -- 广度优先搜索，逐层扩展格子
    while #queue > 0 do
        local currentIndex = table.remove(queue, 1)        -- 取出当前处理的格子索引
        local plot = Map.GetPlotByIndex(currentIndex)      -- 获取对应格子对象
        local dist = Map.GetPlotDistance(iX, iY, plot:GetX(), plot:GetY()) -- 计算该格子与中心格的距离

        -- 如果该格子在 maxRing 范围内，继续扩展它的相邻格子
        if dist < maxRing then
            local adjPlots = Map.GetAdjacentPlots(plot:GetX(), plot:GetY()) -- 获取相邻格子
            for _, adj in ipairs(adjPlots) do
                if adj then
                    local adjIndex = adj:GetIndex()  -- 获取相邻格子的索引
                    if not visited[adjIndex] then   -- 如果未访问过
                        visited[adjIndex] = true    -- 标记为已访问
                        table.insert(resultPlotIndex, adjIndex) -- 加入结果列表
                        --print(adjIndex.." inserted into all plots within "..maxRing)
                        table.insert(queue, adjIndex)           -- 加入队列以便后续扩展
                    end
                end
            end
        end
    end

    return resultPlotIndex  -- 返回所有在 maxRing 范围内的格子索引
end

-- Also based on Ruivo's code...
Maya_DistrictCompletedSwitch = false
function GklsMayaOnDistrictCompleted(playerID, districtID, cityID, iX, iY, districtType, era, civilization, iPercentComplete, iAppeal, isPillaged)
    --建成时刷新
    if iPercentComplete == 100 then
        if playerID == -1 then return; end
        if not(GklsLeaderMatches(playerID, TYPE_MAYA)) then return; end

        --因为区域建成事件必然触发2次所以使用开关法
        if Maya_DistrictCompletedSwitch then
            Maya_DistrictCompletedSwitch = false
            return
        end
        Maya_DistrictCompletedSwitch = true 
        -- "Defensive Programming"
        if districtType and iX and iY then
            local plot = Map.GetPlot(iX, iY)
            if plot then
                local district = CityManager.GetDistrictAt(plot)
                if district then
                    GklsMayaStarter(iX, iY)
                    --print("GklsMayaStarter("..iX.." , "..iY..") starts!")
                end
            end
        end
    end
end

function GklsMayaStarter(iX, iY)
    local PlotsToUpdate = Vanilla_RuivoGetRingPlotIndexes(iX, iY, 2)
    for _, PlotIndex in ipairs(PlotsToUpdate) do
        --print("GklsMayaStarter( "..iX.." , "..iY.." ): plot "..PlotIndex)
        local plot = Map.GetPlotByIndex(PlotIndex)
        if plot ~= nil then
            local districtType = plot:GetDistrictType()
            if (districtType ~= -1) and (districtType ~= WONDER_INDEX) then
                local plotX = plot:GetX()
                local plotY = plot:GetY()
                GklsMayaCounter(plotX, plotY, districtType)
                --print("GklsMayaCounter("..plotX.." , "..plotY.." , "..GameInfo.Districts[districtType].DistrictType.." ) starts!")
            end
        end
    end
end

function Gkls_Ruivo_Zip_SetProperty(iX, iY, ringValue, districtType, ringType) -- by DeepSeek /(ㄒoㄒ)/~~
    -- 确保districtType参数提供区域类型（如"INDUSTRIAL_ZONE"）
    if not districtType then 
        print("ERROR: districtType Invalid in Maya_Ruivo_Zip_SetProperty")
        return
    end
    
    local pPlot = Map.GetPlot(iX, iY)
    if not pPlot then return end
    
    local districtName = GameInfo.Districts[districtType].DistrictType
    --local binaryList = {1, 2, 4, 8, 16, 32, 64, 128, 256, 512}
    local yieldList = {"YIELD_PRODUCTION", "YIELD_FOOD", "YIELD_GOLD", "YIELD_FAITH", "YIELD_SCIENCE", "YIELD_CULTURE"}
    local resultList = {}
    
    -- 二进制分解
    --[[local remaining = ringValue
    for i = #binaryList, 1, -1 do
        resultList[i] = 0
        if remaining >= binaryList[i] then
            resultList[i] = 1
            remaining = remaining - binaryList[i]
        end
    end ]]--
    
    -- 格式: MAYA_[区域类型]_[产出类型]_[环类型]_[唯一后缀] 
    -- 设置Ruivo兼容属性
    for j = 1, #yieldList do
        local propertyKey = "MAYA_"..districtName.."_"..yieldList[j].."_"..ringType.."_gkls621" --.. binaryList[i]
        pPlot:SetProperty(propertyKey, ringValue)
        --[[for i = 1, #yieldList do            
            --pPlot:SetProperty(propertyKey, resultList[i])            
            print("Maya property set: "..propertyKey.."_"..binaryList[j].." = "..resultList[j])
        end     ]]--   
    end
end


function GklsMayaCounter(iX, iY, districtType)
    local Factor_RingOne = 200
    local Factor_RingTwo = 100
    local pPlot = Map.GetPlot(iX, iY)
    local Stat_RingOne:table = {}
    local Stat_RingTwo:table = {}
    local Plots_RingOne = Gkls_RuivoGetRingPlotIndexes(iX, iY, 1)
    local Plots_RingTwo = Gkls_RuivoGetRingPlotIndexes(iX, iY, 2)
    for _, PlotIndex in pairs(Plots_RingOne) do
        local plot = Map.GetPlotByIndex(PlotIndex)
        if (plot ~= nil) then 
            local district = CityManager.GetDistrictAt(plot)
            if district then
                local iDistrictType = district:GetType()
                --local districtPlot = Map.GetPlot(district:GetX(), district:GetY())
                if (GameInfo.Districts[iDistrictType]) and (iDistrictType ~= WONDER_INDEX) then
                    local TempAdder = Stat_RingOne[iDistrictType +1] or 0
                    Stat_RingOne[iDistrictType +1] = TempAdder +1
                    --print("Stat_RingOne["..(iDistrictType+1).."] = ".. Stat_RingOne[iDistrictType +1])
                end
            end
        end
    end
    local Plot_Property_RingOne = 0  
    for _, value in pairs(Stat_RingOne) do
        if value ~= nil then
            Plot_Property_RingOne = Plot_Property_RingOne + math.floor(value/2)
        end 
        --print("Plot_Property_RingOne += "..value/2)
    end
    --print("Maya plot "..iX..","..iY.." ring-1 property = "..Plot_Property_RingOne)
    for _, PlotIndex in pairs(Plots_RingTwo) do
        local plot = Map.GetPlotByIndex(PlotIndex)
        if (plot ~= nil) then 
            local district = CityManager.GetDistrictAt(plot)
            if district then
                local iDistrictType = district:GetType()
                --local districtPlot = Map.GetPlot(district:GetX(), district:GetY())
                if GameInfo.Districts[iDistrictType] then
                    local TempAdder = Stat_RingTwo[iDistrictType +1] or 0
                    Stat_RingTwo[iDistrictType +1] = TempAdder +1
                    --print("Stat_RingTwo["..(iDistrictType+1).."] = ".. Stat_RingTwo[iDistrictType +1])
                end
            end
        end
    end
    local Plot_Property_RingTwo = 0  
    for _, value in pairs(Stat_RingTwo) do
        if value ~= nil then
            Plot_Property_RingTwo = Plot_Property_RingTwo + math.floor(value/2)
            --print("Plot_Property_RingTwo += "..value/2)
        end
    end
    --print("Maya plot "..iX..","..iY.." ring-2 property = "..Plot_Property_RingTwo)

    Gkls_Ruivo_Zip_SetProperty(iX, iY, Plot_Property_RingOne * Factor_RingOne, districtType, "RING1")
    Gkls_Ruivo_Zip_SetProperty(iX, iY, Plot_Property_RingTwo * Factor_RingTwo, districtType, "RING2")
    --pPlot:SetProperty("MAYA_PLOT_RING1", Plot_Property_RingOne)
    --pPlot:SetProperty("MAYA_PLOT_RING2", Plot_Property_RingTwo)

end

function GklsMayaOnCityConquered(newPlayerID, oldPlayerID, newCityID, iCityX, iCityY)
    if newPlayerID == -1 or oldPlayerID == -1 then return; end
    if iCityX == -1 or iCityY == -1 then return; end
    if not(GklsLeaderMatches(newPlayerID, TYPE_MAYA)) then return; end
    if (GklsLeaderMatches(oldPlayerID, TYPE_MAYA)) then return; end
    local PlotsToUpdate = Vanilla_RuivoGetRingPlotIndexes(iCityX, iCityY, 3)
    for _, PlotIndex in ipairs(PlotsToUpdate) do
        local plot = Map.GetPlotByIndex(PlotIndex)
        if plot ~= nil then
            local districtType = plot:GetDistrictType()
            if (districtType ~= -1) and (districtType ~= CITY_CENTRE_INDEX) and (districtType ~= WONDER_INDEX) then
                local plotX = plot:GetX()
                local plotY = plot:GetY()
                GklsMayaCounter(plotX, plotY)
            end
        end
    end
end

function GklsMayaInitialise()
    Events.DistrictBuildProgressChanged.Add(GklsMayaOnDistrictCompleted)
    GameEvents.CityConquered.Add(GklsMayaOnCityConquered)
end

Events.LoadGameViewStateDone.Add(GklsMayaInitialise)
    