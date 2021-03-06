USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[sms_teacher_GetHistorySendReportCount]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		WUZY
-- ALTER date:  2011-6-24
-- Description:	老师发送报表
-- =============================================
CREATE PROCEDURE [dbo].[sms_teacher_GetHistorySendReportCount] 
	@sd nvarchar(30),
	@end nvarchar(30),
	@did int,
	@Kid int
AS
BEGIN
	SET NOCOUNT ON;
	declare @count int


		if(@did=0)
		begin
			SELECT	@count=count(1)
			FROM SMS_2013..sms_message_03 t1 inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
			inner join BasicData.dbo.teacher t4 on t2.userid=t4.userid
			WHERE t1.kid=@kid and t1.sendtime between @sd and @end and t2.kid=@kid  
		end
		else
		begin
			SELECT	@count=count(1)
			FROM SMS_2013..sms_message_03 t1 inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
			inner join BasicData.dbo.teacher t4 on t2.userid=t4.userid 
			WHERE t1.kid=@kid and t1.sendtime between @sd and @end and t2.kid=@kid and t4.did=@did 
		end	
	return @count
END

GO
