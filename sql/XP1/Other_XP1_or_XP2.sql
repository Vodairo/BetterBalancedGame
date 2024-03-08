--==============================================================
--******			  D E D I C A T I O N S				  ******
--==============================================================
-- To Arms +10 vs cities
INSERT OR IGNORE INTO CommemorationModifiers (CommemorationType, ModifierId)
    VALUES ('COMMEMORATION_MILITARY', 'COMMEMORATION_MILITARY_GA_ATTACK_CITIES');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , OwnerRequirementSetId)
    VALUES ('COMMEMORATION_MILITARY_GA_ATTACK_CITIES' , 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY' , 'PLAYER_HAS_GOLDEN_AGE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('COMMEMORATION_MILITARY_GA_ATTACK_CITIES' , 'AbilityType' , 'ABILITY_MILITARY_GA_BUFF');
INSERT OR IGNORE INTO Types (Type, Kind) VALUES ('ABILITY_MILITARY_GA_BUFF', 'KIND_ABILITY');
INSERT OR IGNORE INTO TypeTags (Type, Tag) VALUES
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_NAVAL_MELEE'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_NAVAL_RANGED'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_NAVAL_RAIDER'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_NAVAL_CARRIER'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_RECON'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_MELEE'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_RANGED'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_SIEGE'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_HEAVY_CAVALRY'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_LIGHT_CAVALRY'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_RANGED_CAVALRY'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_ANTI_CAVALRY'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_HEAVY_CHARIOT'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_LIGHT_CHARIOT'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_WARRIOR_MONK'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_WAR_CART'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_AIRCRAFT'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_AIR_BOMBER'),
	('ABILITY_MILITARY_GA_BUFF', 'CLASS_AIR_FIGHTER');
INSERT OR IGNORE INTO UnitAbilities (UnitAbilityType, Name, Description, Inactive) VALUES
	('ABILITY_MILITARY_GA_BUFF', 'LOC_ABILITY_MILITARY_GA_BUFF_NAME', 'LOC_ABILITY_MILITARY_GA_BUFF_DESCRIPTION', 1);
INSERT OR IGNORE INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
	('ABILITY_MILITARY_GA_BUFF', 'MOD_MILITARY_GA_BUFF');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('MOD_MILITARY_GA_BUFF', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'UNIT_ATTACKING_DISTRICT_REQUIREMENTS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('MOD_MILITARY_GA_BUFF', 'Amount', '10');
INSERT OR IGNORE INTO ModifierStrings (ModifierId, Context, Text) VALUES
('MOD_MILITARY_GA_BUFF', 'Preview', 'LOC_MILITARY_GA_BUFF_DESCRIPTION');
-- Sic Hunt Dracones works on all new cities, not just diff continent
UPDATE Modifiers SET ModifierType='MODIFIER_PLAYER_CITIES_ADD_POPULATION', NewOnly=1, Permanent=1 WHERE ModifierId='COMMEMORATION_EXPLORATION_GA_NEW_CITY_POPULATION';
-- Monumentality discount reduced from 30% to 10%
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='COMMEMORATION_INFRASTRUCTURE_BUILDER_DISCOUNT_MODIFIER' AND Name='Amount';
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='COMMEMORATION_INFRASTRUCTURE_SETTLER_DISCOUNT_MODIFIER' AND Name='Amount';
-- Pen and Brush gives +2 Culture and +1 Gold per District
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , OwnerRequirementSetId)
    VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD' , 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_PER_DISTRICT' , 'PLAYER_HAS_GOLDEN_AGE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD' , 'YieldType' , 'YIELD_GOLD');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD' , 'Amount' , '1');
INSERT OR IGNORE INTO CommemorationModifiers (CommemorationType, ModifierId)
	VALUES ('COMMEMORATION_CULTURAL', 'COMMEMORATION_CULTURAL_DISTRICTGOLD');
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='COMMEMORATION_CULTURAL_DISTRICTCULTURE' and Name='Amount';

-- 21/06/23 Exodus change to military golden
-- +2 horse / iron / turn, 15% prod for military units, -1 gold for military units, +1 prod +1 culture for campement & building
DELETE FROM CommemorationModifiers WHERE CommemorationType='COMMEMORATION_RELIGIOUS';

-- INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
-- 	('BBG_PLAYER_CAN_SEE_HORSES_AND_HAS_GOLDEN_AGE', 'REQUIREMENTSET_TEST_ALL'),
-- 	('BBG_PLAYER_CAN_SEE_IRON_AND_HAS_GOLDEN_AGE', 'REQUIREMENTSET_TEST_ALL');
-- INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
-- 	('BBG_PLAYER_CAN_SEE_HORSES_AND_HAS_GOLDEN_AGE', 'REQUIRES_PLAYER_CAN_SEE_HORSES'),
-- 	('BBG_PLAYER_CAN_SEE_HORSES_AND_HAS_GOLDEN_AGE', 'REQUIRES_PLAYER_HAS_GOLDEN_AGE'),
-- 	('BBG_PLAYER_CAN_SEE_IRON_AND_HAS_GOLDEN_AGE', 'REQUIRES_PLAYER_CAN_SEE_IRON'),
-- 	('BBG_PLAYER_CAN_SEE_IRON_AND_HAS_GOLDEN_AGE', 'REQUIRES_PLAYER_HAS_GOLDEN_AGE');
INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
	('BBG_MILITARY_COMMEMORATION_HORSES', 'MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT_EXTRACTION', 'PLAYER_HAS_GOLDEN_AGE', 'BBG_PLAYER_CAN_SEE_HORSES'),
	('BBG_MILITARY_COMMEMORATION_IRON', 'MODIFIER_PLAYER_ADJUST_FREE_RESOURCE_IMPORT_EXTRACTION', 'PLAYER_HAS_GOLDEN_AGE', 'BBG_PLAYER_CAN_SEE_IRON'),
	('BBG_MILITARY_COMMEMORATION_MILITARY_UNITS_PRODUCTION_BONUS', 'MODIFIER_PLAYER_CITIES_ADJUST_MILITARY_UNITS_PRODUCTION', 'PLAYER_HAS_GOLDEN_AGE', NULL),
	('BBG_MILITARY_COMMEMORATION_REDUCED_MAINTENANCE' , 'MODIFIER_PLAYER_ADJUST_UNIT_MAINTENANCE_DISCOUNT', 'PLAYER_HAS_GOLDEN_AGE', NULL),
	('BBG_MILITARY_COMMEMORATION_PROD_ENCAMPMENT', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'PLAYER_HAS_GOLDEN_AGE', 'CITY_HAS_ENCAMPMENT'),
	('BBG_MILITARY_COMMEMORATION_CULTURE_ENCAMPMENT', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'PLAYER_HAS_GOLDEN_AGE', 'CITY_HAS_ENCAMPMENT');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('BBG_MILITARY_COMMEMORATION_HORSES', 'ResourceType', 'RESOURCE_HORSES'),
	('BBG_MILITARY_COMMEMORATION_HORSES', 'Amount', 2),
	('BBG_MILITARY_COMMEMORATION_IRON', 'ResourceType', 'RESOURCE_IRON'),
	('BBG_MILITARY_COMMEMORATION_IRON', 'Amount', 2),
	('BBG_MILITARY_COMMEMORATION_MILITARY_UNITS_PRODUCTION_BONUS', 'Amount', '15'),
	('BBG_MILITARY_COMMEMORATION_MILITARY_UNITS_PRODUCTION_BONUS', 'StartEra', 'ERA_ANCIENT'),
	('BBG_MILITARY_COMMEMORATION_MILITARY_UNITS_PRODUCTION_BONUS', 'EndEra', 'ERA_INFORMATION'),
	('BBG_MILITARY_COMMEMORATION_REDUCED_MAINTENANCE', 'Amount', '1'),
	('BBG_MILITARY_COMMEMORATION_PROD_ENCAMPMENT', 'YieldType', 'YIELD_PRODUCTION'),
	('BBG_MILITARY_COMMEMORATION_PROD_ENCAMPMENT', 'Amount', '1'),
	('BBG_MILITARY_COMMEMORATION_CULTURE_ENCAMPMENT', 'YieldType', 'YIELD_CULTURE'),
	('BBG_MILITARY_COMMEMORATION_CULTURE_ENCAMPMENT', 'Amount', '1');
