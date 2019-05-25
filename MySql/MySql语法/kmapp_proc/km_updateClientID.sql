DELIMITER $$
CREATE DEFINER=`zgyey_20`@`%` PROCEDURE `km_updateClientID`(IN `_uid` int,IN `_clientid` varchar(100),IN `_relationship` int,IN `_sysop` int,IN `_action` int)
BEGIN
	

  IF NULLIF(_uid, 0) <= 0 THEN
    SELECT -1 code, 'ÇëÇóÊ§°Ü' info;
	ELSE
		Insert Into gtreglog(userid, device_user_id, relationship, sysop, action, gtregdate)
      Values(_uid, _clientid, _relationship, _sysop, _action, NOW());

		IF _clientid <> '' THEN
			DELETE FROM and_userinfo Where device_user_id = _clientid and userid <> _uid;
		END IF;

		IF NULLIF(_clientid, '') = '' THEN
			DELETE FROM and_userinfo WHERE userid = _uid and device_user_id = '';

		
		ELSEIF _uid in (SELECT userid From demo_account) THEN
		  DELETE FROM and_userinfo WHERE device_user_id = _clientid and NOT(userid = _uid and relationship = _relationship);

			IF EXISTS(SELECT * FROM and_userinfo Where userid	= _uid and device_user_id = _clientid and relationship = _relationship) THEN
				UPDATE and_userinfo SET intime = NOW() WHERE userid	= _uid and device_user_id = _clientid and relationship = _relationship;

			ELSE
				INSERT INTO and_userinfo(userid, device_user_id, intime, relationship)
					VALUES(_uid, _clientid, NOW(), _relationship);

			END IF;

		
		ELSE
			DELETE From and_userinfo WHERE device_user_id = _clientid and NOT(userid = _uid and relationship = _relationship);

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
