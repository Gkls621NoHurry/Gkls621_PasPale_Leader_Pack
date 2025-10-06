-- Eve's Unique District
INSERT INTO Types
(Type,  Kind)
VALUES
('DISTRICT_KENDO_CLUB_gkls621',    'KIND_DISTRICT'),
('TRAIT_DISTRICT_KENDO_CLUB_gkls621',  'KIND_TRAIT');

INSERT INTO Traits
(TraitType, Name,   Description)
VALUES
('TRAIT_DISTRICT_KENDO_CLUB_gkls621',  'LOC_DISTRICT_KENDO_CLUB_gkls621_NAME',    'LOC_DISTRICT_KENDO_CLUB_gkls621_DESCRIPTION');

INSERT INTO DistrictReplaces
(CivUniqueDistrictType, ReplacesDistrictType)
VALUES
('DISTRICT_KENDO_CLUB_gkls621',    'DISTRICT_ENCAMPMENT');

INSERT INTO Districts 
(   DistrictType,
    Name,
    PrereqTech,
    PrereqCivic,
    Coast,
    Description,
    Cost,
    RequiresPlacement,
    RequiresPopulation,
    NoAdjacentCity,
    CityCenter,
    Aqueduct,
    InternalOnly,
    ZOC,
    FreeEmbark,
    HitPoints,
    CaptureRemovesBuildings,
    CaptureRemovesCityDefenses,
    PlunderType,
    PlunderAmount,
    TradeEmbark,
    MilitaryDomain,
    CostProgressionModel,
    CostProgressionParam1,
    TraitType,
    Appeal,
    Housing,
    Entertainment,
    OnePerCity,
    AllowsHolyCity,
    Maintenance,
    AirSlots,
    CitizenSlots,
    TravelTime,
    CityStrengthModifier,
    AdjacentToLand,
    CanAttack,
    AdvisorType,
    CaptureRemovesDistrict,
    MaxPerPlayer
)SELECT
    'DISTRICT_KENDO_CLUB_gkls621',
    'LOC_DISTRICT_KENDO_CLUB_gkls621_NAME',
    NULL,
    'CIVIC_EARLY_EMPIRE',
    Coast,
    'LOC_DISTRICT_KENDO_CLUB_gkls621_DESCRIPTION',
    Cost *0.5,
    RequiresPlacement,
    RequiresPopulation,
    0,
    CityCenter,
    Aqueduct,
    InternalOnly,
    ZOC,
    FreeEmbark,
    HitPoints,
    CaptureRemovesBuildings,
    CaptureRemovesCityDefenses,
    PlunderType,
    PlunderAmount,
    TradeEmbark,
    MilitaryDomain,
    CostProgressionModel,
    CostProgressionParam1 *0.5,
    'TRAIT_DISTRICT_KENDO_CLUB_gkls621',
    1,
    Housing,
    2,
    OnePerCity,
    AllowsHolyCity,
    0,
    AirSlots,
    2,
    TravelTime,
    CityStrengthModifier,
    AdjacentToLand,
    CanAttack,
    AdvisorType,
    CaptureRemovesDistrict,
    MaxPerPlayer
FROM Districts WHERE DistrictType = 'DISTRICT_ENCAMPMENT';

INSERT INTO Districts_XP2
(DistrictType,  AttackRange)
VALUES
('DISTRICT_KENDO_CLUB_gkls621', 2);

INSERT INTO District_GreatPersonPoints
(DistrictType,  GreatPersonClassType,   PointsPerTurn)
SELECT DISTINCT 'DISTRICT_KENDO_CLUB_gkls621',  GreatPersonClassType,   PointsPerTurn
FROM District_GreatPersonPoints WHERE DistrictType = 'DISTRICT_ENCAMPMENT';

INSERT INTO District_GreatPersonPoints
(DistrictType,  GreatPersonClassType,   PointsPerTurn)
VALUES
('DISTRICT_KENDO_CLUB_gkls621',   'GREAT_PERSON_CLASS_IDOL_gkls621',  2);

INSERT INTO District_TradeRouteYields
(DistrictType,  YieldType,  YieldChangeAsOrigin,    YieldChangeAsDomesticDestination,   YieldChangeAsInternationalDestination)
SELECT
'DISTRICT_KENDO_CLUB_gkls621', YieldType,
YieldChangeAsOrigin,    YieldChangeAsDomesticDestination,   YieldChangeAsInternationalDestination
FROM District_TradeRouteYields WHERE DistrictType = 'DISTRICT_ENCAMPMENT';

INSERT OR IGNORE INTO District_TradeRouteYields
(DistrictType,  YieldType,  YieldChangeAsOrigin,    YieldChangeAsDomesticDestination,   YieldChangeAsInternationalDestination)
VALUES
('DISTRICT_KENDO_CLUB_gkls621', 'YIELD_FAITH',
1,    1,   1);

