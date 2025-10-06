-- Eve's Trait, relied on New Adjacency
INSERT INTO Ruivo_New_Adjacency 
    (ID, DistrictType,                              
    ProvideType, YieldType, YieldChange,            
    AdjacencyType, CustomAdjacentObject,       
    DistrictModifiers, TraitType,                    
    Only, FreeCompose)                                    
    VALUES 
    ('EVE_KENDO_CLUB_FAITH_FROM_DEATHS_gkls621', 'DISTRICT_KENDO_CLUB_gkls621', 
    'SelfBonus', 'YIELD_FAITH', 0.5, 
    'FROM_PLAYER_PROPERTY', 'EVE_DEATH_FAITH',
    1, 'TRAIT_DISTRICT_KENDO_CLUB_gkls621', 
    'Human&AI', 0);

INSERT INTO Ruivo_New_Adjacency_Text (ID, Tooltip) VALUES
    ('EVE_KENDO_CLUB_FAITH_FROM_DEATHS_gkls621','LOC_EVE_KENDO_CLUB_FAITH_FROM_DEATHS_gkls621');