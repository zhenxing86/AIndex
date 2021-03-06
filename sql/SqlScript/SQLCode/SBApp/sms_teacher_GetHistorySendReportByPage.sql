USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[sms_teacher_GetHistorySendReportByPage]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** 对象:  StoredProcedure [dbo].[sms_GetStafferSendCountReport]    脚本日期: 08/06/2011 12:50:53 ******/
-- =============================================
-- Author:		WUZY
-- ALTER date:  2011-6-24
-- Description:	老师发送报表
-- =============================================
CREATE PROCEDURE [dbo].[sms_teacher_GetHistorySendReportByPage] 
	@sd nvarchar(30),
	@end nvarchar(30),
	@did int,
	@Kid int,
	@page int,
	@size int
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @prep int,@ignore int

	SET @prep = @size * @page
	SET @ignore=@prep - @size

	DECLARE @tmptable TABLE
	(
		--定义临时表
		row int IDENTITY (1, 1),
		tmptableid bigint
	)	

		if(@did=0)
		begin
			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			SELECT	smsid
			FROM SMS_2013..sms_message_03 t1 inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid 
			inner join BasicData.dbo.teacher t4 on t2.userid=t4.userid
			WHERE t1.kid=@kid and t1.sendtime between @sd and @end and t2.kid=@kid 
			ORDER BY sendtime DESC
		end
		else
		begin
			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			SELECT	smsid
			FROM SMS_2013..sms_message_03 t1 inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid 
			inner join BasicData.dbo.teacher t4 on t2.userid=t4.userid 
			WHERE t1.kid=@kid and t1.sendtime between @sd and @end and t2.kid=@kid and t4.did=@did
			ORDER BY sendtime DESC
		end	
		
		SET ROWCOUNT @size
		select t3.name as sendername, t1.recmobile,t1.content,t2.name as recusername,t1.sendtime
		From @tmptable as tmptable
		inner join SMS_2013..sms_message_03 t1 on tmptable.tmptableid = t1.smsid
		inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
		left join BasicData.dbo.[user] t3 on t3.userid=t1.sender
		WHERE row > @ignore	ORDER BY t1.sendtime DESC

END

GO
