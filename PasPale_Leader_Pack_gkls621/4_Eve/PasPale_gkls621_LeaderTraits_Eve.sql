-- Eve Traits
INSERT INTO Types
(Type,  Kind)
VALUES
('TRAIT_LEADER_EVE_gkls621', 'KIND_TRAIT');

INSERT INTO Traits
(TraitType,                     Name,                                   Description)
VALUES
('TRAIT_LEADER_EVE_gkls621', 'LOC_TRAIT_LEADER_EVE_gkls621_NAME', 'LOC_TRAIT_LEADER_EVE_gkls621_DESCRIPTION');

INSERT INTO LeaderTraits
(LeaderType,                TraitType)
VALUES
('LEADER_EVE_gkls621',   'TRAIT_LEADER_EVE_gkls621'),
('LEADER_EVE_gkls621',   'TRAIT_DISTRICT_KENDO_CLUB_gkls621'),
('LEADER_EVE_gkls621',   'TRAIT_CIVILIZATION_UNIT_JAPANESE_SAMURAI'),
('LEADER_EVE_gkls621',   'TRAIT_UNIT_FINNISH_SNIPER_gkls621');

INSERT INTO TraitModifiers
(TraitType, ModifierId)
VALUES
('TRAIT_LEADER_EVE_gkls621',    'EVE_UNITS_AGAINST_STRONG_UNITS_gkls621'),
('TRAIT_LEADER_EVE_gkls621',    'EVE_CULTURE_KILLS_gkls621'),
('TRAIT_LEADER_EVE_gkls621',    'EVE_SCIENCE_KILLS_gkls621'),
('TRAIT_LEADER_EVE_gkls621',    'EVE_FAITH_KILLS_gkls621'),
--('TRAIT_LEADER_EVE_gkls621',    'EVE_FAITH_UNIT_PRODUCED_gkls621'),
('TRAIT_LEADER_EVE_gkls621',    'EVE_FAITH_PURCHASE_MELEE_gkls621'),
('TRAIT_LEADER_EVE_gkls621',    'EVE_FAITH_PURCHASE_RANGED_gkls621'),
('TRAIT_LEADER_EVE_gkls621',    'TRAIT_BLIZZARD_PREVENTION_SIGNIFICANT'),
('TRAIT_LEADER_EVE_gkls621',    'TRAIT_BLIZZARD_PREVENTION_CRIPPLING'),
('TRAIT_LEADER_EVE_gkls621',    'TRAIT_BLIZZARD_DOUBLE_DAMAGE_SIGNIFICANT'),
('TRAIT_LEADER_EVE_gkls621',    'TRAIT_BLIZZARD_DOUBLE_DAMAGE_CRIPPLING');

INSERT INTO TraitModifiers
(TraitType, ModifierId)
SELECT 'TRAIT_LEADER_EVE_gkls621',
'EVE_' || RandomEventType || '_PREVENTION_gkls621'
FROM RandomEvents WHERE IconSmall = 'ClimateEventStat_Volcanoes';

INSERT INTO TraitModifiers
(TraitType, ModifierId)
SELECT 'TRAIT_LEADER_EVE_gkls621',
'EVE_' || RandomEventType || '_OPPONENT_DAMAGE_gkls621'
FROM RandomEvents WHERE IconSmall = 'ClimateEventStat_Volcanoes';

INSERT INTO Modifiers
(ModifierId,    ModifierType)
VALUES
('EVE_UNITS_AGAINST_STRONG_UNITS_gkls621',  'MODIFIER_PLAYER_UNITS_GRANT_ABILITY'),
('EVE_CULTURE_KILLS_gkls621',   'MODIFIER_PLAYER_UNITS_ADJUST_POST_COMBAT_YIELD'),
('EVE_SCIENCE_KILLS_gkls621',   'MODIFIER_PLAYER_UNITS_ADJUST_POST_COMBAT_YIELD'),
('EVE_FAITH_KILLS_gkls621',   'MODIFIER_PLAYER_UNITS_ADJUST_POST_COMBAT_YIELD'),
--('EVE_FAITH_UNIT_PRODUCED_gkls621', 'MODIFIER_PLAYER_CITIES_GRANT_YIELD_PER_UNIT_COST'),
('EVE_FAITH_PURCHASE_MELEE_gkls621',    'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE'),
('EVE_FAITH_PURCHASE_RANGED_gkls621',    'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');

