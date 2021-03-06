USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetSMSSendList]    Script Date: 06/15/2013 15:17:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取短信发送列表
--项目名称：manage
--说明：
--时间：2009-6-17 11:40:19
------------------------------------ 
alter PROCEDURE [dbo].[Manage_GetSMSSendList]
@strwhere nvarchar(300)
AS

SET @strwhere = CommonFun.dbo.FilterSQLInjection(@strwhere)

	DECLARE @strSQL  nvarchar(4000)
	SET @strSQL='select t2.cname as classname,t3.nickname as sendername, t1.recmobile,t1.content,
	t4.nickname as recusername,t1.sendtime,t1.status 
	From sms.dbo.sms_message t1 
	left JOIN basicdata.dbo.class t2 on t1.cid=t2.cid
	left join basicdata.dbo.user_baseinfo t3 on t3.userid=t1.sender
	left join basicdata.dbo.user_baseinfo t4 on t1.recuserid=t4.userid ' +@strwhere
	EXEC (@strSQL)
GO
