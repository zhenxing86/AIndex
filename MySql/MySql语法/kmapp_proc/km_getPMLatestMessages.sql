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
