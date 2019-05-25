DELIMITER $$
CREATE DEFINER=`zgyey_20`@`%` PROCEDURE `deletemsg`()
    SQL SECURITY INVOKER
BEGIN
	#Routine body goes here...
	DECLARE _ID INT;
  DECLARE _MID INT;
  DECLARE _sqlcmd VARCHAR(2000);

	IF HOUR(NOW()) IN(1, 2, 3) THEN
		DROP TEMPORARY TABLE IF EXISTS tmp_table;
		CREATE TEMPORARY TABLE IF NOT EXISTS tmp_table (ID int NOT NULL auto_increment, CMD VARCHAR(2000), PRIMARY KEY (`ID`));

		INSERT INTO tmp_table(CMD)
			SELECT CONCAT('DELETE FROM kmapp_0', Floor((userid % 100) / 10), '.push_message_0', (userid % 100) % 10, ' WHERE userid = ', userid, ' and publicid In (16, 17, 18) and title LIKE ''Íø¹Ø×´Ì¬@%'' and adddate < NOW() - INTERVAL 1 DAY;') CMD
				FROM (
							SELECT 862914 userid 
							UNION ALL 
							SELECT 1458942 userid 
							UNION ALL 
							SELECT 862890 userid 
							UNION ALL 
							SELECT 1428030 userid
							UNION ALL 
							SELECT 862883 userid
							UNION ALL 
							SELECT 1458901 userid
							UNION ALL 
							SELECT 1458895 userid 
							UNION ALL 
							SELECT 1458878 userid
				) a ;

		INSERT INTO tmp_table(CMD)
			SELECT REPLACE(CMD, '$db$', db) CMD
				FROM (
							SELECT 0 db 
							UNION ALL 
							SELECT 1 db 
							UNION ALL 
							SELECT 2 db 
							UNION ALL 
							SELECT 3 db
							UNION ALL 
							SELECT 4 db
							UNION ALL 
							SELECT 5 db
							UNION ALL 
							SELECT 6 db 
							UNION ALL 
							SELECT 7 db
							UNION ALL 
							SELECT 8 db
							UNION ALL 
							SELECT 9 db
				) a, 
        (
							SELECT 'INSERT INTO kmapp_0$db$.push_log_history(userid, channel_id, device_user_id, tag, pmid, result, intime, pcid, state, pmtype) SELECT userid, channel_id, device_user_id, tag, pmid, result, intime, pcid, state, pmtype FROM kmapp_0$db$.push_log;' CMD
							UNION ALL 
							SELECT 'TRUNCATE TABLE kmapp_0$db$.push_log;' CMD
							UNION ALL 
							SELECT 'INSERT INTO kmapp_0$db$.send_record_history(ID, exectime, pmidbegin, pmidend, msgidbegin, msgidend, UUID, send, getuigetdate) SELECT ID, exectime, pmidbegin, pmidend, msgidbegin, msgidend, UUID, send, getuigetdate FROM kmapp_0$db$.send_record WHERE exectime < NOW() - INTERVAL 1 DAY;' CMD
							UNION ALL 
							SELECT 'DELETE FROM kmapp_0$db$.send_record WHERE	exectime < NOW() - INTERVAL 1 DAY;' CMD
				) b ;

		SELECT 1, MAX(ID) INTO _ID, _MID FROM tmp_table;

		WHILE _ID <= _MID DO
			SELECT CMD INTO _sqlcmd FROM tmp_table WHERE ID = _ID;

			SET @sqlcmd = _sqlcmd;
			PREPARE stmt FROM @sqlcmd;
			EXECUTE stmt;

			SET _ID = _ID + 1;
		END WHILE;

		DROP TEMPORARY TABLE IF EXISTS tmp_table;
	END IF;

END$$
DELIMITER ;
