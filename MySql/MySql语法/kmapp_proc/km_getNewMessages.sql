DELIMITER $$
CREATE DEFINER=`zgyey_20`@`%` PROCEDURE `km_getNewMessages`(IN `_uid` int,IN `_sysop` int,IN `_relationship` int)
BEGIN
	
	IF IFNULL(_uid, 0) <= 0 THEN
		SELECT -1 code, 'ÇëÇóÊ§°Ü' info;
	ELSE
		SELECT msgid pmid, Case When msgtype = 3 Then 4 Else msgtype End contenttype, action, senderid uid, userid toid, date_format(adddate, '%Y-%m-%d %H:%i:%s') date, IFNULL(content, '') content, '' contenturl  
			FROM user_message
			WHERE userid = @uid and status = 1;

		CALL km_getConversationMessages(_uid, _sysop, _relationship);

	END IF;
END$$
DELIMITER ;
