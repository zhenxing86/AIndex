USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[class_GetChildListByGrade]    Script Date: 05/14/2013 14:52:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取发短信年级幼儿数
--项目名称：SMS
--说明：
--时间：2011-6-21 9:54:31
------------------------------------
alter PROCEDURE [dbo].[class_GetChildListByGrade]
@kid int,
@grade int
AS
	DECLARE @isvipcontrol INT
	SELECT @isvipcontrol=isvipcontrol FROM KWebCMS.dbo.site_config WHERE siteid=@kid
	IF(@isvipcontrol=0 or @isvipcontrol is null)
	BEGIN
			 select t4.vipstatus,t1.userid,t1.name,t1.mobile
			 From BasicData.dbo.[user] t1
			 inner join BasicData.dbo.user_class t3 on t1.userid=t3.userid
			 inner join BasicData.dbo.class t5 on t3.cid=t5.cid
			 inner join BasicData.dbo.child t4 on t1.userid=t4.userid			 
			 where t5.grade=@grade and t5.deletetag=1 and t5.iscurrent=1 and t1.deletetag=1 and t1.mobile is not null and len(t1.mobile) between 11 and 12
			 and t5.kid=@kid 
	END
	ELSE
	BEGIN
			 select t4.vipstatus,t1.userid,t1.name,t1.mobile From BasicData.dbo.[user] t1
			 inner join BasicData.dbo.user_class t3 on t1.userid=t3.userid
			 inner join BasicData.dbo.class t5 on t3.cid=t5.cid
			 inner join BasicData.dbo.child t4 on t1.userid=t4.userid
			where t5.grade=@grade and t5.deletetag=1 and t5.iscurrent=1 and t1.deletetag=1 and t1.mobile is not null and len(t1.mobile) between 11 and 12
			 and t5.kid=@kid and t4.VIPStatus=1
	END
GO