INSERT INTO District_CitizenYieldChanges
(DistrictType,  YieldType,  YieldChange)
VALUES
('DISTRICT_KENDO_CLUB_gkls621', 'YIELD_FAITH',  1),
('DISTRICT_KENDO_CLUB_gkls621', 'YIELD_PRODUCTION',  2);

INSERT INTO District_Adjacencies
(DistrictType,  YieldChangeId)
SELECT
'DISTRICT_KENDO_CLUB_gkls621', 'KENDO_CLUB_' || TerrainType ||'_FAITH_gkls621'
FROM Terrains WHERE TerrainType LIKE 'TERRAIN_TUNDRA%' OR TerrainType LIKE 'TERRAIN_SNOW%';

INSERT INTO District_Adjacencies
(DistrictType,  YieldChangeId)
SELECT
'DISTRICT_KENDO_CLUB_gkls621', 'KENDO_CLUB_' || TerrainType ||'_FOOD_gkls621'
FROM Terrains WHERE TerrainType LIKE 'TERRAIN_TUNDRA%' OR TerrainType LIKE 'TERRAIN_SNOW%';

INSERT INTO District_Adjacencies
(DistrictType,  YieldChangeId)
VALUES
('DISTRICT_KENDO_CLUB_gkls621', 'KENDO_CLUB_IDOL_THEATER_FAITH_gkls621'),
('DISTRICT_KENDO_CLUB_gkls621', 'KENDO_CLUB_FISSURE_FAITH_gkls621'),
('DISTRICT_KENDO_CLUB_gkls621', 'KENDO_CLUB_VOLCANO_FAITH_gkls621'),
('DISTRICT_KENDO_CLUB_gkls621', 'KENDO_CLUB_VOLCANIC_SOIL_FAITH_gkls621'),
('DISTRICT_KENDO_CLUB_gkls621', 'KENDO_CLUB_REEF_FAITH_gkls621'),
('DISTRICT_IDOL_THEATER_gkls621', 'IDOL_THEATER_KENDO_CLUB_CULTURE_gkls621');

INSERT INTO Adjacency_YieldChanges
(ID,    Description,    YieldType,  YieldChange,    TilesRequired,  AdjacentTerrain)
SELECT
'KENDO_CLUB_' || TerrainType ||'_FAITH_gkls621', 'LOC_KENDO_CLUB_TUNDRA_SNOW_FAITH_gkls621_DESCRIPTION',
'YIELD_FAITH', 1, 1, TerrainType
FROM Terrains WHERE TerrainType LIKE 'TERRAIN_TUNDRA%' OR TerrainType LIKE 'TERRAIN_SNOW%';

INSERT INTO Adjacency_YieldChanges
(ID,    Description,    YieldType,  YieldChange,    TilesRequired,  AdjacentTerrain)
SELECT
'KENDO_CLUB_' || TerrainType ||'_FOOD_gkls621', 'LOC_KENDO_CLUB_TUNDRA_SNOW_FOOD_gkls621_DESCRIPTION',
'YIELD_FOOD', 1, 1, TerrainType
FROM Terrains WHERE TerrainType LIKE 'TERRAIN_TUNDRA%' OR TerrainType LIKE 'TERRAIN_SNOW%';

INSERT INTO Adjacency_YieldChanges
(ID,    Description,    YieldType,  YieldChange,    TilesRequired,  AdjacentFeature)
VALUES
('KENDO_CLUB_FISSURE_FAITH_gkls621',    'LOC_KENDO_CLUB_FISSURE_FAITH_gkls621_DESCRIPTION',
'YIELD_FAITH', 2, 1, 'FEATURE_GEOTHERMAL_FISSURE'),
('KENDO_CLUB_VOLCANO_FAITH_gkls621',    'LOC_KENDO_CLUB_VOLCANO_FAITH_gkls621_DESCRIPTION',
'YIELD_FAITH', 2, 1, 'FEATURE_VOLCANO'),
('KENDO_CLUB_VOLCANIC_SOIL_FAITH_gkls621',    'LOC_KENDO_CLUB_VOLCANIC_SOIL_FAITH_gkls621_DESCRIPTION',
'YIELD_FAITH', 1, 1, 'FEATURE_VOLCANIC_SOIL'),
('KENDO_CLUB_REEF_FAITH_gkls621',    'LOC_KENDO_CLUB_REEF_FAITH_gkls621_DESCRIPTION',
'YIELD_FAITH', 2, 1, 'FEATURE_REEF');

