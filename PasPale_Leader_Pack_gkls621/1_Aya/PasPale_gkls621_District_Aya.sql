-- Aya's Unique District
INSERT INTO Types
(Type,  Kind)
VALUES
('DISTRICT_GARAGE_gkls621',    'KIND_DISTRICT'),
('TRAIT_DISTRICT_GARAGE_gkls621',  'KIND_TRAIT');

INSERT INTO Traits
(TraitType, Name,   Description)
VALUES
('TRAIT_DISTRICT_GARAGE_gkls621',  'LOC_DISTRICT_GARAGE_gkls621_NAME',    'LOC_DISTRICT_GARAGE_gkls621_DESCRIPTION');

INSERT INTO DistrictReplaces
(CivUniqueDistrictType, ReplacesDistrictType)
VALUES
('DISTRICT_GARAGE_gkls621',    'DISTRICT_INDUSTRIAL_ZONE');

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
    'DISTRICT_GARAGE_gkls621',
    'LOC_DISTRICT_GARAGE_gkls621_NAME',
    NULL,
    'CIVIC_DRAMA_POETRY',
    Coast,
    'LOC_DISTRICT_GARAGE_gkls621_DESCRIPTION',
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
    'PLUNDER_HEAL',
    50,
    TradeEmbark,
    MilitaryDomain,
    CostProgressionModel,
    CostProgressionParam1 *0.5,
    'TRAIT_DISTRICT_GARAGE_gkls621',
    1,
    Housing,
    1,
    OnePerCity,
    AllowsHolyCity,
    Maintenance,
    AirSlots,
    3,
    TravelTime,
    CityStrengthModifier,
    AdjacentToLand,
    CanAttack,
    AdvisorType,
    CaptureRemovesDistrict,
    MaxPerPlayer
FROM Districts WHERE DistrictType = 'DISTRICT_INDUSTRIAL_ZONE';

INSERT INTO District_GreatPersonPoints
(DistrictType,  GreatPersonClassType,   PointsPerTurn)
SELECT DISTINCT 'DISTRICT_GARAGE_gkls621',  GreatPersonClassType,   PointsPerTurn
FROM District_GreatPersonPoints WHERE DistrictType = 'DISTRICT_INDUSTRIAL_ZONE';

INSERT INTO District_GreatPersonPoints
(DistrictType,  GreatPersonClassType,   PointsPerTurn)
VALUES
('DISTRICT_GARAGE_gkls621',   'GREAT_PERSON_CLASS_GENERAL',  1),
('DISTRICT_GARAGE_gkls621',   'GREAT_PERSON_CLASS_MUSICIAN',  1),
('DISTRICT_GARAGE_gkls621',   'GREAT_PERSON_CLASS_IDOL_gkls621',  2);

INSERT INTO District_TradeRouteYields
(DistrictType,  YieldType,  YieldChangeAsOrigin,    YieldChangeAsDomesticDestination,   YieldChangeAsInternationalDestination)
VALUES
('DISTRICT_GARAGE_gkls621',  'YIELD_PRODUCTION',
2,  1,   1),
('DISTRICT_GARAGE_gkls621',  'YIELD_CULTURE',
1,  1,   2);

INSERT INTO District_CitizenYieldChanges
(DistrictType,  YieldType,  YieldChange)
SELECT
'DISTRICT_GARAGE_gkls621', YieldType, YieldChange +1
FROM District_CitizenYieldChanges WHERE DistrictType = 'DISTRICT_INDUSTRIAL_ZONE';

INSERT INTO District_Adjacencies
(DistrictType,  YieldChangeId)
SELECT
'DISTRICT_GARAGE_gkls621',    YieldChangeId
FROM District_Adjacencies
WHERE DistrictType = 'DISTRICT_INDUSTRIAL_ZONE' AND YieldChangeId <> 'Strategic_Production';

