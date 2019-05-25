DELIMITER $$
CREATE DEFINER=`zgyey_20`@`%` PROCEDURE `move_message`()
BEGIN
	
	INSERT INTO move_message_log(begintime) VALUES (NOW());
	SET @ID = LAST_INSERT_ID();

  SET @pmidend = NULL, @msgidend = NULL;
	SELECT pmidbegin, pmidend, msgidbegin, msgidend, exectime INTO @pmidbegin, @pmidend, @msgidbegin, @msgidend, @exectime FROM send_record WHERE send = 1 ORDER BY ID DESC LIMIT 1;

	REPLACE INTO user_sys_message_move(msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, url, crtdate, location)
		SELECT msgid, userid, msgtype, content, status, adddate, receivedate, action, senddate, title, url, crtdate, location
      FROM user_sys_message
			WHERE msgid <= @msgidend and adddate < @exectime;

	DELETE a FROM user_sys_message a WHERE msgid <= @msgidend and EXISTS (SELECT * FROM user_sys_message_move b WHERE a.msgid = b.msgid);

	REPLACE INTO push_message_move(pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe, location) 
    SELECT pmid, userid, publicid, pcid, msgtype, status, action, adddate, receivedate, deletetag, pctype, senddate, title, content, url, file_url, typeid, optag, pipe, location
      FROM push_message 
			WHERE pmid <= @pmidend and adddate < @exectime;

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
