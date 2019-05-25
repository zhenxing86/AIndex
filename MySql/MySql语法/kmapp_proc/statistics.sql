DELIMITER $$
CREATE DEFINER=`zgyey_20`@`%` PROCEDURE `statistics`()
BEGIN
	#Routine body goes here...

	DECLARE _mid BIGINT;
  DECLARE _adddate datetime;

	INSERT INTO statistics_runlog(begintime) VALUES (NOW());
	SET @ID = LAST_INSERT_ID();

	SELECT MAX(ID) INTO _mid FROM msg_pmid;

	REPLACE INTO msg_statistics(pmid, pcid, crtdate, adddate, mysqldate)
    SELECT pmid, pcid, crtdate, adddate, mysqldate
      FROM msg_pmid
			WHERE ID <= _mid;
  
  DELETE FROM msg_pmid WHERE ID <= _mid;
	

	UPDATE msg_statistics a, kmapp_00.pmid_gettui b, kmapp_00.send_record c SET a.channel = '个推', a.getuigetdate = c.exectime
		WHERE a.pmid = b.pmid and b.uuid = c.uuid and c.send = 1;

	UPDATE msg_statistics a, kmapp_01.pmid_gettui b, kmapp_01.send_record c SET a.channel = '个推', a.getuigetdate = c.exectime
		WHERE a.pmid = b.pmid and b.uuid = c.uuid and c.send = 1;

	UPDATE msg_statistics a, kmapp_02.pmid_gettui b, kmapp_02.send_record c SET a.channel = '个推', a.getuigetdate = c.exectime
		WHERE a.pmid = b.pmid and b.uuid = c.uuid and c.send = 1;

	UPDATE msg_statistics a, kmapp_03.pmid_gettui b, kmapp_03.send_record c SET a.channel = '个推', a.getuigetdate = c.exectime
		WHERE a.pmid = b.pmid and b.uuid = c.uuid and c.send = 1;

	UPDATE msg_statistics a, kmapp_04.pmid_gettui b, kmapp_04.send_record c SET a.channel = '个推', a.getuigetdate = c.exectime
		WHERE a.pmid = b.pmid and b.uuid = c.uuid and c.send = 1;

	UPDATE msg_statistics a, kmapp_05.pmid_gettui b, kmapp_05.send_record c SET a.channel = '个推', a.getuigetdate = c.exectime
		WHERE a.pmid = b.pmid and b.uuid = c.uuid and c.send = 1;

	UPDATE msg_statistics a, kmapp_06.pmid_gettui b, kmapp_06.send_record c SET a.channel = '个推', a.getuigetdate = c.exectime
		WHERE a.pmid = b.pmid and b.uuid = c.uuid and c.send = 1;

	UPDATE msg_statistics a, kmapp_07.pmid_gettui b, kmapp_07.send_record c SET a.channel = '个推', a.getuigetdate = c.exectime
		WHERE a.pmid = b.pmid and b.uuid = c.uuid and c.send = 1;

	UPDATE msg_statistics a, kmapp_08.pmid_gettui b, kmapp_08.send_record c SET a.channel = '个推', a.getuigetdate = c.exectime
		WHERE a.pmid = b.pmid and b.uuid = c.uuid and c.send = 1;

	UPDATE msg_statistics a, kmapp_09.pmid_gettui b, kmapp_09.send_record c SET a.channel = '个推', a.getuigetdate = c.exectime
		WHERE a.pmid = b.pmid and b.uuid = c.uuid and c.send = 1;


	UPDATE msg_statistics a, (SELECT * FROM kmapp_00.push_log ORDER BY pmid, CASE WHEN state = 1 THEN 3 WHEN state = 2 THEN 2 ELSE 1 END) b 
		SET a.getuidate = b.intime, a.getuistatus = b.state
    WHERE a.pmid = b.pmid;

	UPDATE msg_statistics a, (SELECT * FROM kmapp_01.push_log ORDER BY pmid, CASE WHEN state = 1 THEN 3 WHEN state = 2 THEN 2 ELSE 1 END) b 
		SET a.getuidate = b.intime, a.getuistatus = b.state
    WHERE a.pmid = b.pmid;

	UPDATE msg_statistics a, (SELECT * FROM kmapp_02.push_log ORDER BY pmid, CASE WHEN state = 1 THEN 3 WHEN state = 2 THEN 2 ELSE 1 END) b 
		SET a.getuidate = b.intime, a.getuistatus = b.state
    WHERE a.pmid = b.pmid;

	UPDATE msg_statistics a, (SELECT * FROM kmapp_03.push_log ORDER BY pmid, CASE WHEN state = 1 THEN 3 WHEN state = 2 THEN 2 ELSE 1 END) b 
		SET a.getuidate = b.intime, a.getuistatus = b.state
    WHERE a.pmid = b.pmid;

	UPDATE msg_statistics a, (SELECT * FROM kmapp_04.push_log ORDER BY pmid, CASE WHEN state = 1 THEN 3 WHEN state = 2 THEN 2 ELSE 1 END) b 
		SET a.getuidate = b.intime, a.getuistatus = b.state
    WHERE a.pmid = b.pmid;

	UPDATE msg_statistics a, (SELECT * FROM kmapp_05.push_log ORDER BY pmid, CASE WHEN state = 1 THEN 3 WHEN state = 2 THEN 2 ELSE 1 END) b 
		SET a.getuidate = b.intime, a.getuistatus = b.state
    WHERE a.pmid = b.pmid;

	UPDATE msg_statistics a, (SELECT * FROM kmapp_06.push_log ORDER BY pmid, CASE WHEN state = 1 THEN 3 WHEN state = 2 THEN 2 ELSE 1 END) b 
		SET a.getuidate = b.intime, a.getuistatus = b.state
    WHERE a.pmid = b.pmid;

	UPDATE msg_statistics a, (SELECT * FROM kmapp_07.push_log ORDER BY pmid, CASE WHEN state = 1 THEN 3 WHEN state = 2 THEN 2 ELSE 1 END) b 
		SET a.getuidate = b.intime, a.getuistatus = b.state
    WHERE a.pmid = b.pmid;

	UPDATE msg_statistics a, (SELECT * FROM kmapp_08.push_log ORDER BY pmid, CASE WHEN state = 1 THEN 3 WHEN state = 2 THEN 2 ELSE 1 END) b 
		SET a.getuidate = b.intime, a.getuistatus = b.state
    WHERE a.pmid = b.pmid;

	UPDATE msg_statistics a, (SELECT * FROM kmapp_09.push_log ORDER BY pmid, CASE WHEN state = 1 THEN 3 WHEN state = 2 THEN 2 ELSE 1 END) b 
		SET a.getuidate = b.intime, a.getuistatus = b.state
    WHERE a.pmid = b.pmid;

