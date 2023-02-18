--==================
-- Ethiopia
--==================
-- rock hewn church nerf
/*
UPDATE Adjacency_YieldChanges SET TilesRequired=2 WHERE ID='Hills_Faith1';
UPDATE Adjacency_YieldChanges SET TilesRequired=2 WHERE ID='Hills_Faith2';
UPDATE Adjacency_YieldChanges SET TilesRequired=2 WHERE ID='Hills_Faith3';
UPDATE Adjacency_YieldChanges SET TilesRequired=2 WHERE ID='Hills_Faith4';
UPDATE Adjacency_YieldChanges SET TilesRequired=2 WHERE ID='Hills_Faith5';
INSERT OR IGNORE INTO Adjacency_YieldChanges (ID, Description, YieldType, TilesRequired, AdjacentTerrain) VALUES
    ('Mountain_Faith11', 'Placeholder', 'YIELD_FAITH', 2, 'TERRAIN_GRASS_MOUNTAIN'),
    ('Mountain_Faith12', 'Placeholder', 'YIELD_FAITH', 2, 'TERRAIN_PLAINS_MOUNTAIN'),
    ('Mountain_Faith13', 'Placeholder', 'YIELD_FAITH', 2, 'TERRAIN_DESERT_MOUNTAIN'),
    ('Mountain_Faith14', 'Placeholder', 'YIELD_FAITH', 2, 'TERRAIN_TUNDRA_MOUNTAIN'),
    ('Mountain_Faith15', 'Placeholder', 'YIELD_FAITH', 2, 'TERRAIN_SNOW_MOUNTAIN');
UPDATE Improvement_Adjacencies SET YieldChangeId='Mountain_Faith11' WHERE ImprovementType='IMPROVEMENT_ROCK_HEWN_CHURCH' AND YieldChangeId='Mountain_Faith1';
UPDATE Improvement_Adjacencies SET YieldChangeId='Mountain_Faith12' WHERE ImprovementType='IMPROVEMENT_ROCK_HEWN_CHURCH' AND YieldChangeId='Mountain_Faith2';
UPDATE Improvement_Adjacencies SET YieldChangeId='Mountain_Faith13' WHERE ImprovementType='IMPROVEMENT_ROCK_HEWN_CHURCH' AND YieldChangeId='Mountain_Faith3';
UPDATE Improvement_Adjacencies SET YieldChangeId='Mountain_Faith14' WHERE ImprovementType='IMPROVEMENT_ROCK_HEWN_CHURCH' AND YieldChangeId='Mountain_Faith4';
UPDATE Improvement_Adjacencies SET YieldChangeId='Mountain_Faith15' WHERE ImprovementType='IMPROVEMENT_ROCK_HEWN_CHURCH' AND YieldChangeId='Mountain_Faith5';
*/
UPDATE Improvement_YieldChanges SET YieldChange=0 WHERE ImprovementType='IMPROVEMENT_ROCK_HEWN_CHURCH' AND YieldType='YIELD_FAITH';
-- DELETE FROM Improvement_Adjacencies WHERE ImprovementType='IMPROVEMENT_ROCK_HEWN_CHURCH' AND YieldChangeId='Mountain_Faith1';
-- DELETE FROM Improvement_Adjacencies WHERE ImprovementType='IMPROVEMENT_ROCK_HEWN_CHURCH' AND YieldChangeId='Mountain_Faith2';
-- DELETE FROM Improvement_Adjacencies WHERE ImprovementType='IMPROVEMENT_ROCK_HEWN_CHURCH' AND YieldChangeId='Mountain_Faith3';
-- DELETE FROM Improvement_Adjacencies WHERE ImprovementType='IMPROVEMENT_ROCK_HEWN_CHURCH' AND YieldChangeId='Mountain_Faith4';
-- DELETE FROM Improvement_Adjacencies WHERE ImprovementType='IMPROVEMENT_ROCK_HEWN_CHURCH' AND YieldChangeId='Mountain_Faith5';
-- fix resources faith
/*
UPDATE Modifiers SET ModifierType='MODIFIER_PLAYER_ADJUST_PLOT_YIELD', SubjectRequirementSetId='STAVE_CHURCH_RESOURCE_REQUIREMENTS' WHERE ModifierId='TRAIT_FAITH_RESOURCES';
*/
-- Delete Base Trait
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_CIVILIZATION_ETHIOPIA' AND ModifierId='TRAIT_FAITH_RESOURCES';

