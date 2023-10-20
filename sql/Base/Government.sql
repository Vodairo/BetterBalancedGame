--==============================================================================================
--******				GOVERNMENT						   ******
--==============================================================================================
-- fascism attack bonus works on defense now too
UPDATE Modifiers SET SubjectRequirementSetId=NULL WHERE ModifierId='FASCISM_ATTACK_BUFF';
UPDATE Modifiers SET SubjectRequirementSetId=NULL WHERE ModifierId='FASCISM_LEGACY_ATTACK_BUFF';

UPDATE Governments SET OtherGovernmentIntolerance=0 WHERE GovernmentType='GOVERNMENT_DEMOCRACY';
UPDATE Governments SET OtherGovernmentIntolerance=-40 WHERE GovernmentType='GOVERNMENT_FASCISM';
UPDATE Governments SET OtherGovernmentIntolerance=-40 WHERE GovernmentType='GOVERNMENT_COMMUNISM';
UPDATE ModifierArguments SET Value='4' WHERE ModifierId='COLLECTIVIZATION_INTERNAL_TRADE_PRODUCTION' AND Name='Amount';

-- Government slot
UPDATE Government_SlotCounts SET NumSlots=1 WHERE GovernmentType='GOVERNMENT_MERCHANT_REPUBLIC' AND GovernmentSlotType='SLOT_DIPLOMATIC';
UPDATE Government_SlotCounts SET NumSlots=2 WHERE GovernmentType='GOVERNMENT_MERCHANT_REPUBLIC' AND GovernmentSlotType='SLOT_WILDCARD';

--11/12/22 Communism -1 red card +1 yellow card
UPDATE Government_SlotCounts SET NumSlots=2 WHERE GovernmentType='GOVERNMENT_COMMUNISM' AND GovernmentSlotType='SLOT_MILITARY';
UPDATE Government_SlotCounts SET NumSlots=4 WHERE GovernmentType='GOVERNMENT_COMMUNISM' AND GovernmentSlotType='SLOT_ECONOMIC';

