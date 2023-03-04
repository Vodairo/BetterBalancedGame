--==============================================================
--******			C I V I L I Z A T I O N S			  ******
--==============================================================

--==========
-- Macedon
--==========
-- adj general bugfix
UPDATE Modifiers SET SubjectRequirementSetId=NULL WHERE ModifierId='HETAIROI_GREAT_GENERAL_COMBAT_BONUS';
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('GREAT_GENERAL_HETAIROI_COMBAT_STRENGTH_BBG', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'IS_ADJ_HETAIROI_REQUIREMENTS_BBG');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('GREAT_GENERAL_HETAIROI_COMBAT_STRENGTH_BBG', 'AbilityType', 'ABILITY_HETAIROI_COMBAT_STRENGTH_BBG');
INSERT OR IGNORE INTO Types (Type, Kind) VALUES
	('ABILITY_HETAIROI_COMBAT_STRENGTH_BBG', 'KIND_ABILITY');
INSERT OR IGNORE INTO TypeTags VALUES
	('ABILITY_HETAIROI_COMBAT_STRENGTH_BBG' ,'CLASS_HETAIROI');
INSERT OR IGNORE INTO UnitAbilities (UnitAbilityType, Name, Description, Inactive) VALUES
	('ABILITY_HETAIROI_COMBAT_STRENGTH_BBG', 'blah1', 'blah2', 1);
DELETE FROM UnitAbilityModifiers WHERE UnitAbilityType='ABILITY_HETAIROI' AND ModifierId='HETAIROI_GREAT_GENERAL_COMBAT_BONUS';
INSERT OR IGNORE INTO UnitAbilityModifiers VALUES
	('ABILITY_HETAIROI_COMBAT_STRENGTH_BBG', 'HETAIROI_GREAT_GENERAL_COMBAT_BONUS');
INSERT OR IGNORE INTO RequirementSets VALUES
	('IS_ADJ_HETAIROI_REQUIREMENTS_BBG', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements VALUES
	('IS_ADJ_HETAIROI_REQUIREMENTS_BBG', 'REQUIREMENT_UNIT_IS_HETAIROI'),
	('IS_ADJ_HETAIROI_REQUIREMENTS_BBG', 'AOE_REQUIRES_OWNER_ADJACENCY_BBG');
INSERT OR IGNORE INTO Requirements (RequirementId, RequirementType) VALUES
	('AOE_REQUIRES_OWNER_ADJACENCY_BBG', 'REQUIREMENT_PLOT_ADJACENT_TO_OWNER');
INSERT OR IGNORE INTO RequirementArguments (RequirementId, Name, Value) VALUES
	('AOE_REQUIRES_OWNER_ADJACENCY_BBG', 'MinDistance', '0'),
	('AOE_REQUIRES_OWNER_ADJACENCY_BBG', 'MaxDistance', '1');
INSERT OR IGNORE INTO GreatPersonIndividualBirthModifiers
	SELECT DISTINCT GreatPersonIndividualType, 'GREAT_GENERAL_HETAIROI_COMBAT_STRENGTH_BBG'
	FROM (SELECT * FROM GreatPersonIndividuals WHERE GreatPersonClassType='GREAT_PERSON_CLASS_GENERAL');

UPDATE ModifierArguments SET Value='10' WHERE ModifierId='HYPASPIST_SIEGE_BONUS' AND Name='Amount';
-- 25% Science from kills (online speed)
INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId)
	VALUES ('TRAIT_LEADER_TO_WORLDS_END', 'SCIENCE_ON_KILLS_BBG');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType)
	VALUES ('SCIENCE_ON_KILLS_BBG', 'MODIFIER_PLAYER_UNITS_ADJUST_POST_COMBAT_YIELD');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value)
	VALUES
		('SCIENCE_ON_KILLS_BBG', 'PercentDefeatedStrength', '50'),
		('SCIENCE_ON_KILLS_BBG', 'YieldType', 'YIELD_SCIENCE');
-- +20% Production for 10 turns after conquering a city
INSERT OR IGNORE INTO TraitModifiers (TraitType , ModifierId)
	VALUES
	('TRAIT_CIVILIZATION_HELLENISTIC_FUSION' , 'TRAIT_CIVILIZATION_HELLENISTIC_FUSION_PRODUCTION_MODIFIER');
INSERT INTo Requirements(RequirementId, RequirementType) VALUES
	('MACEDON_RECENTLY_CONQUERED_BBG_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES');
INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
	('MACEDON_RECENTLY_CONQUERED_BBG_REQ', 'PropertyName', 'GETS_MACEDON_20'),
	('MACEDON_RECENTLY_CONQUERED_BBG_REQ', 'PropertyMinimum', 1);
INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
	('MACEDON_RECENTLY_CONQUERED_BBG_REQSET', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
	('MACEDON_RECENTLY_CONQUERED_BBG_REQSET', 'MACEDON_RECENTLY_CONQUERED_BBG_REQ');
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('TRAIT_CIVILIZATION_HELLENISTIC_FUSION_PRODUCTION_MODIFIER', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_MODIFIER', 'MACEDON_RECENTLY_CONQUERED_BBG_REQSET');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
	('TRAIT_CIVILIZATION_HELLENISTIC_FUSION_PRODUCTION_MODIFIER', 'YieldType', 'YIELD_PRODUCTION'),
	('TRAIT_CIVILIZATION_HELLENISTIC_FUSION_PRODUCTION_MODIFIER', 'Amount', 20);

/*--this is greyed out because Diplo Modifiers are bugged
INSERT OR IGNORE INTO Modifiers (ModifierId , ModifierType)
	VALUES
	('TRAIT_CIVILIZATION_HELLENISTIC_FUSION_PRODUCTION_MODIFIER' , 'MODIFIER_PLAYER_ADD_DIPLOMATIC_YIELD_MODIFIER');
INSERT OR IGNORE INTO ModifierArguments (ModifierId , Name , Value)
	VALUES 
	('TRAIT_CIVILIZATION_HELLENISTIC_FUSION_PRODUCTION_MODIFIER' , 'DiplomaticYieldSource' , 'CITY_CAPTURED'   ),
	('TRAIT_CIVILIZATION_HELLENISTIC_FUSION_PRODUCTION_MODIFIER' , 'TurnsActive'           , '10'              ),
	('TRAIT_CIVILIZATION_HELLENISTIC_FUSION_PRODUCTION_MODIFIER' , 'YieldType'             , 'YIELD_PRODUCTION'),
	('TRAIT_CIVILIZATION_HELLENISTIC_FUSION_PRODUCTION_MODIFIER' , 'Amount'                , '20'              );
*/
-- Hetairoi no longer a Horseman replacement
DELETE FROM UnitReplaces WHERE CivUniqueUnitType='UNIT_MACEDONIAN_HETAIROI';


--==================
-- Persia
--==================
-- Pairidaeza gets yields for other district types as well
INSERT OR IGNORE INTO Adjacency_YieldChanges
	(ID, Description, YieldType, YieldChange, TilesRequired, AdjacentDistrict)
	VALUES
	('BBG_PAIRIDAEZA_CAMPUSADJACENCY', 'Placeholder', 'YIELD_CULTURE', 1, 1, 'DISTRICT_CAMPUS'),
	('BBG_PAIRIDAEZA_INDUSTRIALADJACENCY', 'Placeholder', 'YIELD_GOLD', 1, 1, 'DISTRICT_INDUSTRIAL_ZONE'),
	('BBG_PAIRIDAEZA_HARBORADJACENCY', 'Placeholder', 'YIELD_GOLD', 1, 1, 'DISTRICT_HARBOR');
INSERT OR IGNORE INTO Improvement_Adjacencies
	(ImprovementType, YieldChangeId)
	VALUES
	('IMPROVEMENT_PAIRIDAEZA', 'BBG_PAIRIDAEZA_CAMPUSADJACENCY'),
	('IMPROVEMENT_PAIRIDAEZA', 'BBG_PAIRIDAEZA_INDUSTRIALADJACENCY'),
	('IMPROVEMENT_PAIRIDAEZA', 'BBG_PAIRIDAEZA_HARBORADJACENCY');
-- internal trades routes scaling

INSERT OR IGNORE INTO RequirementSets
	(RequirementSetId , RequirementSetType)
	VALUES
	('PERSIA_MEDIEVAL_FAIRES_REQUIREMENTS_CPLMOD', 	'REQUIREMENTSET_TEST_ALL'),
	('PERSIA_URBANIZATION_REQUIREMENTS_CPLMOD', 	'REQUIREMENTSET_TEST_ALL'),
	('PERSIA_BANKING_REQUIREMENTS_CPLMOD'   , 		'REQUIREMENTSET_TEST_ALL'),
	('PERSIA_ECONOMICS_REQUIREMENTS_CPLMOD' , 		'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements
	(RequirementSetId , RequirementId)
	VALUES
	('PERSIA_MEDIEVAL_FAIRES_REQUIREMENTS_CPLMOD', 	'PLAYER_HAS_MEDIEVAL_FAIRES_CPLMOD'),
	('PERSIA_URBANIZATION_REQUIREMENTS_CPLMOD', 	'PLAYER_HAS_URBANIZATION_CPLMOD'),
	('PERSIA_BANKING_REQUIREMENTS_CPLMOD'   , 		'PLAYER_HAS_BANKING_CPLMOD'  ),
	('PERSIA_ECONOMICS_REQUIREMENTS_CPLMOD' , 		'PLAYER_HAS_ECONOMICS_CPLMOD');
INSERT OR IGNORE INTO Modifiers
	(ModifierId, ModifierType, SubjectRequirementSetId)
	VALUES
	('TRAIT_SATRAPIES_INTERNAL_TRADE_CULTURE_AT_MEDIEVAL_FAIRES',	'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_DOMESTIC', 'PERSIA_MEDIEVAL_FAIRES_REQUIREMENTS_CPLMOD'),
	('TRAIT_SATRAPIES_INTERNAL_TRADE_CULTURE_AT_URBANIZATION',		'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_DOMESTIC', 'PERSIA_URBANIZATION_REQUIREMENTS_CPLMOD'),
	('TRAIT_SATRAPIES_INTERNAL_TRADE_GOLD_AT_BANKING',				'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_DOMESTIC', 'PERSIA_BANKING_REQUIREMENTS_CPLMOD'),
	('TRAIT_SATRAPIES_INTERNAL_TRADE_GOLD_AT_ECONOMICS',			'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_DOMESTIC', 'PERSIA_ECONOMICS_REQUIREMENTS_CPLMOD');
INSERT OR IGNORE INTO ModifierArguments
	(ModifierId, Name, Value)
	VALUES
	('TRAIT_SATRAPIES_INTERNAL_TRADE_CULTURE_AT_MEDIEVAL_FAIRES', 	'YieldType', 	'YIELD_CULTURE'),
	('TRAIT_SATRAPIES_INTERNAL_TRADE_CULTURE_AT_MEDIEVAL_FAIRES', 	'Amount', 		'2'),
	('TRAIT_SATRAPIES_INTERNAL_TRADE_CULTURE_AT_URBANIZATION', 		'YieldType', 	'YIELD_CULTURE'),
	('TRAIT_SATRAPIES_INTERNAL_TRADE_CULTURE_AT_URBANIZATION', 		'Amount', 		'2'),
	('TRAIT_SATRAPIES_INTERNAL_TRADE_GOLD_AT_BANKING', 				'YieldType', 	'YIELD_GOLD'),
	('TRAIT_SATRAPIES_INTERNAL_TRADE_GOLD_AT_BANKING', 				'Amount', 		'2'),
	('TRAIT_SATRAPIES_INTERNAL_TRADE_GOLD_AT_ECONOMICS', 			'YieldType', 	'YIELD_GOLD'),
	('TRAIT_SATRAPIES_INTERNAL_TRADE_GOLD_AT_ECONOMICS', 			'Amount', 		'2');
INSERT OR IGNORE INTO TraitModifiers
	(TraitType, ModifierId)
	VALUES
	('TRAIT_CIVILIZATION_SATRAPIES', 'TRAIT_SATRAPIES_INTERNAL_TRADE_CULTURE_AT_MEDIEVAL_FAIRES'),
	('TRAIT_CIVILIZATION_SATRAPIES', 'TRAIT_SATRAPIES_INTERNAL_TRADE_CULTURE_AT_URBANIZATION'),
	('TRAIT_CIVILIZATION_SATRAPIES', 'TRAIT_SATRAPIES_INTERNAL_TRADE_GOLD_AT_BANKING'),
	('TRAIT_CIVILIZATION_SATRAPIES', 'TRAIT_SATRAPIES_INTERNAL_TRADE_GOLD_AT_ECONOMICS');

-- +3 combat when attacking
INSERT OR IGNORE INTO Modifiers
	(ModifierId, ModifierType, SubjectRequirementSetId)
	VALUES
	('TRAIT_FALLBABYLON_COMBAT_BONUS', 'MODIFIER_PLAYER_UNITS_ADJUST_COMBAT_STRENGTH', 'ATTACKING_REQUIREMENT_SET');
INSERT OR IGNORE INTO ModifierArguments
	(ModifierId, Name, Value)
	VALUES
	('TRAIT_FALLBABYLON_COMBAT_BONUS', 'Amount', '3');
INSERT OR IGNORE INTO ModifierStrings
	(ModifierId, Context, Text)
	VALUES
	('TRAIT_FALLBABYLON_COMBAT_BONUS', 'Preview', 'LOC_TRAIT_FALLBABYLON_COMBAT_BONUS_DESCRIPTION');
INSERT OR IGNORE INTO RequirementSets
	(RequirementSetId , RequirementSetType)
	VALUES
	('ATTACKING_REQUIREMENT_SET', 'REQUIREMENTSET_TEST_ALL');
INSERT OR IGNORE INTO RequirementSetRequirements
	(RequirementSetId , RequirementId)
	VALUES
	('ATTACKING_REQUIREMENT_SET', 'PLAYER_IS_ATTACKER_REQUIREMENTS');
INSERT OR IGNORE INTO TraitModifiers
	(TraitType, ModifierId)
	VALUES
	('TRAIT_LEADER_FALL_BABYLON', 'TRAIT_FALLBABYLON_COMBAT_BONUS');
-- Persia surprise war movement bonus nullified
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_FALLBABYLON_SURPRISE_MOVEMENT' and Name='Amount';
-- Immortals to 36 to match swordsman up.
UPDATE Units SET Combat=36 WHERE UnitType='UNIT_PERSIAN_IMMORTAL';



--==============================================================
--******			W O N D E R S  (MAN-MADE)			  ******
--==============================================================
-- Apadana +1 envoy instead of 2
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='APADANA_AWARD_TWO_INFLUENCE_TOKEN_MODIFIER';




