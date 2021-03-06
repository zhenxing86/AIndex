USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[class_GetChildCountByClass]    Script Date: 05/14/2013 14:52:41 ******/
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
alter PROCEDURE [dbo].[class_GetChildCountByClass]
@kid int,
@classid int
AS
	DECLARE @count int
	DECLARE @isvipcontrol INT
	SELECT @isvipcontrol=isvipcontrol FROM KWebCMS.dbo.site_config WHERE siteid=@kid
	IF(@isvipcontrol=0 or @isvipcontrol is null)
	BEGIN
			 select @count=count(1) From BasicData.dbo.[user] t1
			 left join BasicData.dbo.user_class t3 on t1.userid=t3.userid
			 left join BasicData.dbo.child t4 on t1.userid=t4.userid	
			 where t1.deletetag=1  and t1.mobile is not null and len(t1.mobile) =11
			 and t3.cid=@classid
	END
	ELSE
	BEGIN
			 select @count=count(1) From BasicData.dbo.[user] t1
			 left join BasicData.dbo.user_class t3 on t1.userid=t3.userid
			 left join BasicData.dbo.child t4 on t1.userid=t4.userid	
			where t1.deletetag=1 and t1.mobile is not null and len(t1.mobile) =11
			 and t3.cid=@classid and t4.VIPStatus=1
	END
	RETURN @count
GO
