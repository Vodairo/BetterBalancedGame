-- Scythia no longer gets an extra light cavalry unit when building/buying one
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_EXTRASAKAHORSEARCHER' and NAME='Amount';
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_EXTRALIGHTCAVALRY' and NAME='Amount';
-- Scythian Horse Archer gets a little more offense and defense, less maintenance, and can upgrade to Crossbowman before Field Cannon now
-- 23/04/2021: Implemented by Firaxis
-- UPDATE UnitUpgrades SET UpgradeUnit='UNIT_CROSSBOWMAN' WHERE Unit='UNIT_SCYTHIAN_HORSE_ARCHER';
UPDATE Units SET Range=2, Cost=70 WHERE UnitType='UNIT_SCYTHIAN_HORSE_ARCHER';
-- Adjacent Pastures now give +1 production in addition to faith
INSERT OR IGNORE INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_KURGAN', 'BBG_KURGAN_PASTURE_PRODUCTION');
INSERT OR IGNORE INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentImprovement)
	VALUES ('BBG_KURGAN_PASTURE_PRODUCTION', 'Placeholder', 'YIELD_PRODUCTION', 1 , 1 , 'IMPROVEMENT_PASTURE');
INSERT OR IGNORE INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_KURGAN', 'YIELD_PRODUCTION', 0);
INSERT OR IGNORE INTO Improvement_ValidTerrains (ImprovementType, TerrainType) VALUES
	('IMPROVEMENT_KURGAN', 'TERRAIN_PLAINS_HILLS'),
	('IMPROVEMENT_KURGAN', 'TERRAIN_GRASS_HILLS'),
	('IMPROVEMENT_KURGAN', 'TERRAIN_DESERT_HILLS'),
	('IMPROVEMENT_KURGAN', 'TERRAIN_SNOW_HILLS'),
	('IMPROVEMENT_KURGAN', 'TERRAIN_TUNDRA_HILLS');
--15/06/23 Kurgan +2 faith base (from +1)
-- 03/07/24 to +1 again
UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE ImprovementType='IMPROVEMENT_KURGAN' AND YieldType='YIELD_FAITH';

-- Can now purchase cavalry units with faith
INSERT OR IGNORE INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY', 'SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD');
INSERT OR IGNORE INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY', 'SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD');
INSERT OR IGNORE INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY', 'SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD', 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD', 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD', 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD', 'Tag', 'CLASS_LIGHT_CAVALRY'); 
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD', 'Tag', 'CLASS_HEAVY_CAVALRY');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD', 'Tag', 'CLASS_RANGED_CAVALRY'); 

-- 17/08/2022: fix bug where bonus is not working on gdr
DELETE FROM TypeTags WHERE Type='ABILITY_TOMYRIS_BONUS_VS_WOUNDED_UNITS';
DELETE FROM TypeTags WHERE Type='ABILITY_TOMYRIS_HEAL_AFTER_DEFEATING_UNIT';

INSERT OR IGNORE INTO TypeTags (Type , Tag) VALUES
	('ABILITY_TOMYRIS_BONUS_VS_WOUNDED_UNITS','CLASS_ALL_COMBAT_UNITS'),
	('ABILITY_TOMYRIS_HEAL_AFTER_DEFEATING_UNIT', 'CLASS_ALL_COMBAT_UNITS');

-- 30/11/24 combat bonus reduced to +3 base scaling at +5 when reaching medieval era
-- +3
UPDATE ModifierArguments SET Value=3 WHERE ModifierId='TOMYRIS_BONUS_VS_WOUNDED_UNITS';
-- INSERT INTO Requirements (RequirementId, RequirementType, Inverse) VALUES
-- 	('BBG_UTILS_PLAYER_NO_HAS_TECH_STIRRUPS_REQUIREMENT', 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY', 1);
-- INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
-- 	('BBG_UTILS_PLAYER_NO_HAS_TECH_STIRRUPS_REQUIREMENT', 'TechnologyType', 'TECH_STIRRUPS');
-- INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
-- 	('BBG_UTILS_PLAYER_NO_HAS_TECH_STIRRUPS_REQSET', 'REQUIREMENTSET_TEST_ALL');
-- INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
--     ('BBG_UTILS_PLAYER_NO_HAS_TECH_STIRRUPS_REQSET', 'BBG_UTILS_PLAYER_NO_HAS_TECH_STIRRUPS_REQUIREMENT');

UPDATE Modifiers SET OwnerRequirementSetId='BBG_PLAYER_IS_NOT_IN_ERA_MEDIEVAL_REQSET' WHERE ModifierId='TOMYRIS_BONUS_VS_WOUNDED_UNITS';

-- 30/11/24 +5 at Stirrups
-- 16/12/24 +5 when reaching medieval era
INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
	('BBG_TOMYRIS_BONUS_VS_WOUNDED_UNITS_MEDIEVAL_GIVER', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', NULL, NULL),
	('BBG_TOMYRIS_BONUS_VS_WOUNDED_UNITS_MEDIEVAL_MODIFIER', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'BBG_PLAYER_IS_IN_ERA_MEDIEVAL_REQUIREMENTS', 'REQUIREMENTS_OPPONENT_IS_WOUNDED');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('BBG_TOMYRIS_BONUS_VS_WOUNDED_UNITS_MEDIEVAL_GIVER', 'AbilityType', 'BBG_TOMYRIS_BONUS_VS_WOUNDED_UNITS_MEDIEVAL_MODIFIER'),
	('BBG_TOMYRIS_BONUS_VS_WOUNDED_UNITS_MEDIEVAL_MODIFIER', 'Amount', 5);

INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
	('ABILITY_TOMYRIS_BONUS_VS_WOUNDED_UNITS', 'BBG_TOMYRIS_BONUS_VS_WOUNDED_UNITS_MEDIEVAL_MODIFIER');

INSERT INTO ModifierStrings (ModifierId, Context, Text) VALUES
	('BBG_TOMYRIS_BONUS_VS_WOUNDED_UNITS_MEDIEVAL_MODIFIER', 'Preview', 'LOC_BBG_TOMYRIS_BONUS_VS_WOUNDED_UNITS_MEDIEVAL_MODIFIER_DESC');