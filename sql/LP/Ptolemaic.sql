
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_LEADER_CLEOPATRA_ALT';

-- 02/12/24 bonus production doubled when city is settled on river for encampment and campus
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
    ('BBG_PTOLE_FASTER_ENCAMPMENT_RIVER', 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION', 'PLOT_ADJACENT_TO_RIVER_REQUIREMENTS'),
    ('BBG_PTOLE_FASTER_CAMPUS_RIVER', 'MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION', 'PLOT_ADJACENT_TO_RIVER_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('BBG_PTOLE_FASTER_ENCAMPMENT_RIVER', 'DistrictType', 'DISTRICT_ENCAMPMENT'),
    ('BBG_PTOLE_FASTER_ENCAMPMENT_RIVER', 'Amount', 15),
    ('BBG_PTOLE_FASTER_CAMPUS_RIVER', 'DistrictType', 'DISTRICT_CAMPUS'),
    ('BBG_PTOLE_FASTER_CAMPUS_RIVER', 'Amount', 15);
INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
    ('TRAIT_LEADER_CLEOPATRA_ALT', 'BBG_PTOLE_FASTER_ENCAMPMENT_RIVER'),
    ('TRAIT_LEADER_CLEOPATRA_ALT', 'BBG_PTOLE_FASTER_CAMPUS_RIVER');

-- 02/12/24 Ptole military units ignores rivers and gets +3 cs on floodplains
-- 08/01/25 ignores rivers removed

INSERT INTO TypeTags (Type, Tag) VALUES
    ('BBG_PTOLE_BONUSES_ON_RIVER_ABILITY', 'CLASS_ALL_COMBAT_UNITS');
INSERT INTO Types (Type, Kind) VALUES
    ('BBG_PTOLE_BONUSES_ON_RIVER_ABILITY', 'KIND_ABILITY');
INSERT INTO UnitAbilities (UnitAbilityType, Name, Description, Inactive) VALUES
    ('BBG_PTOLE_BONUSES_ON_RIVER_ABILITY', 'LOC_BBG_PTOLE_NO_MALUSES_ON_RIVER_ABILITY_NAME', 'LOC_BBG_PTOLE_NO_MALUSES_ON_RIVER_ABILITY_DESC', 1);
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
    ('BBG_PTOLE_BONUSES_ON_RIVER_ABILITY', 'BBG_PTOLE_COMBAT_STRENGTH_ON_FLOODPLAINS_MODIFIER');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
    ('BBG_PTOLE_COMBAT_STRENGTH_ON_FLOODPLAINS_GIVER', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', NULL),
    ('BBG_PTOLE_COMBAT_STRENGTH_ON_FLOODPLAINS_MODIFIER', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'PLOT_FLOODPLAINS_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('BBG_PTOLE_COMBAT_STRENGTH_ON_FLOODPLAINS_GIVER', 'AbilityType', 'BBG_PTOLE_BONUSES_ON_RIVER_ABILITY'),
    ('BBG_PTOLE_COMBAT_STRENGTH_ON_FLOODPLAINS_MODIFIER', 'Amount', 5);
INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
    ('TRAIT_LEADER_CLEOPATRA_ALT', 'BBG_PTOLE_COMBAT_STRENGTH_ON_FLOODPLAINS_GIVER');
INSERT INTO ModifierStrings(ModifierId, Context, Text) VALUES
    ('BBG_PTOLE_COMBAT_STRENGTH_ON_FLOODPLAINS_MODIFIER', 'Preview', 'LOC_BBG_PTOLE_COMBAT_STRENGTH_ON_FLOODPLAINS_MODIFIER');