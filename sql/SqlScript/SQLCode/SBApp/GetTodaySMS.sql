USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[GetTodaySMS]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		EXEC SMS..GetTodaySMS 295765
*/
CREATE PROC [dbo].[GetTodaySMS]
	@userid int
AS
BEGIN
	SET NOCOUNT ON
	select top(1) u.name sender, sc.content, sc.sendtime
		from sms..sms_message_curmonth sc
			left join BasicData..[user] u 
				on sc.sender = u.userid 
		where recuserid = @userid
			and sendtime >= CAST(CONVERT(VARCHAR(10),getdate(),120) AS DATETIME)
		ORDER BY sc.sendtime desc
END

GO