INSERT INTO CommemorationModifiers (CommemorationType, ModifierId) VALUES
	('COMMEMORATION_RELIGIOUS', 'BBG_MILITARY_COMMEMORATION_HORSES'),
	('COMMEMORATION_RELIGIOUS', 'BBG_MILITARY_COMMEMORATION_IRON'),
	('COMMEMORATION_RELIGIOUS', 'BBG_MILITARY_COMMEMORATION_MILITARY_UNITS_PRODUCTION_BONUS'),
	('COMMEMORATION_RELIGIOUS', 'BBG_MILITARY_COMMEMORATION_REDUCED_MAINTENANCE'),
	('COMMEMORATION_RELIGIOUS', 'BBG_MILITARY_COMMEMORATION_PROD_ENCAMPMENT'),
	('COMMEMORATION_RELIGIOUS', 'BBG_MILITARY_COMMEMORATION_CULTURE_ENCAMPMENT');

INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId) VALUES
	('BBG_MILITARY_COMMEMORATION_PROD_BARRACK', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'PLAYER_HAS_GOLDEN_AGE'),
	('BBG_MILITARY_COMMEMORATION_PROD_STABLE', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'PLAYER_HAS_GOLDEN_AGE'),
	('BBG_MILITARY_COMMEMORATION_PROD_ARMORY', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'PLAYER_HAS_GOLDEN_AGE'),
	('BBG_MILITARY_COMMEMORATION_PROD_MILITARY_ACADEMY', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'PLAYER_HAS_GOLDEN_AGE');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('BBG_MILITARY_COMMEMORATION_PROD_BARRACK', 'BuildingType', 'BUILDING_BARRACKS'),
    ('BBG_MILITARY_COMMEMORATION_PROD_STABLE', 'BuildingType', 'BUILDING_STABLE'),
    ('BBG_MILITARY_COMMEMORATION_PROD_ARMORY', 'BuildingType', 'BUILDING_ARMORY'),
    ('BBG_MILITARY_COMMEMORATION_PROD_MILITARY_ACADEMY', 'BuildingType', 'BUILDING_MILITARY_ACADEMY'),
	('BBG_MILITARY_COMMEMORATION_PROD_BARRACK', 'YieldType', 'YIELD_PRODUCTION'),
	('BBG_MILITARY_COMMEMORATION_PROD_STABLE', 'YieldType', 'YIELD_PRODUCTION'),
	('BBG_MILITARY_COMMEMORATION_PROD_ARMORY', 'YieldType', 'YIELD_PRODUCTION'),
	('BBG_MILITARY_COMMEMORATION_PROD_MILITARY_ACADEMY', 'YieldType', 'YIELD_PRODUCTION'),
	('BBG_MILITARY_COMMEMORATION_PROD_BARRACK', 'Amount', 1),
	('BBG_MILITARY_COMMEMORATION_PROD_STABLE', 'Amount', 1),
	('BBG_MILITARY_COMMEMORATION_PROD_ARMORY', 'Amount', 1),
	('BBG_MILITARY_COMMEMORATION_PROD_MILITARY_ACADEMY', 'Amount', 1);
INSERT INTO CommemorationModifiers (CommemorationType, ModifierId) VALUES
	('COMMEMORATION_RELIGIOUS', 'BBG_MILITARY_COMMEMORATION_PROD_BARRACK'),
	('COMMEMORATION_RELIGIOUS', 'BBG_MILITARY_COMMEMORATION_PROD_STABLE'),
	('COMMEMORATION_RELIGIOUS', 'BBG_MILITARY_COMMEMORATION_PROD_ARMORY'),
	('COMMEMORATION_RELIGIOUS', 'BBG_MILITARY_COMMEMORATION_PROD_MILITARY_ACADEMY');
INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId) VALUES
	('BBG_MILITARY_COMMEMORATION_CULTURE_BARRACK', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'PLAYER_HAS_GOLDEN_AGE'),
	('BBG_MILITARY_COMMEMORATION_CULTURE_STABLE', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'PLAYER_HAS_GOLDEN_AGE'),
	('BBG_MILITARY_COMMEMORATION_CULTURE_ARMORY', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'PLAYER_HAS_GOLDEN_AGE'),
	('BBG_MILITARY_COMMEMORATION_CULTURE_MILITARY_ACADEMY', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 'PLAYER_HAS_GOLDEN_AGE');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('BBG_MILITARY_COMMEMORATION_CULTURE_BARRACK', 'BuildingType', 'BUILDING_BARRACKS'),
    ('BBG_MILITARY_COMMEMORATION_CULTURE_STABLE', 'BuildingType', 'BUILDING_STABLE'),
    ('BBG_MILITARY_COMMEMORATION_CULTURE_ARMORY', 'BuildingType', 'BUILDING_ARMORY'),
    ('BBG_MILITARY_COMMEMORATION_CULTURE_MILITARY_ACADEMY', 'BuildingType', 'BUILDING_MILITARY_ACADEMY'),
	('BBG_MILITARY_COMMEMORATION_CULTURE_BARRACK', 'YieldType', 'YIELD_CULTURE'),
	('BBG_MILITARY_COMMEMORATION_CULTURE_STABLE', 'YieldType', 'YIELD_CULTURE'),
	('BBG_MILITARY_COMMEMORATION_CULTURE_ARMORY', 'YieldType', 'YIELD_CULTURE'),
	('BBG_MILITARY_COMMEMORATION_CULTURE_MILITARY_ACADEMY', 'YieldType', 'YIELD_CULTURE'),
	('BBG_MILITARY_COMMEMORATION_CULTURE_BARRACK', 'Amount', 1),
	('BBG_MILITARY_COMMEMORATION_CULTURE_STABLE', 'Amount', 1),
	('BBG_MILITARY_COMMEMORATION_CULTURE_ARMORY', 'Amount', 1),
	('BBG_MILITARY_COMMEMORATION_CULTURE_MILITARY_ACADEMY', 'Amount', 1);
INSERT INTO CommemorationModifiers (CommemorationType, ModifierId) VALUES
	('COMMEMORATION_RELIGIOUS', 'BBG_MILITARY_COMMEMORATION_CULTURE_BARRACK'),
	('COMMEMORATION_RELIGIOUS', 'BBG_MILITARY_COMMEMORATION_CULTURE_STABLE'),
	('COMMEMORATION_RELIGIOUS', 'BBG_MILITARY_COMMEMORATION_CULTURE_ARMORY'),
	('COMMEMORATION_RELIGIOUS', 'BBG_MILITARY_COMMEMORATION_CULTURE_MILITARY_ACADEMY');

--05/01/2024 temporary era score point for exodus
INSERT INTO CommemorationModifiers (CommemorationType, ModifierId) VALUES
	('COMMEMORATION_RELIGIOUS', 'COMMEMORATION_INFRASTRUCTURE_QUEST');


-- INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType , OwnerRequirementSetId)
--     VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD' , 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_PER_DISTRICT', 'PLAYER_HAS_GOLDEN_AGE');
-- INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
--     VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD' , 'YieldType' , 'YIELD_GOLD');
-- INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
--     VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD' , 'Amount' , '1');
-- INSERT OR IGNORE INTO CommemorationModifiers (CommemorationType, ModifierId)

--==============================================================
--******				S  C  O  R  E				  	  ******
--==============================================================
-- no double counting for era points
UPDATE ScoringLineItems SET Multiplier=0 WHERE LineItemType='LINE_ITEM_ERA_SCORE';

--==============================================================
--******				    O T H E R					  ******
--==============================================================
-- Offshore Oil can be improved at Plastics
UPDATE Improvements SET PrereqTech='TECH_PLASTICS' WHERE ImprovementType='IMPROVEMENT_OFFSHORE_OIL_RIG';

--==============================================================
--******				    ALLIANCES					  ******
--==============================================================
--14/04/23 economic alliance from 4g to 6g/1p
--19/12/23 remove production
-- INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
-- 	('ALLIANCE_ADD_PROD_TO_ORIGIN_TRADE_ROUTE', 'MODIFIER_ALLIANCE_TRADE_ROUTE_ADJUST_YIELD', 'ROUTE_BETWEEN_ALLIES_REQUIREMENTS'),
-- 	('ALLIANCE_ADD_PROD_TO_DESTINATION_TRADE_ROUTE', 'MODIFIER_ALLIANCE_TRADE_ROUTE_ADJUST_YIELD', 'ROUTE_BETWEEN_ALLIES_REQUIREMENTS');
-- INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
-- 	('ALLIANCE_ADD_PROD_TO_ORIGIN_TRADE_ROUTE', 'AffectDestination', 1),
-- 	('ALLIANCE_ADD_PROD_TO_DESTINATION_TRADE_ROUTE', 'AffectOrigin', 1),
-- 	('ALLIANCE_ADD_PROD_TO_ORIGIN_TRADE_ROUTE', 'Amount', 1),
-- 	('ALLIANCE_ADD_PROD_TO_DESTINATION_TRADE_ROUTE', 'Amount', 1),
-- 	('ALLIANCE_ADD_PROD_TO_ORIGIN_TRADE_ROUTE', 'YieldType', 'YIELD_PRODUCTION'),
-- 	('ALLIANCE_ADD_PROD_TO_DESTINATION_TRADE_ROUTE', 'YieldType', 'YIELD_PRODUCTION');
-- INSERT INTO AllianceEffects (LevelRequirement, AllianceType, ModifierID) VALUES
-- 	('1', 'ALLIANCE_ECONOMIC', 'ALLIANCE_ADD_PROD_TO_ORIGIN_TRADE_ROUTE'),
-- 	('1', 'ALLIANCE_ECONOMIC', 'ALLIANCE_ADD_PROD_TO_DESTINATION_TRADE_ROUTE');