--11/12/22
--11/12/22 Collectivization also give +4 gold per traderoute
INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
    ('BBG_COLLECTIVIZATION_TRADE_GOLD', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_COLLECTIVIZATION_TRADE_GOLD', 'YieldType', 'YIELD_GOLD'),
    ('BBG_COLLECTIVIZATION_TRADE_GOLD', 'Amount', '4');
INSERT INTO PolicyModifiers(PolicyType, ModifierId) VALUES
    ('POLICY_COLLECTIVIZATION', 'BBG_COLLECTIVIZATION_TRADE_GOLD');

-- 15/10/23 Theocracy discount from 15 to 10%
UPDATE ModifierArguments SET Value=10 WHERE ModifierId='THEOCRACY_FAITH_PURCHASE' and Name='Amount';


/* --5.2. Disable:
-- Communism Specialists
-- Creating Related Reqs and Reqsets
INSERT INTO Requirements(RequirementId, RequirementType) VALUES
    ('BBG_CITY_HAS_BUILDING_HOLY_1_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_HOLY_2_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_HOLY_3_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_CAMP_1_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_CAMP_2_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_CAMP_3_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_ENCA_1_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_ENCA_2_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_ENCA_3_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_HARB_1_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_HARB_2_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_HARB_3_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_COMM_1_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_COMM_2_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_COMM_3_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_THEA_1_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_THEA_2_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_THEA_3_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_INDU_1_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_INDU_2_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES'),
    ('BBG_CITY_HAS_BUILDING_INDU_3_REQ', 'REQUIREMENT_PLOT_PROPERTY_MATCHES');
INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
    ('BBG_CITY_HAS_BUILDING_HOLY_1_REQ', 'PropertyName', 'BUILDING_HOLY'),
    ('BBG_CITY_HAS_BUILDING_HOLY_1_REQ', 'PropertyMinimum', '1'),
    ('BBG_CITY_HAS_BUILDING_HOLY_2_REQ', 'PropertyName', 'BUILDING_HOLY'),
    ('BBG_CITY_HAS_BUILDING_HOLY_2_REQ', 'PropertyMinimum', '2'),
    ('BBG_CITY_HAS_BUILDING_HOLY_3_REQ', 'PropertyName', 'BUILDING_HOLY'),
    ('BBG_CITY_HAS_BUILDING_HOLY_3_REQ', 'PropertyMinimum', '3'),
    ('BBG_CITY_HAS_BUILDING_CAMP_1_REQ', 'PropertyName', 'BUILDING_CAMP'),
    ('BBG_CITY_HAS_BUILDING_CAMP_1_REQ', 'PropertyMinimum', '1'),
    ('BBG_CITY_HAS_BUILDING_CAMP_2_REQ', 'PropertyName', 'BUILDING_CAMP'),
    ('BBG_CITY_HAS_BUILDING_CAMP_2_REQ', 'PropertyMinimum', '2'),
    ('BBG_CITY_HAS_BUILDING_CAMP_3_REQ', 'PropertyName', 'BUILDING_CAMP'),
    ('BBG_CITY_HAS_BUILDING_CAMP_3_REQ', 'PropertyMinimum', '3'),
    ('BBG_CITY_HAS_BUILDING_ENCA_1_REQ', 'PropertyName', 'BUILDING_ENCA'),
    ('BBG_CITY_HAS_BUILDING_ENCA_1_REQ', 'PropertyMinimum', '1'),
    ('BBG_CITY_HAS_BUILDING_ENCA_2_REQ', 'PropertyName', 'BUILDING_ENCA'),
    ('BBG_CITY_HAS_BUILDING_ENCA_2_REQ', 'PropertyMinimum', '2'),
    ('BBG_CITY_HAS_BUILDING_ENCA_3_REQ', 'PropertyName', 'BUILDING_ENCA'),
    ('BBG_CITY_HAS_BUILDING_ENCA_3_REQ', 'PropertyMinimum', '3'),
    ('BBG_CITY_HAS_BUILDING_HARB_1_REQ', 'PropertyName', 'BUILDING_HARB'),
    ('BBG_CITY_HAS_BUILDING_HARB_1_REQ', 'PropertyMinimum', '1'),
    ('BBG_CITY_HAS_BUILDING_HARB_2_REQ', 'PropertyName', 'BUILDING_HARB'),
    ('BBG_CITY_HAS_BUILDING_HARB_2_REQ', 'PropertyMinimum', '2'),
    ('BBG_CITY_HAS_BUILDING_HARB_3_REQ', 'PropertyName', 'BUILDING_HARB'),
    ('BBG_CITY_HAS_BUILDING_HARB_3_REQ', 'PropertyMinimum', '3'),
    ('BBG_CITY_HAS_BUILDING_COMM_1_REQ', 'PropertyName', 'BUILDING_COMM'),
    ('BBG_CITY_HAS_BUILDING_COMM_1_REQ', 'PropertyMinimum', '1'),
    ('BBG_CITY_HAS_BUILDING_COMM_2_REQ', 'PropertyName', 'BUILDING_COMM'),
    ('BBG_CITY_HAS_BUILDING_COMM_2_REQ', 'PropertyMinimum', '2'),
    ('BBG_CITY_HAS_BUILDING_COMM_3_REQ', 'PropertyName', 'BUILDING_COMM'),
    ('BBG_CITY_HAS_BUILDING_COMM_3_REQ', 'PropertyMinimum', '3'),
    ('BBG_CITY_HAS_BUILDING_THEA_1_REQ', 'PropertyName', 'BUILDING_THEA'),
    ('BBG_CITY_HAS_BUILDING_THEA_1_REQ', 'PropertyMinimum', '1'),
    ('BBG_CITY_HAS_BUILDING_THEA_2_REQ', 'PropertyName', 'BUILDING_THEA'),
    ('BBG_CITY_HAS_BUILDING_THEA_2_REQ', 'PropertyMinimum', '2'),
    ('BBG_CITY_HAS_BUILDING_THEA_3_REQ', 'PropertyName', 'BUILDING_THEA'),
    ('BBG_CITY_HAS_BUILDING_THEA_3_REQ', 'PropertyMinimum', '3'),
    ('BBG_CITY_HAS_BUILDING_INDU_1_REQ', 'PropertyName', 'BUILDING_INDU'),
    ('BBG_CITY_HAS_BUILDING_INDU_1_REQ', 'PropertyMinimum', '1'),
    ('BBG_CITY_HAS_BUILDING_INDU_2_REQ', 'PropertyName', 'BUILDING_INDU'),
    ('BBG_CITY_HAS_BUILDING_INDU_2_REQ', 'PropertyMinimum', '2'),
    ('BBG_CITY_HAS_BUILDING_INDU_3_REQ', 'PropertyName', 'BUILDING_INDU'),
    ('BBG_CITY_HAS_BUILDING_INDU_3_REQ', 'PropertyMinimum', '3');
INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
    ('BBG_CITY_HAS_BUILDING_HOLY_1_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_HOLY_2_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_HOLY_3_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_CAMP_1_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_CAMP_2_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_CAMP_3_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_ENCA_1_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_ENCA_2_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_ENCA_3_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_HARB_1_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_HARB_2_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_HARB_3_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_COMM_1_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_COMM_2_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_COMM_3_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_THEA_1_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_THEA_2_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_THEA_3_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_INDU_1_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_INDU_2_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_CITY_HAS_BUILDING_INDU_3_REQSET', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
    ('BBG_CITY_HAS_BUILDING_HOLY_1_REQSET', 'BBG_CITY_HAS_BUILDING_HOLY_1_REQ'),
    ('BBG_CITY_HAS_BUILDING_HOLY_2_REQSET', 'BBG_CITY_HAS_BUILDING_HOLY_2_REQ'),
    ('BBG_CITY_HAS_BUILDING_HOLY_3_REQSET', 'BBG_CITY_HAS_BUILDING_HOLY_3_REQ'),
    ('BBG_CITY_HAS_BUILDING_CAMP_1_REQSET', 'BBG_CITY_HAS_BUILDING_CAMP_1_REQ'),
    ('BBG_CITY_HAS_BUILDING_CAMP_2_REQSET', 'BBG_CITY_HAS_BUILDING_CAMP_2_REQ'),
    ('BBG_CITY_HAS_BUILDING_CAMP_3_REQSET', 'BBG_CITY_HAS_BUILDING_CAMP_3_REQ'),
    ('BBG_CITY_HAS_BUILDING_ENCA_1_REQSET', 'BBG_CITY_HAS_BUILDING_ENCA_1_REQ'),
    ('BBG_CITY_HAS_BUILDING_ENCA_2_REQSET', 'BBG_CITY_HAS_BUILDING_ENCA_2_REQ'),
    ('BBG_CITY_HAS_BUILDING_ENCA_3_REQSET', 'BBG_CITY_HAS_BUILDING_ENCA_3_REQ'),
    ('BBG_CITY_HAS_BUILDING_HARB_1_REQSET', 'BBG_CITY_HAS_BUILDING_HARB_1_REQ'),
    ('BBG_CITY_HAS_BUILDING_HARB_2_REQSET', 'BBG_CITY_HAS_BUILDING_HARB_2_REQ'),
    ('BBG_CITY_HAS_BUILDING_HARB_3_REQSET', 'BBG_CITY_HAS_BUILDING_HARB_3_REQ'),
    ('BBG_CITY_HAS_BUILDING_COMM_1_REQSET', 'BBG_CITY_HAS_BUILDING_COMM_1_REQ'),
    ('BBG_CITY_HAS_BUILDING_COMM_2_REQSET', 'BBG_CITY_HAS_BUILDING_COMM_2_REQ'),
    ('BBG_CITY_HAS_BUILDING_COMM_3_REQSET', 'BBG_CITY_HAS_BUILDING_COMM_3_REQ'),
    ('BBG_CITY_HAS_BUILDING_THEA_1_REQSET', 'BBG_CITY_HAS_BUILDING_THEA_1_REQ'),
    ('BBG_CITY_HAS_BUILDING_THEA_2_REQSET', 'BBG_CITY_HAS_BUILDING_THEA_2_REQ'),
    ('BBG_CITY_HAS_BUILDING_THEA_3_REQSET', 'BBG_CITY_HAS_BUILDING_THEA_3_REQ'),
    ('BBG_CITY_HAS_BUILDING_INDU_1_REQSET', 'BBG_CITY_HAS_BUILDING_INDU_1_REQ'),
    ('BBG_CITY_HAS_BUILDING_INDU_2_REQSET', 'BBG_CITY_HAS_BUILDING_INDU_2_REQ'),
    ('BBG_CITY_HAS_BUILDING_INDU_3_REQSET', 'BBG_CITY_HAS_BUILDING_INDU_3_REQ');
--Creating Communism modifiers, that look at these dummies
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
    ('COMMUNISM_HOLY_1_FAITH_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_HOLY_1_REQSET'),
    ('COMMUNISM_HOLY_2_FAITH_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_HOLY_2_REQSET'),
    ('COMMUNISM_HOLY_3_FAITH_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_HOLY_3_REQSET'),
    ('COMMUNISM_CAMP_1_SCIENCE_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_CAMP_1_REQSET'),
    ('COMMUNISM_CAMP_2_SCIENCE_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_CAMP_2_REQSET'),
    ('COMMUNISM_CAMP_3_SCIENCE_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_CAMP_3_REQSET'),
    ('COMMUNISM_ENCA_1_PRODUCTION_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_ENCA_1_REQSET'),
    ('COMMUNISM_ENCA_2_PRODUCTION_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_ENCA_2_REQSET'),
    ('COMMUNISM_ENCA_3_PRODUCTION_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_ENCA_3_REQSET'),
    ('COMMUNISM_ENCA_1_GOLD_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_ENCA_1_REQSET'),
    ('COMMUNISM_ENCA_2_GOLD_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_ENCA_2_REQSET'),
    ('COMMUNISM_ENCA_3_GOLD_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_ENCA_3_REQSET'),
    ('COMMUNISM_HARB_1_GOLD_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_HARB_1_REQSET'),
    ('COMMUNISM_HARB_2_GOLD_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_HARB_2_REQSET'),
    ('COMMUNISM_HARB_3_GOLD_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_HARB_3_REQSET'),
    ('COMMUNISM_HARB_1_FOOD_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_HARB_1_REQSET'),
    ('COMMUNISM_HARB_2_FOOD_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_HARB_2_REQSET'),
    ('COMMUNISM_HARB_3_FOOD_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_HARB_3_REQSET'),
    ('COMMUNISM_COMM_1_GOLD_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_COMM_1_REQSET'),
    ('COMMUNISM_COMM_2_GOLD_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_COMM_2_REQSET'),
    ('COMMUNISM_COMM_3_GOLD_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_COMM_3_REQSET'),
    ('COMMUNISM_THEA_1_CULTURE_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_THEA_1_REQSET'),
    ('COMMUNISM_THEA_2_CULTURE_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_THEA_2_REQSET'),
    ('COMMUNISM_THEA_3_CULTURE_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_THEA_3_REQSET'),
    ('COMMUNISM_INDU_1_PRODUCTION_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_INDU_1_REQSET'),
    ('COMMUNISM_INDU_2_PRODUCTION_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_INDU_2_REQSET'),
    ('COMMUNISM_INDU_3_PRODUCTION_MODIFIER_BBG', 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_CHANGE', 'BBG_CITY_HAS_BUILDING_INDU_3_REQSET');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('COMMUNISM_HOLY_1_FAITH_MODIFIER_BBG', 'YieldType', 'YIELD_FAITH'),
    ('COMMUNISM_HOLY_1_FAITH_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_HOLY_2_FAITH_MODIFIER_BBG', 'YieldType', 'YIELD_FAITH'),
    ('COMMUNISM_HOLY_2_FAITH_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_HOLY_3_FAITH_MODIFIER_BBG', 'YieldType', 'YIELD_FAITH'),
    ('COMMUNISM_HOLY_3_FAITH_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_CAMP_1_SCIENCE_MODIFIER_BBG', 'YieldType', 'YIELD_SCIENCE'),
    ('COMMUNISM_CAMP_1_SCIENCE_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_CAMP_2_SCIENCE_MODIFIER_BBG', 'YieldType', 'YIELD_SCIENCE'),
    ('COMMUNISM_CAMP_2_SCIENCE_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_CAMP_3_SCIENCE_MODIFIER_BBG', 'YieldType', 'YIELD_SCIENCE'),
    ('COMMUNISM_CAMP_3_SCIENCE_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_ENCA_1_PRODUCTION_MODIFIER_BBG', 'YieldType', 'YIELD_PRODUCTION'),
    ('COMMUNISM_ENCA_1_PRODUCTION_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_ENCA_2_PRODUCTION_MODIFIER_BBG', 'YieldType', 'YIELD_PRODUCTION'),
    ('COMMUNISM_ENCA_2_PRODUCTION_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_ENCA_3_PRODUCTION_MODIFIER_BBG', 'YieldType', 'YIELD_PRODUCTION'),
    ('COMMUNISM_ENCA_3_PRODUCTION_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_ENCA_1_GOLD_MODIFIER_BBG', 'YieldType', 'YIELD_GOLD'),
    ('COMMUNISM_ENCA_1_GOLD_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_ENCA_2_GOLD_MODIFIER_BBG', 'YieldType', 'YIELD_GOLD'),
    ('COMMUNISM_ENCA_2_GOLD_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_ENCA_3_GOLD_MODIFIER_BBG', 'YieldType', 'YIELD_GOLD'),
    ('COMMUNISM_ENCA_3_GOLD_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_HARB_1_GOLD_MODIFIER_BBG', 'YieldType', 'YIELD_GOLD'),
    ('COMMUNISM_HARB_1_GOLD_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_HARB_2_GOLD_MODIFIER_BBG', 'YieldType', 'YIELD_GOLD'),
    ('COMMUNISM_HARB_2_GOLD_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_HARB_3_GOLD_MODIFIER_BBG', 'YieldType', 'YIELD_GOLD'),
    ('COMMUNISM_HARB_3_GOLD_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_HARB_1_FOOD_MODIFIER_BBG', 'YieldType', 'YIELD_FOOD'),
    ('COMMUNISM_HARB_1_FOOD_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_HARB_2_FOOD_MODIFIER_BBG', 'YieldType', 'YIELD_FOOD'),
    ('COMMUNISM_HARB_2_FOOD_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_HARB_3_FOOD_MODIFIER_BBG', 'YieldType', 'YIELD_FOOD'),
    ('COMMUNISM_HARB_3_FOOD_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_COMM_1_GOLD_MODIFIER_BBG', 'YieldType', 'YIELD_GOLD'),
    ('COMMUNISM_COMM_1_GOLD_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_COMM_2_GOLD_MODIFIER_BBG', 'YieldType', 'YIELD_GOLD'),
    ('COMMUNISM_COMM_2_GOLD_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_COMM_3_GOLD_MODIFIER_BBG', 'YieldType', 'YIELD_GOLD'),
    ('COMMUNISM_COMM_3_GOLD_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_THEA_1_CULTURE_MODIFIER_BBG', 'YieldType', 'YIELD_CULTURE'),
    ('COMMUNISM_THEA_1_CULTURE_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_THEA_2_CULTURE_MODIFIER_BBG', 'YieldType', 'YIELD_CULTURE'),
    ('COMMUNISM_THEA_2_CULTURE_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_THEA_3_CULTURE_MODIFIER_BBG', 'YieldType', 'YIELD_CULTURE'),
    ('COMMUNISM_THEA_3_CULTURE_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_INDU_1_PRODUCTION_MODIFIER_BBG', 'YieldType', 'YIELD_PRODUCTION'),
    ('COMMUNISM_INDU_1_PRODUCTION_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_INDU_2_PRODUCTION_MODIFIER_BBG', 'YieldType', 'YIELD_PRODUCTION'),
    ('COMMUNISM_INDU_2_PRODUCTION_MODIFIER_BBG', 'Amount', '1'),
    ('COMMUNISM_INDU_3_PRODUCTION_MODIFIER_BBG', 'YieldType', 'YIELD_PRODUCTION'),
    ('COMMUNISM_INDU_3_PRODUCTION_MODIFIER_BBG', 'Amount', '1');
--Attaching These modifiers to communism and communism legacy
INSERT INTO GovernmentModifiers(GovernmentType, ModifierId)
    SELECT 'GOVERNMENT_COMMUNISM', Modifiers.ModifierId
    FROM Modifiers WHERE ModifierId LIKE 'COMMUNISM%MODIFIER_BBG';
*/

