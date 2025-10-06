-- Pastel*Palettes Civ Unique District
INSERT INTO Types
(Type,  Kind)
VALUES
('DISTRICT_IDOL_THEATER_gkls621',    'KIND_DISTRICT'),
('TRAIT_DISTRICT_IDOL_THEATER_gkls621',  'KIND_TRAIT');

INSERT INTO Traits
(TraitType, Name,   Description)
VALUES
('TRAIT_DISTRICT_IDOL_THEATER_gkls621',  'LOC_DISTRICT_IDOL_THEATER_gkls621_NAME',    'LOC_DISTRICT_IDOL_THEATER_gkls621_DESCRIPTION');

INSERT INTO DistrictReplaces
(CivUniqueDistrictType, ReplacesDistrictType)
VALUES
('DISTRICT_IDOL_THEATER_gkls621',    'DISTRICT_THEATER');

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
    'DISTRICT_IDOL_THEATER_gkls621',
    'LOC_DISTRICT_IDOL_THEATER_gkls621_NAME',
    PrereqTech,
    'CIVIC_DRAMA_POETRY',
    Coast,
    'LOC_DISTRICT_IDOL_THEATER_gkls621_DESCRIPTION',
    Cost *0.5,
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
    CostProgressionParam1 *0.5,
    'TRAIT_DISTRICT_IDOL_THEATER_gkls621',
    1,
    Housing,
    2,
    OnePerCity,
    AllowsHolyCity,
    Maintenance,
    AirSlots,
    1,
    TravelTime,
    CityStrengthModifier,
    AdjacentToLand,
    CanAttack,
    AdvisorType,
    CaptureRemovesDistrict,
    MaxPerPlayer
FROM Districts WHERE DistrictType = 'DISTRICT_THEATER';

INSERT INTO District_GreatPersonPoints
(DistrictType,  GreatPersonClassType,   PointsPerTurn)
SELECT DISTINCT 'DISTRICT_IDOL_THEATER_gkls621',  GreatPersonClassType,   PointsPerTurn
FROM District_GreatPersonPoints WHERE DistrictType = 'DISTRICT_THEATER';

INSERT INTO District_GreatPersonPoints
(DistrictType,  GreatPersonClassType,   PointsPerTurn)
VALUES
('DISTRICT_IDOL_THEATER_gkls621',   'GREAT_PERSON_CLASS_IDOL_gkls621',  1);

INSERT INTO District_TradeRouteYields
(DistrictType,  YieldType,  YieldChangeAsOrigin,    YieldChangeAsDomesticDestination,   YieldChangeAsInternationalDestination)
VALUES
('DISTRICT_IDOL_THEATER_gkls621',  'YIELD_CULTURE',
1,  0,   2),
('DISTRICT_IDOL_THEATER_gkls621',  'YIELD_GOLD',
1,  1,   2);

INSERT INTO District_CitizenYieldChanges
(DistrictType,  YieldType,  YieldChange)
SELECT
'DISTRICT_IDOL_THEATER_gkls621', YieldType, YieldChange
FROM District_CitizenYieldChanges WHERE DistrictType = 'DISTRICT_THEATER';

INSERT INTO District_Adjacencies
(DistrictType,  YieldChangeId)
SELECT
'DISTRICT_IDOL_THEATER_gkls621',    YieldChangeId
FROM District_Adjacencies
WHERE DistrictType = 'DISTRICT_THEATER';

INSERT INTO District_Adjacencies
(DistrictType,  YieldChangeId)
VALUES
('DISTRICT_IDOL_THEATER_gkls621', 'IDOL_THEATER_DISTRICT_GOLD_gkls621'),
('DISTRICT_IDOL_THEATER_gkls621',   'IDOL_THEATER_WONDER_GOLD_gkls621');

INSERT INTO District_Adjacencies
(DistrictType,  YieldChangeId)
SELECT
'DISTRICT_IDOL_THEATER_gkls621', 'IDOL_THEATER_' || ImprovementType || '_GOLD_gkls621'
FROM Improvements WHERE TraitType IS NULL OR TraitType LIKE 'MINOR%';

