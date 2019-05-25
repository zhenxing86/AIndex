
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