INSERT INTO District_Adjacencies
(DistrictType,  YieldChangeId)
VALUES
('DISTRICT_GARAGE_gkls621', 'GARAGE_STRATEGIC_PRODUCTION_gkls621'),
('DISTRICT_GARAGE_gkls621', 'GARAGE_BONUS_PRODUCTION_gkls621'),
('DISTRICT_GARAGE_gkls621', 'GARAGE_FORT_PRODUCTION_gkls621'),
('DISTRICT_GARAGE_gkls621', 'GARAGE_ENTERTAINMENT_PRODUCTION_gkls621'),
('DISTRICT_GARAGE_gkls621', 'GARAGE_WATER_ENTERTAINMENT_PRODUCTION_gkls621'),
('DISTRICT_GARAGE_gkls621', 'GARAGE_IDOL_THEATER_PRODUCTION_gkls621'),
('DISTRICT_IDOL_THEATER_gkls621', 'IDOL_THEATER_GARAGE_CULTURE_gkls621');

INSERT INTO Adjacency_YieldChanges
(ID,    Description,    YieldType,  YieldChange,    TilesRequired,  AdjacentResourceClass)
VALUES
('GARAGE_STRATEGIC_PRODUCTION_gkls621',
'LOC_GARAGE_STRATEGIC_PRODUCTION_gkls621_DESCRIPTION', 'YIELD_PRODUCTION', 2,
1, 'RESOURCECLASS_STRATEGIC'),
('GARAGE_BONUS_PRODUCTION_gkls621',
'LOC_GARAGE_BONUS_PRODUCTION_gkls621_DESCRIPTION', 'YIELD_PRODUCTION', 1,
1, 'RESOURCECLASS_BONUS');

INSERT INTO Adjacency_YieldChanges
(ID,    Description,    YieldType,  YieldChange,    TilesRequired,  AdjacentImprovement)
VALUES
('GARAGE_FORT_PRODUCTION_gkls621',
'LOC_GARAGE_FORT_PRODUCTION_gkls621_DESCRIPTION', 'YIELD_PRODUCTION', 2,
1, 'IMPROVEMENT_FORT');

INSERT INTO Adjacency_YieldChanges
(ID,    Description,    YieldType,  YieldChange,    TilesRequired,  AdjacentDistrict)
VALUES
('GARAGE_ENTERTAINMENT_PRODUCTION_gkls621',
'LOC_GARAGE_ENTERTAINMENT_PRODUCTION_gkls621_DESCRIPTION', 'YIELD_PRODUCTION', 2,
1, 'DISTRICT_ENTERTAINMENT_COMPLEX'),
('GARAGE_WATER_ENTERTAINMENT_PRODUCTION_gkls621',
'LOC_GARAGE_WATER_ENTERTAINMENT_PRODUCTION_gkls621_DESCRIPTION', 'YIELD_PRODUCTION', 2,
1, 'DISTRICT_WATER_ENTERTAINMENT_COMPLEX'),
('GARAGE_IDOL_THEATER_PRODUCTION_gkls621',
'LOC_GARAGE_IDOL_THEATER_PRODUCTION_gkls621_DESCRIPTION', 'YIELD_PRODUCTION', 3,
1, 'DISTRICT_IDOL_THEATER_gkls621'),
('IDOL_THEATER_GARAGE_CULTURE_gkls621',
'LOC_IDOL_THEATER_GARAGE_CULTURE_gkls621_DESCRIPTION', 'YIELD_CULTURE', 3,
1, 'DISTRICT_GARAGE_gkls621');

INSERT INTO DistrictModifiers
(DistrictType,  ModifierId)
VALUES
--('DISTRICT_GARAGE_gkls621',   'GARAGE_COMBAT_STRENGTH_gkls621'),
('DISTRICT_GARAGE_gkls621', 'GARAGE_FREE_OIL_gkls621'),
('DISTRICT_GARAGE_gkls621', 'GARAGE_REVEAL_ALUMINUM_gkls621'),
('DISTRICT_GARAGE_gkls621', 'GARAGE_GRANT_FANS_gkls621'),
('DISTRICT_GARAGE_gkls621', 'GARAGE_PRODUCTION_TOURISM_gkls621');

INSERT INTO TraitModifiers
(TraitType, ModifierId)
VALUES
('TRAIT_DISTRICT_GARAGE_gkls621',   'GARAGE_COMBAT_STRENGTH_gkls621'),
('TRAIT_DISTRICT_GARAGE_gkls621',   'GARAGE_UNITS_HEALING_gkls621');

