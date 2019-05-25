USE BasicData 
GO
CREATE VIEW FriendSMS_v WITH SCHEMABINDING
AS
	SELECT	Userid, Touserid, count_big(*) as cnt   
		FROM DBO.FriendSMS
		WHERE IsRead = 0
		GROUP BY Userid, Touserid
			 
GO
CREATE UNIQUE CLUSTERED INDEX idx_userid ON dbo.FriendSMS_v(Userid, Touserid);