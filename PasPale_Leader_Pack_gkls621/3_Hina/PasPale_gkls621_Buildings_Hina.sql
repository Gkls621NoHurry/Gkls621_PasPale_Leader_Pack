-- Hina's Internal "Campus Buildings"
/*INSERT INTO Types
(Type,  Kind)
VALUES
('BUILDING_LIBRARY_HINA_gkls621',   'KIND_BUILDING'),
('BUILDING_UNIVERSITY_HINA_gkls621',   'KIND_BUILDING'),
('BUILDING_RESEARCH_LAB_HINA_gkls621',   'KIND_BUILDING');

CREATE TEMP TABLE GklsHinaBuildings(
    BuildingType TEXT NOT NULL
);

INSERT INTO GklsHinaBuildings
(BuildingType)
VALUES
('BUILDING_LIBRARY_gkls621'),
('BUILDING_UNIVERSITY_gkls621'),
('BUILDING_RESEARCH_LAB_gkls621');

INSERT INTO Buildings (
    BuildingType,
    Name,
    PrereqTech,
    PrereqCivic,
    Cost,
    MaxPlayerInstances,
    MaxWorldInstances,
    Capital,
    PrereqDistrict,
    AdjacentDistrict,
    Description,
    RequiresPlacement,
    RequiresRiver,
    OuterDefenseHitPoints,
    Housing,
    Entertainment,
    AdjacentResource,
    Coast,
    EnabledByReligion,
    AllowsHolyCity,
    --PurchaseYield,
    MustPurchase,
    Maintenance,
    IsWonder,
    --TraitType,
    OuterDefenseStrength,
    CitizenSlots,
    MustBeLake,
    MustNotBeLake,
    RegionalRange,
    AdjacentToMountain,
    ObsoleteEra,
    RequiresReligion,
    GrantFortification,
    DefenseModifier,
    InternalOnly,
    RequiresAdjacentRiver,
    Quote,
    QuoteAudio,
    MustBeAdjacentLand,
    AdvisorType,
    AdjacentCapital,
    AdjacentImprovement,
    CityAdjacentTerrain,
    UnlocksGovernmentPolicy,
    GovernmentTierRequirement
) SELECT
    BuildingType || '_HINA_gkls621',
    Name,
    PrereqTech,
    PrereqCivic,
    999999,
    MaxPlayerInstances,
    MaxWorldInstances,
    Capital,
    PrereqDistrict,
    AdjacentDistrict,
    Description,
    RequiresPlacement,
    RequiresRiver,
    OuterDefenseHitPoints,
    Housing,
    Entertainment,
    AdjacentResource,
    Coast,
    EnabledByReligion,
    AllowsHolyCity,
    --PurchaseYield,
    1,
    Maintenance,
    IsWonder,
    --TraitType,
    OuterDefenseStrength,
    CitizenSlots,
    MustBeLake,
    MustNotBeLake,
    RegionalRange,
    AdjacentToMountain,
    ObsoleteEra,
    RequiresReligion,
    GrantFortification,
    DefenseModifier,
    InternalOnly,
    RequiresAdjacentRiver,
    Quote,
    QuoteAudio,
    MustBeAdjacentLand,
    AdvisorType,
    AdjacentCapital,
    AdjacentImprovement,
    CityAdjacentTerrain,
    UnlocksGovernmentPolicy,
    GovernmentTierRequirement
FROM Buildings
WHERE PrereqDistrict = 'DISTRICT_CAMPUS' AND BuildingType NOT LIKE '%_HINA_gkls621';

INSERT INTO Building_YieldChanges
(BuildingType,  YieldType,  YieldChange)
SELECT b2.BuildingType || '_HINA_gkls621',  b2.YieldType,  b2.YieldChange
FROM Building_YieldChanges b2
JOIN Buildings b1 ON b1.BuildingType = b2.BuildingType AND b1.PrereqDistrict = 'DISTRICT_CAMPUS' AND b1.BuildingType NOT LIKE '%_HINA_gkls621';

INSERT INTO Building_YieldsPerEra
(BuildingType,  YieldType,  YieldChange)
SELECT b2.BuildingType || '_HINA_gkls621',  b2.YieldType,  b2.YieldChange
FROM Building_YieldsPerEra b2
JOIN Buildings b1 ON b1.BuildingType = b2.BuildingType AND b1.PrereqDistrict = 'DISTRICT_CAMPUS' AND b1.BuildingType NOT LIKE '%_HINA_gkls621';

INSERT INTO Building_GreatPersonPoints
(BuildingType,  GreatPersonClassType,   PointsPerTurn)
SELECT b2.BuildingType || '_HINA_gkls621',  b2.GreatPersonClassType,   b2.PointsPerTurn
FROM Building_GreatPersonPoints b2
JOIN Buildings b1 ON b1.BuildingType = b2.BuildingType AND b1.PrereqDistrict = 'DISTRICT_CAMPUS' AND b1.BuildingType NOT LIKE '%_HINA_gkls621';

INSERT INTO Building_YieldDistrictCopies
(BuildingType,  OldYieldType,  NewYieldType)
SELECT b2.BuildingType || '_HINA_gkls621',  b2.OldYieldType,  b2.NewYieldType
FROM Building_YieldDistrictCopies b2
JOIN Buildings b1 ON b1.BuildingType = b2.BuildingType AND b1.PrereqDistrict = 'DISTRICT_CAMPUS' AND b1.BuildingType NOT LIKE '%_HINA_gkls621';

INSERT INTO Building_GreatWorks
(BuildingType,
	GreatWorkSlotType,
    NumSlots,
    ThemingUniquePerson,
    ThemingSameObjectType,
    ThemingUniqueCivs,
    ThemingSameEras,
    ThemingYieldMultiplier,
    ThemingTourismMultiplier,
    NonUniquePersonYield,
    NonUniquePersonTourism,
    ThemingBonusDescription)
SELECT b2.BuildingType || '_HINA_gkls621',
	b2.GreatWorkSlotType,
    b2.NumSlots,
    b2.ThemingUniquePerson,
    b2.ThemingSameObjectType,
    b2.ThemingUniqueCivs,
    b2.ThemingSameEras,
    b2.ThemingYieldMultiplier,
    b2.ThemingTourismMultiplier,
    b2.NonUniquePersonYield,
    b2.NonUniquePersonTourism,
    b2.ThemingBonusDescription
FROM Building_GreatWorks b2
JOIN Buildings b1 ON b1.BuildingType = b2.BuildingType AND b1.PrereqDistrict = 'DISTRICT_CAMPUS' AND b1.BuildingType NOT LIKE '%_HINA_gkls621';

INSERT INTO Buildings_XP2
(BuildingType,  RequiredPower)
SELECT b2.BuildingType || '_HINA_gkls621', b2.RequiredPower
FROM Buildings_XP2 b2
JOIN Buildings b1 ON b1.BuildingType = b2.BuildingType AND b1.PrereqDistrict = 'DISTRICT_CAMPUS' AND b1.BuildingType NOT LIKE '%_HINA_gkls621';

INSERT INTO Building_YieldChangesBonusWithPower
(BuildingType,  YieldType,  YieldChange)
SELECT b2.BuildingType || '_HINA_gkls621', b2.YieldType, b2.YieldChange
FROM Building_YieldChangesBonusWithPower b2
JOIN Buildings b1 ON b1.BuildingType = b2.BuildingType AND b1.PrereqDistrict = 'DISTRICT_CAMPUS' AND b1.BuildingType NOT LIKE '%_HINA_gkls621';

INSERT INTO BuildingModifiers
(BuildingType,  ModifierId)
SELECT b2.BuildingType || '_HINA_gkls621', b2.ModifierId
FROM BuildingModifiers b2
JOIN Buildings b1 ON b1.BuildingType = b2.BuildingType AND b1.PrereqDistrict = 'DISTRICT_CAMPUS' AND b1.BuildingType NOT LIKE '%_HINA_gkls621';
*/
-- Hina's Campus-Building-Blocker
INSERT OR REPLACE INTO Types
(Type,  Kind)
VALUES
('BUILDING_BUILDING_BLOCK_HINA_gkls621', 'KIND_BUILDING');