INSERT OR IGNORE INTO RequirementSets (RequirementSetId , RequirementSetType) VALUES
    ('PLOT_HAS_CAMP_FISH_PASTURE_PLANTATION_QUARRY_REQUIREMENTS', 'REQUIREMENTSET_TEST_ANY'),
    ('PLOT_HAS_RESOURCE_FARM_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL'); 
    
INSERT OR IGNORE INTO RequirementSetRequirements (RequirementSetId , RequirementId) VALUES
    ('PLOT_HAS_CAMP_FISH_PASTURE_PLANTATION_QUARRY_REQUIREMENTS', 'REQUIRES_PLOT_HAS_PASTURE'),
    ('PLOT_HAS_CAMP_FISH_PASTURE_PLANTATION_QUARRY_REQUIREMENTS', 'REQUIRES_PLOT_HAS_QUARRY'),
    ('PLOT_HAS_CAMP_FISH_PASTURE_PLANTATION_QUARRY_REQUIREMENTS', 'REQUIRES_PLOT_HAS_FISHINGBOATS'),    
    ('PLOT_HAS_CAMP_FISH_PASTURE_PLANTATION_QUARRY_REQUIREMENTS', 'REQUIRES_PLOT_HAS_PLANTATION'),  
    ('PLOT_HAS_CAMP_FISH_PASTURE_PLANTATION_QUARRY_REQUIREMENTS', 'REQUIRES_PLOT_HAS_CAMP'),    
    ('PLOT_HAS_RESOURCE_FARM_REQUIREMENTS', 'REQUIRES_PLOT_HAS_FARM'),
    ('PLOT_HAS_RESOURCE_FARM_REQUIREMENTS', 'REQUIRES_PLOT_HAS_VISIBLE_RESOURCE');      
    
    
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType, SubjectRequirementSetId) VALUES
    ('TRAIT_FAITH_CAMP_FISH_PASTURE_PLANTATION_QUARRY_RESOURCES', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'PLOT_HAS_CAMP_FISH_PASTURE_PLANTATION_QUARRY_REQUIREMENTS'),
    ('TRAIT_FAITH_FARMED_RESOURCES', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'PLOT_HAS_RESOURCE_FARM_REQUIREMENTS'),
    ('TRAIT_FAITH_MINED_BONUS_RESOURCES', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'PLOT_HAS_BONUS_MINE_REQUIREMENTS'),
    ('TRAIT_FAITH_MINED_LUXURY_RESOURCES', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'PLOT_HAS_LUXURY_MINE_REQUIREMENTS'),
    ('TRAIT_FAITH_MINED_STRATEGIC_RESOURCES', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'PLOT_HAS_STRATEGIC_MINE_REQUIREMENTS'); 

INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name, Value) VALUES
    ('TRAIT_FAITH_CAMP_FISH_PASTURE_PLANTATION_QUARRY_RESOURCES', 'YieldType', 'YIELD_FAITH'),
    ('TRAIT_FAITH_CAMP_FISH_PASTURE_PLANTATION_QUARRY_RESOURCES', 'Amount', 1),
    ('TRAIT_FAITH_FARMED_RESOURCES', 'YieldType', 'YIELD_FAITH'),
    ('TRAIT_FAITH_FARMED_RESOURCES', 'Amount', 1),
    ('TRAIT_FAITH_MINED_BONUS_RESOURCES', 'YieldType', 'YIELD_FAITH'),
    ('TRAIT_FAITH_MINED_BONUS_RESOURCES', 'Amount', 1),
    ('TRAIT_FAITH_MINED_LUXURY_RESOURCES', 'YieldType', 'YIELD_FAITH'),
    ('TRAIT_FAITH_MINED_LUXURY_RESOURCES', 'Amount', 1),
    ('TRAIT_FAITH_MINED_STRATEGIC_RESOURCES', 'YieldType', 'YIELD_FAITH'),
    ('TRAIT_FAITH_MINED_STRATEGIC_RESOURCES', 'Amount', 1);

