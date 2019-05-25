DELIMITER $$
CREATE DEFINER=`zgyey_20`@`%` PROCEDURE `push_message_send`(IN `_pipe` int)
BEGIN
	SET @ID = NULL, @pmidbegin = NULL, @pmidend = NULL, @msgidbegin = NULL, @msgidend = NULL, @uuid = NULL, @send = NULL;
	
	DROP TEMPORARY TABLE IF EXISTS tmp_table;
	CREATE TEMPORARY TABLE tmp_table (publicid INT, msgtype Int, title VARCHAR(2000), content VARCHAR(2000), author VARCHAR(50), file_url VARCHAR(2000), 
																		url VARCHAR(2000), channel_id Varchar(50), device_user_id VARCHAR(100), userid BIGINT, adddate VARCHAR(50), pmid BIGINT, 
																		file_desc VARCHAR(2000), pcid BIGINT, pmtype INT, action INT, shareable INT, contenturl VARCHAR(2000), 
																		msgcount INT, typeid int, optag INT, relationship INT, pipe INT);

	IF 6 < HOUR(now()) AND HOUR(now()) < 23 THEN

		SELECT ID, pmidbegin, pmidend, msgidbegin, msgidend, UUID, send, exectime INTO @ID, @pmidbegin, @pmidend, @msgidbegin, @msgidend, @uuid, @send, @exectime 
			FROM send_record ORDER BY ID DESC LIMIT 1;

		IF ISNULL(@ID) OR NULLIF(@send, 0) THEN
			SET @pmidbegin = @pmidend, @msgidbegin = @msgidend, @uuid = UUID(), @exectime = NOW();
			SELECT MAX(pmid) INTO @pmidend FROM push_message;
			SELECT MAX(msgid) INTO @msgidend FROM user_sys_message;
			
			IF IFNULL(@pmidbegin, 0) <> IFNULL(@pmidend, 0) Or IFNULL(@msgidbegin, 0) <> IFNULL(@msgidend, 0) THEN
				INSERT INTO send_record(exectime, pmidbegin, pmidend, msgidbegin, msgidend, UUID, send) 
					VALUES(@exectime, IFNULL(@pmidbegin, 0), IFNULL(@pmidend, @pmidbegin), IFNULL(@msgidbegin, 0), IFNULL(@msgidend, @msgidbegin), @uuid, 0);

				SET @ID = LAST_INSERT_ID();

			END IF;
		END IF;

		INSERT INTO tmp_table(publicid, msgtype, title, content, author, file_url, url, channel_id, device_user_id, userid, adddate, pmid, 
                          file_desc, pcid, pmtype, action, shareable, contenturl, msgcount, typeid, optag, relationship, pipe)
			Select a.publicid, CASE WHEN a.msgtype = 3 THEN 4 ELSE a.msgtype END msgtype,
						 CASE WHEN a.msgtype = 0 THEN a.content ELSE a.title END title,
						 '' content, '' author, a.file_url, '' url, 2 channel_id, b.device_user_id,
						 a.userid, date_format(CASE WHEN a.publicid In (16, 17, 18) THEN a.adddate + INTERVAL 2 SECOND ELSE a.adddate END, '%Y-%m-%d %H:%i:%s') adddate, 
						 a.pmid, IFNULL(a.content, '') file_desc, IFNULL(a.pcid, 0) pcid, 1 pmtype, a.action, -1 shareable, 
						 CASE WHEN IFNULL(a.url, '') = '' Then '' 
									ELSE CONCAT(CASE WHEN LOCATE('uid=', a.url) > 0 THEN a.url
																	 ELSE CASE WHEN LOCATE('?', a.url) > 0 Then CONCAT(a.url, '&uid=', a.userid)
																						 Else CONCAT(a.url, '?uid=', a.userid)
																				END
															END, '&pmid=', a.pmid, CASE WHEN LOCATE('view=', a.url) > 0 THEN '' 
																													ELSE CASE WHEN a.url LIKE 'http://pr.zgyey.com%' THEN '&view=0' ELSE '&view=1' END END)
						 END contenturl, 1 msgcount, a.typeid, a.optag, b.relationship, a.pipe
				From push_message a, and_userinfo b
				Where a.userid = b.userid and a.adddate < @exectime and a.`status` = 0 and a.deletetag = 1 and b.device_user_id <> '';

		IF FOUND_ROWS() = 0 THEN
			UPDATE send_record SET send = 1 WHERE ID = @ID;
		END IF;

		UPDATE send_record SET getuigetdate = CURRENT_TIMESTAMP WHERE ID = @ID;
		REPLACE INTO pmid_gettui(UUID, pmid) SELECT @uuid, pmid FROM tmp_table;
	END IF;

	SELECT * FROM tmp_table;
	SELECT @uuid uuid;

	DROP TEMPORARY TABLE IF EXISTS tmp_table;
END$$
DELIMITER ;
