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