INSERT OR REPLACE INTO Buildings
(BuildingType, Name, Cost, PrereqDistrict, MustPurchase, Description)
VALUES
('BUILDING_BUILDING_BLOCK_HINA_gkls621', 'LOC_BUILDING_BUILDING_BLOCK_HINA_gkls621_NAME', 1, 'DISTRICT_CAMPUS', 1, 'LOC_BUILDING_BUILDING_BLOCK_HINA_gkls621_DESCRIPTION');

INSERT INTO Buildings_XP2
(BuildingType, Pillage)
VALUES
('BUILDING_BUILDING_BLOCK_HINA_gkls621', 0);

INSERT INTO MutuallyExclusiveBuildings
(Building,  MutuallyExclusiveBuilding)
SELECT
'BUILDING_BUILDING_BLOCK_HINA_gkls621', BuildingType
FROM Buildings
WHERE PrereqDistrict = 'DISTRICT_CAMPUS' AND BuildingType <> 'BUILDING_BUILDING_BLOCK_HINA_gkls621';

INSERT INTO MutuallyExclusiveBuildings
(Building,  MutuallyExclusiveBuilding)
SELECT
BuildingType,   'BUILDING_BUILDING_BLOCK_HINA_gkls621'
FROM Buildings
WHERE PrereqDistrict = 'DISTRICT_CAMPUS' AND BuildingType <> 'BUILDING_BUILDING_BLOCK_HINA_gkls621';

INSERT INTO CivilopediaPageExcludes
(SectionId, PageId)
VALUES
('BUILDINGS',  'BUILDING_BUILDING_BLOCK_HINA_gkls621');