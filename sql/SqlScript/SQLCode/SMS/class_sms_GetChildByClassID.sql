USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[class_sms_GetChildByClassID]    Script Date: 05/14/2013 14:52:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取发送短信的幼儿对象
--项目名称：ClassHomePage
--说明：
--时间：2009-4-15 14:50:29
------------------------------------
ALTER PROCEDURE [dbo].[class_sms_GetChildByClassID] 
@classid int,
@kid int
AS
	DECLARE @isvipcontrol INT
	SELECT @isvipcontrol=isvipcontrol FROM KWebCMS.dbo.site_config WHERE siteid=@kid
	IF(@isvipcontrol=0 or @isvipcontrol is null)
	BEGIN
		IF(@classid!=-1)
		BEGIN
			select t3.vipstatus,t1.userid,t1.name,t1.mobile From BasicData.dbo.[user] t1 
			INNER JOIN BasicData.dbo.child t3 on t1.userid=t3.userid
			INNER JOIN BasicData.dbo.user_class t4 on t3.userid=t4.userid
			
			where t1.deletetag=1 and t1.mobile is not null and commonfun.dbo.fn_cellphone(t1.mobile) = 1 and t4.cid=@classid
			order by t1.name desc 
		END
		ELSE
		BEGIN
			select t3.vipstatus,t1.userid,t1.name,t1.mobile From BasicData.dbo.[user] t1 
			INNER JOIN BasicData.dbo.child t3 on t1.userid=t3.userid
			INNER JOIN BasicData.dbo.user_class t4 on t3.userid=t4.userid
			INNER JOIN BasicData.dbo.class t6 on t4.cid=t6.cid
			
			where t6.grade <> 38 and t1.deletetag=1 and t1.mobile is not null and commonfun.dbo.fn_cellphone(t1.mobile) = 1
			 and t1.kid=@kid
			order by t6.cid 
		END

	END
	ELSE
	BEGIN
		IF(@classid!=-1)
		BEGIN
			select t3.vipstatus,t1.userid,t1.name,t1.mobile From BasicData.dbo.[user] t1 
			INNER JOIN BasicData.dbo.child t3 on t1.userid=t3.userid
			INNER JOIN BasicData.dbo.user_class t4 on t3.userid=t4.userid
			inner join ossapp..addservice t5 
				on t5.[uid]=t1.userid
					and t5.deletetag=1
					and t5.describe='开通'
					and t5.a2='801'
					and t5.kid=t1.kid
			where t1.deletetag=1 and t1.mobile is not null and commonfun.dbo.fn_cellphone(t1.mobile) = 1
			and t4.cid=@classid and t3.vipstatus=1
			order by t1.name desc  
		END
		ELSE
		BEGIN
			select t3.vipstatus,t1.userid,t1.name,t1.mobile From BasicData.dbo.[user] t1
			INNER JOIN BasicData.dbo.child t3 on t1.userid=t3.userid
			INNER JOIN BasicData.dbo.user_class t4 on t3.userid=t4.userid
			INNER JOIN BasicData.dbo.class t6 on t4.cid=t6.cid
			inner join ossapp..addservice t5 
				on t5.[uid]=t1.userid
					and t5.deletetag=1
					and t5.describe='开通'
					and t5.a2='801'
					and t5.kid=t1.kid
			where t6.grade <> 38 and t1.deletetag=1 and t1.mobile is not null and commonfun.dbo.fn_cellphone(t1.mobile) = 1
			 and t1.kid=@kid and t3.vipstatus=1
			order by t6.cid 
		END
	END
GO