UPDATE ModifierArguments SET Value=6 WHERE ModifierId='ALLIANCE_ADD_GOLD_TO_ORIGIN_TRADE_ROUTE' AND Name='Amount';
UPDATE ModifierArguments SET Value=6 WHERE ModifierId='ALLIANCE_ADD_GOLD_TO_DESTINATION_TRADE_ROUTE' AND Name='Amount';

--14/04/23 religious alliance from 2faith to 4faith
UPDATE ModifierArguments SET Value=4 WHERE ModifierId='ALLIANCE_ADD_FAITH_TO_ORIGIN_TRADE_ROUTE' AND Name='Amount';
UPDATE ModifierArguments SET Value=4 WHERE ModifierId='ALLIANCE_ADD_FAITH_TO_DESTINATION_TRADE_ROUTE' AND Name='Amount';

--05/03/2024 Religious alliance get +1food yield
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
 	('ALLIANCE_ADD_FOOD_TO_ORIGIN_TRADE_ROUTE', 'MODIFIER_ALLIANCE_TRADE_ROUTE_ADJUST_YIELD', 'ROUTE_BETWEEN_ALLIES_REQUIREMENTS'),
 	('ALLIANCE_ADD_FOOD_TO_DESTINATION_TRADE_ROUTE', 'MODIFIER_ALLIANCE_TRADE_ROUTE_ADJUST_YIELD', 'ROUTE_BETWEEN_ALLIES_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
 	('ALLIANCE_ADD_FOOD_TO_ORIGIN_TRADE_ROUTE', 'AffectDestination', 1),
 	('ALLIANCE_ADD_FOOD_TO_DESTINATION_TRADE_ROUTE', 'AffectOrigin', 1),
	('ALLIANCE_ADD_FOOD_TO_ORIGIN_TRADE_ROUTE', 'Amount', 1),
 	('ALLIANCE_ADD_FOOD_TO_DESTINATION_TRADE_ROUTE', 'Amount', 1),
 	('ALLIANCE_ADD_FOOD_TO_ORIGIN_TRADE_ROUTE', 'YieldType', 'YIELD_FOOD'),
	('ALLIANCE_ADD_FOOD_TO_DESTINATION_TRADE_ROUTE', 'YieldType', 'YIELD_FOOD');
 INSERT INTO AllianceEffects (LevelRequirement, AllianceType, ModifierID) VALUES
 	('1', 'ALLIANCE_RELIGIOUS', 'ALLIANCE_ADD_FOOD_TO_ORIGIN_TRADE_ROUTE'),
 	('1', 'ALLIANCE_RELIGIOUS', 'ALLIANCE_ADD_FOOD_TO_DESTINATION_TRADE_ROUTE');

--=======================================================================
--******                       DISTRICTS                          ******
--=======================================================================

UPDATE Districts SET CostProgressionParam1=20 WHERE DistrictType='DISTRICT_GOVERNMENT';
UPDATE Districts SET CostProgressionParam1=35 WHERE DistrictType='DISTRICT_WATER_ENTERTAINMENT_COMPLEX';

UPDATE Districts SET CostProgressionParam1=35 WHERE DistrictType IN ('DISTRICT_IKANDA', 'DISTRICT_SEOWON', 'DISTRICT_WATER_STREET_CARNIVAL');
UPDATE Districts SET Cost=30 WHERE DistrictType IN ('DISTRICT_IKANDA', 'DISTRICT_SEOWON', 'DISTRICT_WATER_STREET_CARNIVAL');

