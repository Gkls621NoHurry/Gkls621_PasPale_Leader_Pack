-- Pastel*Palettes Project
INSERT INTO Types
(Type,	Kind)
VALUES
('PROJECT_AKUSHUKAI_gkls621',	    'KIND_PROJECT');

INSERT INTO Projects
(ProjectType,	Name,	ShortName,	Description,
PrereqDistrict, Cost,   CostProgressionModel,	CostProgressionParam1,	AdvisorType,	UnlocksFromEffect)
VALUES
('PROJECT_AKUSHUKAI_gkls621',	'LOC_PROJECT_AKUSHUKAI_gkls621_NAME',	'LOC_PROJECT_AKUSHUKAI_gkls621_SHORT_NAME',	'LOC_PROJECT_AKUSHUKAI_gkls621_DESCRIPTION',
'DISTRICT_IDOL_THEATER_gkls621',   30,  'COST_PROGRESSION_GAME_PROGRESS',	1300,	'ADVISOR_CULTURE',	1);

INSERT INTO Projects_XP1
(ProjectType,   IdentityPerCitizenChange)
VALUES
('PROJECT_AKUSHUKAI_gkls621',   1.0);

INSERT INTO Project_GreatPersonPoints
(ProjectType,	GreatPersonClassType,	Points,	PointProgressionModel,	PointProgressionParam1)
VALUES
('PROJECT_AKUSHUKAI_gkls621',   'GREAT_PERSON_CLASS_IDOL_gkls621',  5,  'COST_PROGRESSION_GAME_PROGRESS',   1000);

INSERT INTO Project_YieldConversions
(ProjectType,	YieldType,	PercentOfProductionRate)
VALUES
('PROJECT_AKUSHUKAI_gkls621',   'YIELD_CULTURE',    15),
('PROJECT_AKUSHUKAI_gkls621',   'YIELD_GOLD',       45);

INSERT INTO ProjectCompletionModifiers
(ProjectType,   ModifierId)
VALUES
('PROJECT_AKUSHUKAI_gkls621',   'PROJECT_COMPLETION_LOYALTY');