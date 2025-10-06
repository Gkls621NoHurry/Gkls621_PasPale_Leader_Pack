INSERT INTO Ruivo_New_Adjacency 
    (ID, DistrictType,                              
    ProvideType, YieldType, YieldChange,            
    AdjacencyType, CustomAdjacentObject,       
    DistrictModifiers, TraitType,                    
    Only, FreeCompose)                                    
    VALUES 
    ('AYA_GARAGE_PRODUCTION_ADJACENT_WORKER_gkls621', 'DISTRICT_GARAGE_gkls621', 
    'SelfBonus', 'YIELD_PRODUCTION', 2, 
    'FROM_ADJACENT_WORKER', 'NONE',
    1, 'TRAIT_DISTRICT_GARAGE_gkls621', 
    'Human&AI', 0),
    ('AYA_GARAGE_PRODUCTION_WORKER_gkls621', 'DISTRICT_GARAGE_gkls621', 
    'SelfMultiplier', 'YIELD_PRODUCTION', 50, 
    'FROM_SELF_WORKER', 'NONE',
    1, 'TRAIT_DISTRICT_GARAGE_gkls621', 
    'Human&AI', 0);

INSERT INTO Ruivo_New_Adjacency_Text (ID, Tooltip) VALUES
    ('AYA_GARAGE_PRODUCTION_ADJACENT_WORKER_gkls621','LOC_AYA_GARAGE_PRODUCTION_ADJACENT_WORKER_gkls621'),
    ('AYA_GARAGE_PRODUCTION_WORKER_gkls621', 'LOC_AYA_GARAGE_PRODUCTION_WORKER_gkls621');