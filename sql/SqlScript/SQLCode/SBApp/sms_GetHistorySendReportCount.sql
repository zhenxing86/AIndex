USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[sms_GetHistorySendReportCount]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		WUZY
-- ALTER date:  2011-6-24
-- Description:	幼儿发送报表
-- =============================================
CREATE PROCEDURE [dbo].[sms_GetHistorySendReportCount] 
	@sd nvarchar(30),
	@end nvarchar(30),
	@Cid int,
	@Kid int
AS
BEGIN
	SET NOCOUNT ON;
	declare @count int		


	if(@Cid=0)
	begin
		select @count=count(1)
		FROM SMS_2013..sms_message_03 t1  inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
		 
		WHERE t1.kid=@kid and t1.sendtime between @sd and @end and t2.kid=@kid and t2.usertype=0
	end
	else
	begin
		select @count=count(1)
		FROM SMS_2013..sms_message_03 t1 inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
		inner join  BasicData.dbo.user_class t3 on t2.userid=t3.userid
		WHERE t1.kid=@kid and t1.cid=@cid and t1.sendtime between @sd and @end and t3.cid=@cid and t2.usertype=2
	end	
--	end
	return @count
END

GO
