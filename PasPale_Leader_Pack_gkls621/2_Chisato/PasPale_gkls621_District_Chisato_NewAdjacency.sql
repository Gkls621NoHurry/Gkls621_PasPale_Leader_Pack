INSERT INTO Ruivo_New_Adjacency 
    (ID, DistrictType,                              
    ProvideType, YieldType, YieldChange,            
    AdjacencyType, CustomAdjacentObject,       
    DistrictModifiers, TraitType,                    
    Only, FreeCompose)                                    
    VALUES 
    ('CHISATO_CHILDSTAR_GUILD_CULTURE_FROM_DIPLO_CARDS_gkls621', 'DISTRICT_CHILDSTAR_GUILD_gkls621', 
    'SelfBonus', 'YIELD_CULTURE', 1, 
    'FROM_SLOT_DIPLOMATIC', 'NONE',
    1, 'TRAIT_DISTRICT_CHILDSTAR_GUILD_gkls621', 
    'Human&AI', 0),
    ('CHISATO_CHILDSTAR_GUILD_GOLD_FROM_DIPLO_CARDS_gkls621', 'DISTRICT_CHILDSTAR_GUILD_gkls621', 
    'SelfBonus', 'YIELD_GOLD', 2, 
    'FROM_SLOT_DIPLOMATIC', 'NONE',
    1, 'TRAIT_DISTRICT_CHILDSTAR_GUILD_gkls621', 
    'Human&AI', 0);

INSERT INTO Ruivo_New_Adjacency_Text (ID, Tooltip) VALUES
    ('CHISATO_CHILDSTAR_GUILD_CULTURE_FROM_DIPLO_CARDS_gkls621','LOC_CHISATO_CHILDSTAR_GUILD_CULTURE_FROM_DIPLO_CARDS_gkls621'),
    ('CHISATO_CHILDSTAR_GUILD_GOLD_FROM_DIPLO_CARDS_gkls621', 'LOC_CHISATO_CHILDSTAR_GUILD_GOLD_FROM_DIPLO_CARDS_gkls621');