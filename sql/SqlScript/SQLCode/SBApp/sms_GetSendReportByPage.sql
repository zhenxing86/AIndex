USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[sms_GetSendReportByPage]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		WUZY
-- ALTER date:  2011-6-24
-- Description:	幼儿发送报表
-- =============================================
CREATE PROCEDURE [dbo].[sms_GetSendReportByPage] 
	@sd nvarchar(30),
	@end nvarchar(30),
	@Cid int,
	@Kid int,
	@status int,
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
		tmptableid bigint,
		sendtime datetime,
		istemp int
	)	
	DECLARE @statustmptable TABLE
	(
		--定义临时表
		row int IDENTITY (1, 1),
		[status] int
	)	
	if(@status=0)
	begin
		insert into @statustmptable([status]) values(0)
		insert into @statustmptable([status]) values(2)
		insert into @statustmptable([status]) values(5)
		insert into @statustmptable([status]) values(7)
		insert into @statustmptable([status]) values(10)
	end	
	else if(@status=1)
	begin
		insert into @statustmptable([status]) values(1)
		insert into @statustmptable([status]) values(6)
		insert into @statustmptable([status]) values(9)
	end
	else if(@status=2)
	begin
		insert into @statustmptable([status]) values(3)
		insert into @statustmptable([status]) values(8)
	end
	

	if(@status=3)
	begin
	--定时发送
		if(@Cid=0)
		begin


			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			SELECT	smsid
			FROM sms..sms_message_temp t1 inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
			WHERE t1.kid=@kid and t1.sendtime between @sd and @end and (t1.status=0 or t1.status=5 or t1.status=8)  and t2.usertype=0
			ORDER BY sendtime DESC
		end
		else
		begin
			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			SELECT	smsid
			FROM sms..sms_message_temp t1 inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
				inner join BasicData.dbo.user_class t3 on t2.userid=t3.userid
			WHERE t1.kid=@kid and t1.cid=@cid and t1.sendtime between @sd and @end and (t1.status=0 or t1.status=5 or t1.status=8)  and t3.cid=@cid  and t2.usertype=0
			ORDER BY sendtime DESC
		end		
			
		SET ROWCOUNT @size
		select t3.name as sendername, t1.recmobile,t1.content,t2.name as recusername,t1.sendtime,t1.smsid,1
		From @tmptable as tmptable
		inner join sms..sms_message_temp t1 on tmptable.tmptableid = t1.smsid
		inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
		left join BasicData.dbo.[user] t3 on t3.userid=t1.sender
		WHERE row > @ignore	ORDER BY t1.sendtime DESC
	end
	
	else if(@status=-1)--待审核
	begin

		if(@Cid=0)
		begin

			
			SET ROWCOUNT @prep
			
			INSERT INTO @tmptable(tmptableid,sendtime,istemp)
			SELECT	smsid,sendtime,0
			FROM sms..sms_message t1 
			inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
			WHERE t1.kid=@kid and t1.sendtime between @sd and @end and t2.kid=@kid 
			and t1.status=-1 and t2.usertype=0
			ORDER BY sendtime DESC
			
		end
		else
		begin
			SET ROWCOUNT @prep
			
			INSERT INTO @tmptable(tmptableid,sendtime,istemp)
			SELECT	smsid,sendtime,0
			FROM sms..sms_message t1 
			inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
			inner join BasicData.dbo.user_class t3 on t2.userid=t3.userid 
			WHERE t1.kid=@kid and t1.cid=@cid and t1.sendtime between @sd and @end and t3.cid=@cid 
			and t1.status=-1 and t2.usertype=0
			ORDER BY sendtime DESC
		end	
	
			
		SET ROWCOUNT @size
			
		select t3.name as sendername, t1.recmobile,t1.content,t2.name as recusername,t1.sendtime,t1.smsid,1
		From @tmptable as tmptable
		inner join sms..sms_message t1 on tmptable.tmptableid = t1.smsid
		inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
		left join BasicData.dbo.[user] t3 on t3.userid=t1.sender
		WHERE row > @ignore 
		
		
		ORDER BY t1.sendtime DESC
	end
	
	else--status=1
	begin
		if(@Cid=0)
		begin
			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			SELECT	smsid
			FROM sms..[sms_message_curmonth] t1 inner join @statustmptable t4 on t1.status=t4.status
			inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
			WHERE t1.kid=@kid and t1.sendtime between @sd and @end and t2.kid=@kid and t2.usertype=0
			ORDER BY sendtime DESC
		end
		else
		begin
			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			SELECT	smsid
			FROM sms..[sms_message_curmonth] t1 inner join @statustmptable t4 on t1.status=t4.status
			inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
			inner join BasicData.dbo.user_class t3 on t2.userid=t3.userid 
			WHERE t1.kid=@kid and t1.cid=@cid and t1.sendtime between @sd and @end and t3.cid=@cid and t2.usertype=0
			ORDER BY sendtime DESC
		end	
		
		SET ROWCOUNT @size
		select t3.name as sendername, t1.recmobile,t1.content,t2.name as recusername,t1.sendtime,t1.smsid,0
		From @tmptable as tmptable
		inner join sms..[sms_message_curmonth] t1 on tmptable.tmptableid = t1.smsid
		inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
		left join BasicData.dbo.[user] t3 on t3.userid=t1.sender
		WHERE row > @ignore	ORDER BY t1.sendtime DESC
	end
END

GO
