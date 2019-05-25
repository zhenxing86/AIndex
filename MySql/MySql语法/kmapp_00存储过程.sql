DELIMITER $$
CREATE DEFINER=`zgyey_20`@`%` PROCEDURE `clean_message`()
BEGIN
	#Routine body goes here...
	INSERT INTO clean_message_log(begintime) VALUES (NOW());
	SET @ID = LAST_INSERT_ID();

	DELETE FROM push_message_move WHERE EXISTS (SELECT 1 FROM push_message_00 b WHERE push_message_move.pmid = b.pmid);
	DELETE FROM push_message_move WHERE EXISTS (SELECT 1 FROM push_message_01 b WHERE push_message_move.pmid = b.pmid);
	DELETE FROM push_message_move WHERE EXISTS (SELECT 1 FROM push_message_02 b WHERE push_message_move.pmid = b.pmid);
	DELETE FROM push_message_move WHERE EXISTS (SELECT 1 FROM push_message_03 b WHERE push_message_move.pmid = b.pmid);
	DELETE FROM push_message_move WHERE EXISTS (SELECT 1 FROM push_message_04 b WHERE push_message_move.pmid = b.pmid);
	DELETE FROM push_message_move WHERE EXISTS (SELECT 1 FROM push_message_05 b WHERE push_message_move.pmid = b.pmid);
	DELETE FROM push_message_move WHERE EXISTS (SELECT 1 FROM push_message_06 b WHERE push_message_move.pmid = b.pmid);
	DELETE FROM push_message_move WHERE EXISTS (SELECT 1 FROM push_message_07 b WHERE push_message_move.pmid = b.pmid);
	DELETE FROM push_message_move WHERE EXISTS (SELECT 1 FROM push_message_08 b WHERE push_message_move.pmid = b.pmid);
	DELETE FROM push_message_move WHERE EXISTS (SELECT 1 FROM push_message_09 b WHERE push_message_move.pmid = b.pmid);

	DELETE FROM user_sys_message_move WHERE EXISTS (SELECT 1 FROM user_sys_message_00 b WHERE user_sys_message_move.msgid = b.msgid);
	DELETE FROM user_sys_message_move WHERE EXISTS (SELECT 1 FROM user_sys_message_01 b WHERE user_sys_message_move.msgid = b.msgid);
	DELETE FROM user_sys_message_move WHERE EXISTS (SELECT 1 FROM user_sys_message_02 b WHERE user_sys_message_move.msgid = b.msgid);
	DELETE FROM user_sys_message_move WHERE EXISTS (SELECT 1 FROM user_sys_message_03 b WHERE user_sys_message_move.msgid = b.msgid);
	DELETE FROM user_sys_message_move WHERE EXISTS (SELECT 1 FROM user_sys_message_04 b WHERE user_sys_message_move.msgid = b.msgid);
	DELETE FROM user_sys_message_move WHERE EXISTS (SELECT 1 FROM user_sys_message_05 b WHERE user_sys_message_move.msgid = b.msgid);
	DELETE FROM user_sys_message_move WHERE EXISTS (SELECT 1 FROM user_sys_message_06 b WHERE user_sys_message_move.msgid = b.msgid);
	DELETE FROM user_sys_message_move WHERE EXISTS (SELECT 1 FROM user_sys_message_07 b WHERE user_sys_message_move.msgid = b.msgid);
	DELETE FROM user_sys_message_move WHERE EXISTS (SELECT 1 FROM user_sys_message_08 b WHERE user_sys_message_move.msgid = b.msgid);
	DELETE FROM user_sys_message_move WHERE EXISTS (SELECT 1 FROM user_sys_message_09 b WHERE user_sys_message_move.msgid = b.msgid);

  UPDATE move_message_log SET endtime = NOW() WHERE ID = @ID;
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`zgyey_20`@`%` PROCEDURE `km_getConversationMessages`(IN `_uid` int,IN `_sysop` int,IN `_relationship` int)
BEGIN
	
	IF _uid > 0 THEN
		SET @tablename = CASE(_uid % 100) % 10 WHEN 0 THEN 'push_message_00' 
																					 WHEN 1 THEN 'push_message_01' 
																					 WHEN 2 THEN 'push_message_02' 
																					 WHEN 3 THEN 'push_message_03' 
																					 WHEN 4 THEN 'push_message_04' 
																					 WHEN 5 THEN 'push_message_05' 
																					 WHEN 6 THEN 'push_message_06' 
																					 WHEN 7 THEN 'push_message_07' 
																					 WHEN 8 THEN 'push_message_08' 
																					 WHEN 9 THEN 'push_message_09'
																					 ELSE 'push_message'
											END;

		SET @sqlcmd = CONCAT('SELECT pmid, Case When msgtype = 3 Then 4 Else msgtype End contenttype, action, publicid,  
																 date_format(CASE WHEN publicid In (16, 17, 18) THEN adddate + INTERVAL 2 SECOND ELSE adddate END, ''%Y-%m-%d %H:%i:%s'') date,  
																 Case When msgtype = 0 Then content Else title End title, file_url fileurl, content filedesc, '''' url, -1 shareable, 
																 CASE WHEN IFNULL(url, '''') = '''' Then '''' 
																			ELSE CONCAT(CASE WHEN LOCATE(''uid='', url) > 0 THEN url
																											 ELSE CASE WHEN LOCATE(''?'', url) > 0 Then CONCAT(url, ''&uid='', userid)
																																 Else CONCAT(url, ''?uid='', userid)
																														END
																									END, ''&pmid='', pmid, CASE WHEN LOCATE(''view='', url) > 0 THEN '''' 
																																							ELSE CASE WHEN url LIKE ''http://pr.zgyey.com%'' THEN ''&view=0'' ELSE ''&view=1'' END END)
																 END contenturl, userid toid, typeid, optag  
														FROM ', @tablename, ' a
														WHERE userid = ', _uid, ' and adddate > DATE_ADD(NOW(), INTERVAL -15 DAY) and adddate <= NOW() and deletetag = 1;');

		PREPARE stmt FROM @sqlcmd;
		EXECUTE stmt;

		SET @tablename = CASE(_uid % 100) % 10 WHEN 0 THEN 'user_sys_message_00' 
																					 WHEN 1 THEN 'user_sys_message_01' 
																					 WHEN 2 THEN 'user_sys_message_02' 
																					 WHEN 3 THEN 'user_sys_message_03' 
																					 WHEN 4 THEN 'user_sys_message_04' 
																					 WHEN 5 THEN 'user_sys_message_05' 
																					 WHEN 6 THEN 'user_sys_message_06' 
																					 WHEN 7 THEN 'user_sys_message_07' 
																					 WHEN 8 THEN 'user_sys_message_08' 
																					 WHEN 9 THEN 'user_sys_message_09'
																					 ELSE 'user_sys_message'
											END;

		SET @sqlcmd = CONCAT('Select msgid pmid, Case When msgtype = 3 Then 4 Else msgtype End contenttype, action, 
                                 date_format(adddate + INTERVAL 1 SECOND, ''%Y-%m-%d %H:%i:%s'') date, 
                                 content, IFNULL(url, '''') contenturl, '''' avatar, IFNULL(title, '''') title, userid toid
														From user_sys_message a
														Where userid = ', _uid, ' and adddate > DATE_ADD(NOW(), INTERVAL -15 DAY) and adddate <= NOW();  ');

		PREPARE stmt FROM @sqlcmd;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
	END IF;

END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`zgyey_20`@`%` PROCEDURE `km_getNewMessages`(IN `_uid` int,IN `_sysop` int,IN `_relationship` int)
BEGIN
	
	IF IFNULL(_uid, 0) <= 0 THEN
		SELECT -1 code, '请求失败' info;
	ELSE
		SELECT msgid pmid, Case When msgtype = 3 Then 4 Else msgtype End contenttype, action, senderid uid, userid toid, date_format(adddate, '%Y-%m-%d %H:%i:%s') date, IFNULL(content, '') content, '' contenturl  
			FROM user_message
			WHERE userid = @uid and status = 1;

		CALL km_getConversationMessages(_uid, _sysop, _relationship);

	END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`zgyey_20`@`%` PROCEDURE `km_getPMLatestMessages`(IN `_uid` int,IN `_publicid` int,IN `_typeid` int)
BEGIN
	

	IF IFNULL(_uid, 0) <= 0 THEN
		SELECT -1 code, '请求失败' info;
	ELSE
		SELECT 0 code, '获取成功' info;

		SET @tablename = CASE(_uid % 100) % 10 WHEN 0 THEN 'push_message_00' 
																					 WHEN 1 THEN 'push_message_01' 
																					 WHEN 2 THEN 'push_message_02' 
																					 WHEN 3 THEN 'push_message_03' 
																					 WHEN 4 THEN 'push_message_04' 
																					 WHEN 5 THEN 'push_message_05' 
																					 WHEN 6 THEN 'push_message_06' 
																					 WHEN 7 THEN 'push_message_07' 
																					 WHEN 8 THEN 'push_message_08' 
																					 WHEN 9 THEN 'push_message_09'
																					 ELSE 'push_message'
											END;

		IF _publicid In (16, 17, 18) THEN
			SET @typeid = CONCAT(' and typeid = ', _typeid);
		ELSE
			SET @typeid = ' ';
		END IF;

		SET @sqlcmd = CONCAT('SELECT pmid, Case When msgtype = 3 Then 4 Else msgtype End contenttype, action, publicid,  
																 date_format(CASE WHEN publicid In (16, 17, 18) THEN adddate + INTERVAL 2 SECOND ELSE adddate END, ''%Y-%m-%d %H:%i:%s'') date,  
																 Case When msgtype = 0 Then content Else title End title, file_url fileurl, content filedesc, '''' url, -1 shareable, 
																 CASE WHEN IFNULL(url, '''') = '''' Then '''' 
																			ELSE CONCAT(CASE WHEN LOCATE(''uid='', url) > 0 THEN url
																											 ELSE CASE WHEN LOCATE(''?'', url) > 0 Then CONCAT(url, ''&uid='', userid)
																																 Else CONCAT(url, ''?uid='', userid)
																														END
																									END, ''&pmid='', pmid, CASE WHEN LOCATE(''view='', url) > 0 THEN '''' 
																																							ELSE CASE WHEN url LIKE ''http://pr.zgyey.com%'' THEN ''&view=0'' ELSE ''&view=1'' END END)
																 END contenturl, @uid toid, typeid, optag  
														FROM ', @tablename, ' a
														WHERE userid = ', _uid, ' and adddate <= NOW() and deletetag = 1 and publicid = ', _publicid, @typeid, ' 
														ORDER BY adddate DESC LIMIT 5 ;');

		PREPARE stmt FROM @sqlcmd;
		EXECUTE stmt;

	END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`zgyey_20`@`%` PROCEDURE `km_updateClientID`(IN `_uid` int,IN `_clientid` varchar(100),IN `_relationship` int,IN `_sysop` int,IN `_action` int)
BEGIN
	

  IF NULLIF(_uid, 0) <= 0 THEN
    SELECT -1 code, '请求失败' info;
	ELSE
		Insert Into gtreglog(userid, device_user_id, relationship, sysop, action, gtregdate)
      Values(_uid, _clientid, _relationship, _sysop, _action, NOW());

#		IF _clientid <> '' THEN
#			DELETE FROM and_userinfo Where device_user_id = _clientid and userid <> _uid;
#		END IF;

		IF NULLIF(_clientid, '') = '' THEN
			DELETE FROM and_userinfo WHERE userid = _uid and device_user_id = '';
		
		ELSE
#			DELETE From and_userinfo WHERE device_user_id = _clientid and NOT(userid = _uid and relationship = _relationship);

			IF EXISTS(SELECT * FROM and_userinfo Where userid	= _uid and relationship = _relationship) THEN
				UPDATE and_userinfo SET device_user_id = _clientid, intime = NOW() WHERE userid	= _uid and relationship = _relationship;

			ELSE
				INSERT INTO and_userinfo(userid, device_user_id, intime, relationship)
					VALUES(_uid, _clientid, NOW(), _relationship);

			END IF;

		END IF;

	END IF;

END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`zgyey_20`@`%` PROCEDURE `move_message`()
BEGIN
	
	INSERT INTO move_message_log(begintime) VALUES (NOW());
	SET @ID = LAST_INSERT_ID();

  SET @pmidend = NULL, @msgidend = NULL, @pmid99end = NULL;
	SELECT pmidbegin, pmidend, msgidbegin, msgidend, exectime INTO @pmidbegin, @pmidend, @msgidbegin, @msgidend, @exectime FROM send_record WHERE send = 1 ORDER BY ID DESC LIMIT 1;
	SELECT pmidend, exectime INTO @pmid99end, @exectime99 FROM send_record_99 WHERE send = 1 ORDER BY ID DESC LIMIT 1;

	INSERT INTO user_sys_message_move(msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, url, crtdate, location)
		SELECT msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, url, crtdate, location
      FROM user_sys_message
			WHERE msgid <= @msgidend and adddate < @exectime;

	DELETE a FROM user_sys_message a WHERE msgid <= @msgidend and EXISTS (SELECT * FROM user_sys_message_move b WHERE a.msgid = b.msgid);

	REPLACE INTO push_message_move(pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe, location) 
    SELECT pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe, location
      FROM push_message 
			WHERE pmid <= @pmidend and adddate < @exectime and pipe <> 99;

	REPLACE INTO push_message_move(pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe, location) 
    SELECT pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe, location
      FROM push_message 
			WHERE pmid <= @pmid99end and adddate < @exectime99 and pipe = 99;

	DELETE a FROM push_message a WHERE pmid <= @pmidend and EXISTS (SELECT * FROM push_message_move b WHERE a.pmid = b.pmid);


	REPLACE INTO push_message_00(pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe) 
    SELECT pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe
      FROM push_message_move 
			WHERE location = 0;
  
	REPLACE INTO push_message_01(pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe) 
    SELECT pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe
      FROM push_message_move 
			WHERE location = 1;
  
	REPLACE INTO push_message_02(pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe) 
    SELECT pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe
      FROM push_message_move 
			WHERE location = 2;
  
	REPLACE INTO push_message_03(pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe) 
    SELECT pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe
      FROM push_message_move 
			WHERE location = 3;
  
	REPLACE INTO push_message_04(pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe) 
    SELECT pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe
      FROM push_message_move 
			WHERE location = 4;
  
	REPLACE INTO push_message_05(pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe) 
    SELECT pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe
      FROM push_message_move 
			WHERE location = 5;
  
	REPLACE INTO push_message_06(pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe) 
    SELECT pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe
      FROM push_message_move 
			WHERE location = 6;
  
	REPLACE INTO push_message_07(pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe) 
    SELECT pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe
      FROM push_message_move 
			WHERE location = 7;
  
	REPLACE INTO push_message_08(pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe) 
    SELECT pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe
      FROM push_message_move 
			WHERE location = 8;
  
	REPLACE INTO push_message_09(pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe) 
    SELECT pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe
      FROM push_message_move 
			WHERE location = 9;


	REPLACE INTO user_sys_message_00(msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url)
    SELECT msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url
			FROM user_sys_message_move
			WHERE location = 0;

	REPLACE INTO user_sys_message_01(msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url)
    SELECT msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url
			FROM user_sys_message_move
			WHERE location = 1;

	REPLACE INTO user_sys_message_02(msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url)
    SELECT msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url
			FROM user_sys_message_move
			WHERE location = 2;

	REPLACE INTO user_sys_message_03(msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url)
    SELECT msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url
			FROM user_sys_message_move
			WHERE location = 3;

	REPLACE INTO user_sys_message_04(msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url)
    SELECT msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url
			FROM user_sys_message_move
			WHERE location = 4;

	REPLACE INTO user_sys_message_05(msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url)
    SELECT msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url
			FROM user_sys_message_move
			WHERE location = 5;

	REPLACE INTO user_sys_message_06(msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url)
    SELECT msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url
			FROM user_sys_message_move
			WHERE location = 6;

	REPLACE INTO user_sys_message_07(msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url)
    SELECT msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url
			FROM user_sys_message_move
			WHERE location = 7;

	REPLACE INTO user_sys_message_08(msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url)
    SELECT msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url
			FROM user_sys_message_move
			WHERE location = 8;

	REPLACE INTO user_sys_message_09(msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url)
    SELECT msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, crtdate, url
			FROM user_sys_message_move
			WHERE location = 9;

  UPDATE move_message_log SET endtime = NOW() WHERE ID = @ID;
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`zgyey_20`@`%` PROCEDURE `pmid_receivedate_to_history`(IN `_date` datetime)
    SQL SECURITY INVOKER
BEGIN
	#Routine body goes here...
	INSERT INTO pmid_receivedate_history(pmid, status, receivedate)
		SELECT pmid, status, receivedate
			FROM pmid_receivedate
			WHERE receivedate < _date;

	DELETE FROM pmid_receivedate WHERE receivedate < _date;

	SELECT 1;

END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`zgyey_20`@`%` PROCEDURE `pmid_senddate_to_history`(IN `_date` datetime)
    SQL SECURITY INVOKER
BEGIN
	#Routine body goes here...
	INSERT INTO pmid_senddate_history(pmid, status, senddate)
		SELECT pmid, status, senddate
			FROM pmid_senddate
			WHERE senddate < _date;

	DELETE FROM pmid_senddate WHERE senddate < _date;

	SELECT 1;

END$$
DELIMITER ;


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
			SELECT MAX(pmid) INTO @pmidend FROM push_message WHERE pipe <> 99;
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
				Where a.userid = b.userid and a.adddate < @exectime and a.`status` = 0 and a.deletetag = 1 and b.device_user_id <> '' and a.pipe <> 99;

		IF FOUND_ROWS() = 0 THEN
			UPDATE send_record SET send = 1 WHERE ID = @ID;
		END IF;

		UPDATE send_record SET getuigetdate = CURRENT_TIMESTAMP WHERE ID = @ID;
		REPLACE INTO pmid_gettui(UUID, pmid) SELECT @uuid, pmid FROM tmp_table;
	END IF;

	SELECT * FROM tmp_table;
	SELECT @uuid uuid;

	DROP TEMPORARY TABLE IF EXISTS tmp_table;

  IF NOT EXISTS(SELECT * FROM runningcheck WHERE pipe = 0) THEN
		INSERT INTO runningcheck(pipe, lastrun) VALUES(0, NOW());
	ELSE
    UPDATE runningcheck SET lastrun = NOW() WHERE pipe = 0;
  END IF;
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`zgyey_20`@`%` PROCEDURE `push_message_send_99`(IN `_pipe` int)
BEGIN
	SET @ID = NULL, @pmidbegin = NULL, @pmidend = NULL, @msgidbegin = NULL, @msgidend = NULL, @uuid = NULL, @send = NULL;
	
	DROP TEMPORARY TABLE IF EXISTS tmp_table;
	CREATE TEMPORARY TABLE tmp_table (publicid INT, msgtype Int, title VARCHAR(2000), content VARCHAR(2000), author VARCHAR(50), file_url VARCHAR(2000), 
																		url VARCHAR(2000), channel_id Varchar(50), device_user_id VARCHAR(100), userid BIGINT, adddate VARCHAR(50), pmid BIGINT, 
																		file_desc VARCHAR(2000), pcid BIGINT, pmtype INT, action INT, shareable INT, contenturl VARCHAR(2000), 
																		msgcount INT, typeid int, optag INT, relationship INT, pipe INT);

	IF 6 < HOUR(now()) AND HOUR(now()) < 23 THEN

		SELECT ID, pmidbegin, pmidend, msgidbegin, msgidend, UUID, send, exectime INTO @ID, @pmidbegin, @pmidend, @msgidbegin, @msgidend, @uuid, @send, @exectime 
			FROM send_record_99 ORDER BY ID DESC LIMIT 1;

		IF ISNULL(@ID) OR NULLIF(@send, 0) THEN
			SET @pmidbegin = @pmidend, @msgidbegin = @msgidend, @uuid = UUID(), @exectime = NOW();
			SELECT MAX(pmid) INTO @pmidend FROM push_message WHERE pipe = 99;
			SELECT MAX(msgid) INTO @msgidend FROM user_sys_message;
			
			IF IFNULL(@pmidbegin, 0) <> IFNULL(@pmidend, 0) Or IFNULL(@msgidbegin, 0) <> IFNULL(@msgidend, 0) THEN
				INSERT INTO send_record_99(exectime, pmidbegin, pmidend, msgidbegin, msgidend, UUID, send) 
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
				Where a.userid = b.userid and a.adddate < @exectime and a.`status` = 0 and a.deletetag = 1 and b.device_user_id <> '' and a.pipe = 99;

		IF FOUND_ROWS() = 0 THEN
			UPDATE send_record_99 SET send = 1 WHERE ID = @ID;
		END IF;

		UPDATE send_record_99 SET getuigetdate = CURRENT_TIMESTAMP WHERE ID = @ID;
		REPLACE INTO pmid_gettui(UUID, pmid) SELECT @uuid, pmid FROM tmp_table;
	END IF;

	SELECT * FROM tmp_table;
	SELECT @uuid uuid;

	DROP TEMPORARY TABLE IF EXISTS tmp_table;

  IF NOT EXISTS(SELECT * FROM runningcheck WHERE pipe = 99) THEN
		INSERT INTO runningcheck(pipe, lastrun) VALUES(99, NOW());
	ELSE
    UPDATE runningcheck SET lastrun = NOW() WHERE pipe = 99;
  END IF;
END$$
DELIMITER ;


