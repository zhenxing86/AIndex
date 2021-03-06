USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[sms_GetHistorySendReportByPage]    Script Date: 05/14/2013 14:52:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		WUZY
-- ALTER date:  2011-6-24
-- Description:	幼儿发送报表
-- =============================================
alter PROCEDURE [dbo].[sms_GetHistorySendReportByPage] 
	@sd nvarchar(30),
	@end nvarchar(30),
	@Cid int,
	@Kid int,
	@page int,
	@size int
AS
BEGIN
	SET NOCOUNT ON;
--	DECLARE @iscz int
--	SELECT @iscz=[dbo].[IsSyncKindergarten](@Kid)	
			
	DECLARE @prep int,@ignore int

	SET @prep = @size * @page
	SET @ignore=@prep - @size

	DECLARE @tmptable TABLE
	(
		--定义临时表
		row int IDENTITY (1, 1),
		tmptableid bigint
	)

	if(@Cid=0)
	begin
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
		SELECT	smsid
		FROM SMS_2013..sms_message_03 t1 inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
		WHERE t1.kid=@kid and t1.sendtime between @sd and @end and t2.kid=@kid  and t2.usertype=0
		ORDER BY sendtime DESC
	end
	else
	begin
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
		SELECT	smsid
		FROM SMS_2013..sms_message_03 t1 inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
		inner join  BasicData.dbo.user_class t3 on t2.userid=t3.userid
		WHERE t1.kid=@kid and t1.cid=@cid and t1.sendtime between @sd and @end and t3.cid=@cid and usertype=0
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
