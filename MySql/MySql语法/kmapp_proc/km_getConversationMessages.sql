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
														Where userid = ', _uid, ' and status <> 2 and adddate < NOW() and action <> 8;  ');

		PREPARE stmt FROM @sqlcmd;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
	END IF;

END$$
DELIMITER ;