INSERT INTO Modifiers
(ModifierId,    ModifierType)
SELECT 
'EVE_' || RandomEventType || '_PREVENTION_gkls621',
'MODIFIER_PLAYER_ADJUST_RANDOM_EVENT_NO_UNIT_DAMAGE'
FROM RandomEvents WHERE IconSmall = 'ClimateEventStat_Volcanoes';

INSERT INTO Modifiers
(ModifierId,    ModifierType)
SELECT 
'EVE_' || RandomEventType || '_OPPONENT_DAMAGE_gkls621',
'MODIFIER_PLAYER_ADJUST_RANDOM_EVENT_MODIFIED_DAMAGE_OPPOSING_PLAYER'
FROM RandomEvents WHERE IconSmall = 'ClimateEventStat_Volcanoes';

INSERT INTO ModifierArguments
(ModifierId,    Name,   Value)
VALUES
('EVE_UNITS_AGAINST_STRONG_UNITS_gkls621',  'AbilityType',  'ABILITY_EVE_COMBAT_AGAINST_STRONG_UNITS_gkls621'),
('EVE_CULTURE_KILLS_gkls621',  'YieldType',  'YIELD_CULTURE'),
('EVE_CULTURE_KILLS_gkls621',  'PercentDefeatedStrength',  50),
('EVE_SCIENCE_KILLS_gkls621',  'YieldType',  'YIELD_SCIENCE'),
('EVE_SCIENCE_KILLS_gkls621',  'PercentDefeatedStrength',  50),
('EVE_FAITH_KILLS_gkls621',  'YieldType',  'YIELD_FAITH'),
('EVE_FAITH_KILLS_gkls621',  'PercentDefeatedStrength',  100),
--('EVE_FAITH_UNIT_PRODUCED_gkls621',  'YieldType',  'YIELD_FAITH'),
--('EVE_FAITH_UNIT_PRODUCED_gkls621',  'UnitProductionPercent',  20),
('EVE_FAITH_PURCHASE_MELEE_gkls621',    'Tag',  'CLASS_MELEE'),
('EVE_FAITH_PURCHASE_RANGED_gkls621',    'Tag',  'CLASS_RANGED');

INSERT INTO ModifierArguments
(ModifierId,    Name,   Value)
SELECT 
'EVE_' || RandomEventType || '_PREVENTION_gkls621',
'NoDamage', 1
FROM RandomEvents WHERE IconSmall = 'ClimateEventStat_Volcanoes';

INSERT INTO ModifierArguments
(ModifierId,    Name,   Value)
SELECT 
'EVE_' || RandomEventType || '_PREVENTION_gkls621',
'RandomEventType', RandomEventType
FROM RandomEvents WHERE IconSmall = 'ClimateEventStat_Volcanoes';

INSERT INTO ModifierArguments
(ModifierId,    Name,   Value)
SELECT 
'EVE_' || RandomEventType || '_OPPONENT_DAMAGE_gkls621',
'Amount', 100
FROM RandomEvents WHERE IconSmall = 'ClimateEventStat_Volcanoes';

INSERT INTO ModifierArguments
(ModifierId,    Name,   Value)
SELECT 
'EVE_' || RandomEventType || '_OPPONENT_DAMAGE_gkls621',
'RandomEventType', RandomEventType
FROM RandomEvents WHERE IconSmall = 'ClimateEventStat_Volcanoes';