/*
	SELECT MAX(adddate) INTO _adddate FROM kmapp_00.pmid_receivedate;
	UPDATE msg_statistics a, kmapp_00.pmid_receivedate b SET a.receivedate = b.receivedate
		WHERE a.pmid = b.pmid and b.adddate <= _adddate;
  DELETE FROM kmapp_00.pmid_receivedate Where adddate <= _adddate;

  SELECT MAX(adddate) INTO _adddate FROM kmapp_01.pmid_receivedate;
	UPDATE msg_statistics a, kmapp_01.pmid_receivedate b SET a.receivedate = b.receivedate
		WHERE a.pmid = b.pmid and b.adddate <= _adddate;
  DELETE FROM kmapp_01.pmid_receivedate Where adddate <= _adddate;

  SELECT MAX(adddate) INTO _adddate FROM kmapp_02.pmid_receivedate;
	UPDATE msg_statistics a, kmapp_02.pmid_receivedate b SET a.receivedate = b.receivedate
		WHERE a.pmid = b.pmid and b.adddate <= _adddate;
  DELETE FROM kmapp_02.pmid_receivedate Where adddate <= _adddate;

  SELECT MAX(adddate) INTO _adddate FROM kmapp_03.pmid_receivedate;
	UPDATE msg_statistics a, kmapp_03.pmid_receivedate b SET a.receivedate = b.receivedate
		WHERE a.pmid = b.pmid and b.adddate <= _adddate;
  DELETE FROM kmapp_03.pmid_receivedate Where adddate <= _adddate;

  SELECT MAX(adddate) INTO _adddate FROM kmapp_04.pmid_receivedate;
	UPDATE msg_statistics a, kmapp_04.pmid_receivedate b SET a.receivedate = b.receivedate
		WHERE a.pmid = b.pmid and b.adddate <= _adddate;
  DELETE FROM kmapp_04.pmid_receivedate Where adddate <= _adddate;

  SELECT MAX(adddate) INTO _adddate FROM kmapp_05.pmid_receivedate;
	UPDATE msg_statistics a, kmapp_05.pmid_receivedate b SET a.receivedate = b.receivedate
		WHERE a.pmid = b.pmid and b.adddate <= _adddate;
  DELETE FROM kmapp_05.pmid_receivedate Where adddate <= _adddate;

  SELECT MAX(adddate) INTO _adddate FROM kmapp_06.pmid_receivedate;
	UPDATE msg_statistics a, kmapp_06.pmid_receivedate b SET a.receivedate = b.receivedate
		WHERE a.pmid = b.pmid and b.adddate <= _adddate;
  DELETE FROM kmapp_06.pmid_receivedate Where adddate <= _adddate;

  SELECT MAX(adddate) INTO _adddate FROM kmapp_07.pmid_receivedate;
	UPDATE msg_statistics a, kmapp_07.pmid_receivedate b SET a.receivedate = b.receivedate
		WHERE a.pmid = b.pmid and b.adddate <= _adddate;
  DELETE FROM kmapp_07.pmid_receivedate Where adddate <= _adddate;

  SELECT MAX(adddate) INTO _adddate FROM kmapp_08.pmid_receivedate;
	UPDATE msg_statistics a, kmapp_08.pmid_receivedate b SET a.receivedate = b.receivedate
		WHERE a.pmid = b.pmid and b.adddate <= _adddate;
  DELETE FROM kmapp_08.pmid_receivedate Where adddate <= _adddate;

  SELECT MAX(adddate) INTO _adddate FROM kmapp_09.pmid_receivedate;
	UPDATE msg_statistics a, kmapp_09.pmid_receivedate b SET a.receivedate = b.receivedate
		WHERE a.pmid = b.pmid and b.adddate <= _adddate;
  DELETE FROM kmapp_09.pmid_receivedate Where adddate <= _adddate;
*/
	UPDATE statistics_runlog SET endtime = NOW() WHERE ID = @ID;
END$$
DELIMITER ;
