-- DB update 2022_02_17_03 -> 2022_02_17_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_17_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_17_03 2022_02_17_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1645117684168191300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645117684168191300');

UPDATE `npc_text` SET `text0_0` = "", `text0_1` = (SELECT `FemaleText` FROM `broadcast_text` WHERE `ID` = 11406), `BroadcastTextID0` = 11406 WHERE `ID` = 8121;
UPDATE `npc_text` SET `text0_0` = "", `text0_1` = (SELECT `FemaleText` FROM `broadcast_text` WHERE `ID` = 11410), `BroadcastTextID0` = 11410 WHERE `ID` = 8122;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_17_04' WHERE sql_rev = '1645117684168191300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;