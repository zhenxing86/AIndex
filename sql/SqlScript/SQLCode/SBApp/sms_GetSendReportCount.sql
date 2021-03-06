USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[sms_GetSendReportCount]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		WUZY
-- ALTER date:  2011-6-24
-- Description:	幼儿发送报表
-- =============================================
CREATE PROCEDURE [dbo].[sms_GetSendReportCount] 
	@sd nvarchar(30),
	@end nvarchar(30),
	@Cid int,
	@Kid int,
	@status int
AS
BEGIN
	SET NOCOUNT ON;
	declare @count int
	
	DECLARE @statustmptable TABLE
	(
		--定义临时表
		row int IDENTITY (1, 1),
		[status] int
	)	
	if(@status=0)--没有发送
	begin
		insert into @statustmptable([status]) values(0)
		insert into @statustmptable([status]) values(2)
		insert into @statustmptable([status]) values(5)
		insert into @statustmptable([status]) values(7)
		insert into @statustmptable([status]) values(10)
	end	
	else if(@status=1)--已发送
	begin
		insert into @statustmptable([status]) values(1)
		insert into @statustmptable([status]) values(6)
		insert into @statustmptable([status]) values(9)
	end
	else if(@status=2)--待发送
	begin
		insert into @statustmptable([status]) values(3)
		insert into @statustmptable([status]) values(8)
	end

	if(@status=3)
	begin
	--定时发送
		if(@Cid=0)
		begin
			SELECT	@count=count(1)
			FROM sms..sms_message_temp t1 inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
				
			WHERE t1.kid=@kid and t1.sendtime between @sd and @end and (t1.status=0 or t1.status=5 or t1.status=8)  and t2.usertype=0 
		end
		else
		begin
			SELECT	@count=count(1)
			FROM sms..sms_message_temp t1 inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
				inner join BasicData.dbo.user_class t3 on t2.userid=t3.userid
			WHERE t1.kid=@kid and t1.cid=@cid and t1.sendtime between @sd and @end and (t1.status=0 or t1.status=5 or t1.status=8) and t3.cid=@cid and t2.usertype=0
		end	
	end
	else if(@status=-1)
	begin
	--待审核
		if(@Cid=0)
		begin
			SELECT	@count=count(1)
			FROM sms..sms_message t1 inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
				
			WHERE t1.kid=@kid and t1.sendtime between @sd and @end and t1.status=-1 and t2.kid=@kid and t2.usertype=0
			
		
		end
		else
		begin
			SELECT	@count=count(1)
			FROM sms..sms_message t1 inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
				inner join BasicData.dbo.user_class t3 on t2.userid=t3.userid
			WHERE t1.kid=@kid and t1.cid=@cid and t1.sendtime between @sd and @end and t1.status=-1 and t3.cid=@cid and t2.usertype=0
			
		end	
	end
	
	
	else
	begin
		if(@Cid=0)
		begin
			SELECT	@count=count(1)
			FROM sms..[sms_message_curmonth] t1 inner join @statustmptable t4 on t1.status=t4.status
			inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
			
			WHERE t1.kid=@kid and t1.sendtime between @sd and @end and t2.kid=@kid and t2.usertype=0
		end
		else
		begin
			SELECT	@count=count(1)
			FROM sms..[sms_message_curmonth] t1 inner join @statustmptable t4 on t1.status=t4.status
			inner join BasicData.dbo.[user] t2 on t1.recuserid=t2.userid
			inner join BasicData.dbo.user_class t3 on t2.userid=t3.userid 
			WHERE t1.kid=@kid and t1.cid=@cid and t1.sendtime between @sd and @end and t3.cid=@cid and t2.usertype=0
		end	
	end
	return @count
END

GO