INSERT INTO Adjacency_YieldChanges
(ID,    Description,    YieldType,  YieldChange,    TilesRequired,  AdjacentDistrict)
VALUES
('KENDO_CLUB_IDOL_THEATER_FAITH_gkls621',   'LOC_KENDO_CLUB_IDOL_THEATER_FAITH_gkls621_DESCRIPTION',
'YIELD_FAITH',  3,  1,  'DISTRICT_IDOL_THEATER_gkls621'),
('IDOL_THEATER_KENDO_CLUB_CULTURE_gkls621',
'LOC_IDOL_THEATER_KENDO_CLUB_CULTURE_gkls621_DESCRIPTION', 'YIELD_CULTURE', 3,
1, 'DISTRICT_KENDO_CLUB_gkls621');

INSERT INTO DistrictModifiers
(DistrictType,  ModifierId)
VALUES
('DISTRICT_KENDO_CLUB_gkls621', 'KENDO_CLUB_FAITH_PRODUCTION_gkls621'),
('DISTRICT_KENDO_CLUB_gkls621', 'KENDO_CLUB_FISSURE_AMENITIES_gkls621'),
('DISTRICT_KENDO_CLUB_gkls621', 'KENDO_CLUB_MELEE_RANGED_MOVEMENT_gkls621'),
('DISTRICT_KENDO_CLUB_gkls621', 'KENDO_CLUB_MELEE_RANGED_EXP_gkls621');

INSERT INTO PolicyModifiers
(PolicyType,    ModifierId)
VALUES
('POLICY_SCRIPTURE',    'SCRIPTURE_KENDO_CLUB_FAITH_gkls621');

INSERT INTO Modifiers
(ModifierId,    ModifierType,   RunOnce,    Permanent,  SubjectRequirementSetId)
VALUES
('KENDO_CLUB_FAITH_PRODUCTION_gkls621',   'MODIFIER_PLAYER_DISTRICT_ADJUST_YIELD_BASED_ON_ADJACENCY_BONUS',   1,  1,  'PLAYER_HAS_GOLDEN_AGE'),
('KENDO_CLUB_FISSURE_AMENITIES_gkls621',    'MODIFIER_SINGLE_CITY_ADJUST_ENTERTAINMENT',    0,  0,  'CITY_HAS_1_OR_MORE_GEOTHERMALFISSURE_REQUIREMENTS'),
('KENDO_CLUB_MELEE_RANGED_MOVEMENT_gkls621',    'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS', 0,  1,  NULL),
('KENDO_CLUB_MELEE_RANGED_EXP_gkls621', 'MODIFIER_SINGLE_CITY_GRANT_ABILITY_FOR_TRAINED_UNITS', 0,  1,  NULL),
('SCRIPTURE_KENDO_CLUB_FAITH_gkls621',  'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_MODIFIER',  0,  0,  'REQSET_PASPALE_DISTRICT_IS_KENDO_CLUB_gkls621');

INSERT INTO ModifierArguments
(ModifierId,    Name,   Value)
VALUES
('KENDO_CLUB_FAITH_PRODUCTION_gkls621', 'DistrictType',    'DISTRICT_KENDO_CLUB_gkls621'),
('KENDO_CLUB_FAITH_PRODUCTION_gkls621', 'YieldTypeToMirror',    'YIELD_FAITH'),
('KENDO_CLUB_FAITH_PRODUCTION_gkls621', 'YieldTypeToGrant',    'YIELD_PRODUCTION'),
('KENDO_CLUB_FISSURE_AMENITIES_gkls621',    'Amount',   2),
('KENDO_CLUB_MELEE_RANGED_MOVEMENT_gkls621',    'AbilityType',  'ABILITY_KENDO_CLUB_MOVEMENT_gkls621'),
('KENDO_CLUB_MELEE_RANGED_EXP_gkls621',    'AbilityType',  'ABILITY_KENDO_CLUB_EXP_gkls621'),
('SCRIPTURE_KENDO_CLUB_FAITH_gkls621',  'YieldType',    'YIELD_FAITH'),
('SCRIPTURE_KENDO_CLUB_FAITH_gkls621',  'Amount',    100);

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES
('REQSET_PASPALE_DISTRICT_IS_KENDO_CLUB_gkls621', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES
('REQSET_PASPALE_DISTRICT_IS_KENDO_CLUB_gkls621', 'PASPALE_DISTRICT_IS_KENDO_CLUB_gkls621');

INSERT INTO Requirements (RequirementId, RequirementType)
VALUES
('PASPALE_DISTRICT_IS_KENDO_CLUB_gkls621', 'REQUIREMENT_DISTRICT_TYPE_MATCHES');

INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES
('PASPALE_DISTRICT_IS_KENDO_CLUB_gkls621', 'DistrictType', 'DISTRICT_KENDO_CLUB_gkls621');