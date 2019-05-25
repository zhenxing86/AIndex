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