INSERT INTO Adjacency_YieldChanges
(ID,    Description,    YieldType,  YieldChange,    TilesRequired,  OtherDistrictAdjacent)
SELECT
'IDOL_THEATER_DISTRICT_GOLD_gkls621',
'LOC_IDOL_THEATER_DISTRICT_GOLD_gkls621_DESCRIPTION', 'YIELD_GOLD',
2, 1, 1;

INSERT INTO Adjacency_YieldChanges
(ID,    Description,    YieldType,  YieldChange,    TilesRequired,  AdjacentImprovement)
SELECT
'IDOL_THEATER_' || ImprovementType || '_GOLD_gkls621',
'LOC_IDOL_THEATER_IMPROVEMENT_GOLD_gkls621_DESCRIPTION', 'YIELD_GOLD', 2,
2, ImprovementType
FROM Improvements WHERE TraitType IS NULL OR TraitType LIKE 'MINOR%';

INSERT INTO Adjacency_YieldChanges
(ID,    Description,    YieldType,  YieldChange,    TilesRequired,  AdjacentWonder)
VALUES
('IDOL_THEATER_WONDER_GOLD_gkls621',    'LOC_IDOL_THEATER_WONDER_GOLD_gkls621_DESCRIPTION',
'YIELD_GOLD',   4,  1,  1);

INSERT INTO DistrictModifiers
(DistrictType,  ModifierId)
VALUES
('DISTRICT_IDOL_THEATER_gkls621', 'IDOL_THEATER_GOLD_TOURISM_gkls621'),
('DISTRICT_IDOL_THEATER_gkls621', 'IDOL_THEATER_ROCK_BAND_DISCOUNT_gkls621');

INSERT INTO Modifiers
(ModifierId,                                ModifierType,                                                       SubjectRequirementSetId)
VALUES
('IDOL_THEATER_GOLD_TOURISM_gkls621',       'MODIFIER_PLAYER_DISTRICT_ADJUST_TOURISM_ADJACENCY_YIELD_MOFIFIER', 'PLAYER_HAS_GOLDEN_AGE'),
('IDOL_THEATER_ROCK_BAND_DISCOUNT_gkls621', 'MODIFIER_SINGLE_CITY_ADJUST_UNIT_PURCHASE_COST',                   NULL),
('IDOL_THEATER_GOLD_gkls621',               'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_MODIFIER',                  'REQSET_PASPALE_DISTRICT_IS_IDOL_THEATER_gkls621');

INSERT INTO ModifierArguments
(ModifierId,    Name,   Value)
VALUES
('IDOL_THEATER_GOLD_TOURISM_gkls621',   'YieldType',    'YIELD_GOLD'),
('IDOL_THEATER_GOLD_TOURISM_gkls621',   'Amount',    50),
('IDOL_THEATER_ROCK_BAND_DISCOUNT_gkls621', 'UnitType', 'UNIT_ROCK_BAND'),
('IDOL_THEATER_ROCK_BAND_DISCOUNT_gkls621', 'Amount', 20),
('IDOL_THEATER_GOLD_gkls621',  'YieldType',    'YIELD_GOLD'),
('IDOL_THEATER_GOLD_gkls621',  'Amount',    100);

INSERT INTO PolicyModifiers
(PolicyType,    ModifierId)
VALUES
('POLICY_AESTHETICS',   'IDOL_THEATER_GOLD_gkls621'),
('POLICY_SPORTS_MEDIA',   'IDOL_THEATER_GOLD_gkls621');

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES
('REQSET_PASPALE_DISTRICT_IS_IDOL_THEATER_gkls621', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES
('REQSET_PASPALE_DISTRICT_IS_IDOL_THEATER_gkls621', 'PASPALE_DISTRICT_IS_IDOL_THEATER_gkls621');

INSERT INTO Requirements (RequirementId, RequirementType)
VALUES
('PASPALE_DISTRICT_IS_IDOL_THEATER_gkls621', 'REQUIREMENT_DISTRICT_TYPE_MATCHES');

INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES
('PASPALE_DISTRICT_IS_IDOL_THEATER_gkls621', 'DistrictType', 'DISTRICT_IDOL_THEATER_gkls621');