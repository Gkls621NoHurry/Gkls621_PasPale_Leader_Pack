-- Maya's Trait, relied on New Adjacency
INSERT INTO Ruivo_New_Adjacency 
    (ID, DistrictType,                              
    ProvideType, YieldType, YieldChange,            
    AdjacencyType, CustomAdjacentObject,       
    DistrictModifiers, TraitType,                    
    Only, FreeCompose)
    SELECT
    'MAYA_' || d.DistrictType || '_' || y.YieldType || '_RING1_gkls621', d.DistrictType,
    'SelfMultiplier', y.YieldType, 1.0,
    'FROM_PLOT_PROPERTY', 'MAYA_' || d.DistrictType || '_' || y.YieldType || '_RING1_gkls621' ,
    0, 'TRAIT_LEADER_MAYA_gkls621',
    'Human&AI', 0
    FROM Districts d JOIN Yields y
    ON (d.InternalOnly = 0) AND ((d.TraitType IS NULL)
    OR (d.TraitType = 'TRAIT_DISTRICT_IDOL_THEATER_gkls621') OR (d.TraitType = 'TRAIT_DISTRICT_EQUIPMENT_ROOM_gkls621'));

INSERT INTO Ruivo_New_Adjacency 
    (ID, DistrictType,                              
    ProvideType, YieldType, YieldChange,            
    AdjacencyType, CustomAdjacentObject,       
    DistrictModifiers, TraitType,                    
    Only, FreeCompose)
    SELECT
    'MAYA_' || d.DistrictType || '_' || y.YieldType || '_RING2_gkls621', d.DistrictType,
    'SelfMultiplier', y.YieldType, 1.0,
    'FROM_PLOT_PROPERTY', 'MAYA_' || d.DistrictType || '_' || y.YieldType || '_RING2_gkls621' ,
    0, 'TRAIT_LEADER_MAYA_gkls621',
    'Human&AI', 0
    FROM Districts d JOIN Yields y
    ON (d.InternalOnly = 0) AND ((d.TraitType IS NULL)
    OR (d.TraitType = 'TRAIT_DISTRICT_IDOL_THEATER_gkls621') OR (d.TraitType = 'TRAIT_DISTRICT_EQUIPMENT_ROOM_gkls621'));

INSERT INTO Ruivo_New_Adjacency 
    (ID, DistrictType,                              
    ProvideType, YieldType, YieldChange,            
    AdjacencyType, CustomAdjacentObject, Rings,      
    DistrictModifiers, TraitType,                    
    Only, FreeCompose)
    SELECT
    'MAYA_EQUIPMENT_INDUSTRY_' || YieldType || '_gkls621', 'DISTRICT_INDUSTRIAL_ZONE',
    'SelfMultiplier', YieldType, 100,
    'FROM_RINGS_CAO_DISTRICT', 'DISTRICT_EQUIPMENT_ROOM_gkls621' , 1,
    0, 'TRAIT_DISTRICT_EQUIPMENT_ROOM_gkls621',
    'Human&AI', 0
    FROM Yields;

INSERT INTO Ruivo_New_Adjacency_Text (ID, Tooltip) SELECT
    'MAYA_' || d.DistrictType || '_' || y.YieldType || '_RING1_gkls621', 
    'LOC_MAYA_RING_ONE_gkls621'
    FROM Districts d JOIN Yields y
    ON (d.InternalOnly = 0) AND ((d.TraitType IS NULL)
    OR (d.TraitType = 'TRAIT_DISTRICT_IDOL_THEATER_gkls621') OR (d.TraitType = 'TRAIT_DISTRICT_EQUIPMENT_ROOM_gkls621'));

INSERT INTO Ruivo_New_Adjacency_Text (ID, Tooltip) SELECT
    'MAYA_' || d.DistrictType || '_' || y.YieldType || '_RING2_gkls621', 
    'LOC_MAYA_RING_TWO_gkls621'
    FROM Districts d JOIN Yields y
    ON (d.InternalOnly = 0) AND ((d.TraitType IS NULL)
    OR (d.TraitType = 'TRAIT_DISTRICT_IDOL_THEATER_gkls621') OR (d.TraitType = 'TRAIT_DISTRICT_EQUIPMENT_ROOM_gkls621'));

INSERT INTO Ruivo_New_Adjacency_Text (ID, Tooltip) SELECT
    'MAYA_EQUIPMENT_INDUSTRY_' || YieldType || '_gkls621',
    'LOC_EQUIPMENT_INDUSTRY_gkls621'
    FROM Yields;