INSERT OR IGNORE INTO TraitModifiers (TraitType , ModifierId) VALUES
    ('TRAIT_CIVILIZATION_ETHIOPIA', 'TRAIT_FAITH_FARMED_RESOURCES'),
    ('TRAIT_CIVILIZATION_ETHIOPIA', 'TRAIT_FAITH_CAMP_FISH_PASTURE_PLANTATION_QUARRY_RESOURCES'),
    ('TRAIT_CIVILIZATION_ETHIOPIA', 'TRAIT_FAITH_MINED_BONUS_RESOURCES'),   
    ('TRAIT_CIVILIZATION_ETHIOPIA', 'TRAIT_FAITH_MINED_LUXURY_RESOURCES'),  
    ('TRAIT_CIVILIZATION_ETHIOPIA', 'TRAIT_FAITH_MINED_STRATEGIC_RESOURCES');   

UPDATE ModifierArguments SET Value='10' WHERE ModifierId='TRAIT_FAITH_INTO_SCIENCE_HILLS' AND Name='Amount';
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='TRAIT_FAITH_INTO_CULTURE_HILLS' AND Name='Amount';

-- Start Bias
DELETE FROM StartBiasTerrains WHERE CivilizationType='CIVILIZATION_ETHIOPIA' AND TerrainType IN ('TERRAIN_TUNDRA_HILLS', 'TERRAIN_DESERT_HILLS');
UPDATE StartBiasTerrains SET Tier=3 WHERE CivilizationType='CIVILIZATION_ETHIOPIA' AND TerrainType IN ('TERRAIN_GRASS_HILLS', 'TERRAIN_PLAINS_HILLS');

-- +4 on hills only for Oromo
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_LEADER_MENELIK' AND ModifierId='TRAIT_HILLS_COMBAT';
-- BBG_UNIT_ON_HILL_REQUIREMENTS coded on _utils.sql
INSERT OR IGNORE INTO Modifiers ( ModifierId, ModifierType, SubjectRequirementSetId ) VALUES
    ('OROMO_HILLS_COMBAT_BBG', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'BBG_UNIT_ON_HILL_REQUIREMENTS'),
    ('BBG_OROMO_MOVEMENT_ON_HILL', 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT', 'BBG_UNIT_ON_HILL_REQUIREMENTS');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('OROMO_HILLS_COMBAT_BBG', 'Amount', '4'),
    ('BBG_OROMO_MOVEMENT_ON_HILL', 'Amount', '1');
INSERT OR IGNORE INTO ModifierStrings (ModifierId, Context, Text) VALUES
    ('OROMO_HILLS_COMBAT_BBG', 'Preview', 'LOC_ABILITY_MENELIK_HILLS_COMBAT_STRENGTH_DESCRIPTION');
INSERT OR IGNORE INTO UnitAbilityModifiers VALUES
    ('ABILITY_ETHIOPIAN_OROMO_CAVALRY', 'OROMO_HILLS_COMBAT_BBG'),
    ('ABILITY_ETHIOPIAN_OROMO_CAVALRY', 'BBG_OROMO_MOVEMENT_ON_HILL');

DELETE FROM Modifiers WHERE ModifierId='ETHIOPIAN_OROMO_CAVALRY_IGNORE_HILLS_MOVEMENT_PENALTY';