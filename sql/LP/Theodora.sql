--Delete original Theodora bonus / Change to +1 culture for hippos and hs per adjacent districts

DELETE FROM TraitModifiers WHERE TraitType='TRAIT_LEADER_THEODORA';

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
	('BBG_THEODORA_HOLYSITE_CULTURE', 'MODIFIER_PLAYER_CITIES_DISTRICT_ADJACENCY'),
	('BBG_THEODORA_HIPPODROME_CULTURE', 'MODIFIER_PLAYER_CITIES_DISTRICT_ADJACENCY');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
	('BBG_THEODORA_HOLYSITE_CULTURE', 'DistrictType', 'DISTRICT_HOLY_SITE'),
	('BBG_THEODORA_HOLYSITE_CULTURE', 'YieldType', 'YIELD_CULTURE'),
	('BBG_THEODORA_HOLYSITE_CULTURE', 'Amount', '1'),
	('BBG_THEODORA_HOLYSITE_CULTURE', 'Description', 'LOC_BBG_THEODORA_HOLYSITE_CULTURE'),
	('BBG_THEODORA_HIPPODROME_CULTURE', 'DistrictType', 'DISTRICT_HIPPODROME'),
	('BBG_THEODORA_HIPPODROME_CULTURE', 'YieldType', 'YIELD_CULTURE'),
	('BBG_THEODORA_HIPPODROME_CULTURE', 'Amount', '1'),
	('BBG_THEODORA_HIPPODROME_CULTURE', 'Description', 'LOC_BBG_THEODORA_HIPPODROME_CULTURE');

INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
	('TRAIT_LEADER_THEODORA', 'BBG_THEODORA_HOLYSITE_CULTURE'),
	('TRAIT_LEADER_THEODORA', 'BBG_THEODORA_HIPPODROME_CULTURE');


-- DELETE FROM TraitModifiers WHERE ModifierId='LUDWIG_WONDER_ADJACENCY';

-- INSERT INTO Requirements (RequirementId, RequirementType) VALUES
--     ('BBG_REQUIRES_WONDER_FINISHED', 'REQUIREMENT_PLAYER_BUILT_WONDER');
-- INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
--     ('BBG_REQUIRES_WONDER_IS_FINISHED_REQUIREMENT', 'REQUIREMENTSET_TEST_ALL');
-- INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
--     ('BBG_REQUIRES_WONDER_IS_FINISHED_REQUIREMENT', 'REQUIRES_DISTRICT_IS_WORLD_WONDER');

-- UPDATE Modifiers SET OwnerRequirementSetId='BBG_REQUIRES_WONDER_IS_FINISHED_REQUIREMENT' WHERE ModifierId='LUDWIG_WONDER_ADJACENCY';