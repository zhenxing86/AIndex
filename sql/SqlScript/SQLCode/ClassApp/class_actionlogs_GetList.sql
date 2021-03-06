USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_actionlogs_GetList]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取最新动态
--项目名称：classhomepage
--说明：[class_actionlogs_GetList] 46146
--时间：2008-09-28 22:56:46
------------------------------------
CREATE PROCEDURE [dbo].[class_actionlogs_GetList]
	@classid int	
 AS
		SELECT top(30) 
		t1.actionuserid,t1.actionusername,t1.actiondesc,t1.actiondatetime,
		t1.actiontypeid,u.headpic,u.headpicupdate
		FROM  AppLogs.dbo.class_log t1  left join basicdata..[user] u
		on t1.actionuserid=u.userid
        WHERE  t1.classid=@classid 
        order by actiondatetime desc


GO