INSERT INTO Modifiers
(ModifierId,    ModifierType,   RunOnce,    Permanent)
VALUES
('GARAGE_FREE_OIL_gkls621', 'MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT_EXTRACTION',   0,  0),
('GARAGE_REVEAL_ALUMINUM_gkls621',  'MODIFIER_PLAYER_GRANT_FREE_RESOURCE_VISIBILITY',   1,  1),
('GARAGE_GRANT_FANS_gkls621',  'MODIFIER_SINGLE_CITY_GRANT_UNIT_IN_CITY',   1,  1);

INSERT INTO Modifiers
(ModifierId,    ModifierType,   SubjectRequirementSetId)
VALUES
('GARAGE_PRODUCTION_TOURISM_gkls621',   'MODIFIER_PLAYER_DISTRICT_ADJUST_TOURISM_ADJACENCY_YIELD_MOFIFIER', 'PLAYER_HAS_INDUSTRIALIZATION'),
('GARAGE_COMBAT_STRENGTH_gkls621',      'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'REQSET_PASPALE_UNIT_ADJACENT_TO_GARAGE_gkls621'),
('GARAGE_UNITS_HEALING_gkls621',        'MODIFIER_PLAYER_UNITS_ADJUST_HEAL_PER_TURN', 'REQSET_PASPALE_UNIT_ADJACENT_TO_GARAGE_gkls621');

INSERT INTO ModifierArguments
(ModifierId,    Name,   Value)
VALUES
('GARAGE_FREE_OIL_gkls621', 'ResourceType', 'RESOURCE_OIL'),
('GARAGE_FREE_OIL_gkls621', 'Amount', 2),
('GARAGE_REVEAL_ALUMINUM_gkls621', 'ResourceType', 'RESOURCE_ALUMINUM'),
('GARAGE_GRANT_FANS_gkls621', 'AllowUniqueOverride', 1),
('GARAGE_GRANT_FANS_gkls621', 'Amount', 1),
('GARAGE_GRANT_FANS_gkls621', 'UnitType', 'UNIT_FANS_gkls621'),
('GARAGE_PRODUCTION_TOURISM_gkls621',   'YieldType',    'YIELD_PRODUCTION'),
('GARAGE_PRODUCTION_TOURISM_gkls621',   'Amount',    100),
('GARAGE_COMBAT_STRENGTH_gkls621',  'Amount',   10),
('GARAGE_UNITS_HEALING_gkls621',  'Amount',   60),
('GARAGE_UNITS_HEALING_gkls621',  'Type',   'ALL');

INSERT INTO ModifierStrings
(ModifierId, Context, Text)
VALUES
('GARAGE_COMBAT_STRENGTH_gkls621', 'Preview', 'LOC_GARAGE_COMBAT_STRENGTH_gkls621');

INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
VALUES
('REQSET_PASPALE_UNIT_ADJACENT_TO_GARAGE_gkls621', 'REQUIREMENTSET_TEST_ALL');

INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
VALUES
('REQSET_PASPALE_UNIT_ADJACENT_TO_GARAGE_gkls621', 'PASPALE_UNIT_ADJACENT_TO_GARAGE_gkls621');

INSERT INTO Requirements (RequirementId, RequirementType)
VALUES
('PASPALE_UNIT_ADJACENT_TO_GARAGE_gkls621', 'REQUIREMENT_PLOT_ADJACENT_DISTRICT_TYPE_MATCHES');

INSERT INTO RequirementArguments (RequirementId, Name, Value)
VALUES
('PASPALE_UNIT_ADJACENT_TO_GARAGE_gkls621', 'DistrictType', 'DISTRICT_GARAGE_gkls621'),
('PASPALE_UNIT_ADJACENT_TO_GARAGE_gkls621', 'MaxRange', '6'),
('PASPALE_UNIT_ADJACENT_TO_GARAGE_gkls621', 'MinRange', '0'),
('PASPALE_UNIT_ADJACENT_TO_GARAGE_gkls621', 'MustBeFunctioning', '0');
