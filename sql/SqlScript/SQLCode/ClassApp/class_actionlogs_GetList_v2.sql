USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_actionlogs_GetList_v2]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取最新动态
--项目名称：classhomepage
--说明：
--时间：2008-09-28 22:56:46
------------------------------------
CREATE PROCEDURE [dbo].[class_actionlogs_GetList_v2]
@classid int,
@kid int
 AS
 
 exec [class_actionlogs_GetList] @classid

	--IF object_id('tempdb.dbo.#sys_actionlogsid') is not null
 --   drop table #sys_actionlogsid

	--IF object_id('tempdb.dbo.#actionlogs') is not null
 --   drop table #actionlogs

	--CREATE TABLE #sys_actionlogsid(id int)	

	--CREATE TABLE #actionlogs
	--(	actionuserid int,
	--	actionusername nvarchar(30),
	--	actiondescription nvarchar(200),
	--	actiondatetime datetime,
	--	actiontype int,
	--	headpic nvarchar(100),
	--	headpicupdate datetime
	--)

	--IF EXISTS(SELECT 1 FROM blogapp.dbo.permissionsetting WHERE kid=@kid and ptype=14)
	--BEGIN
	--	INSERT INTO #actionlogs(actionuserid,actionusername,actiondescription,actiondatetime,actiontype,headpic,headpicupdate)

	--	SELECT top(30) t1.actionuserid,t1.actionusername,t1.actiondesc,t1.actiondatetime,t1.actiontypeid,t1.headpic,t1.headpicupdate
	--	FROM  AppLogs.dbo.class_new_actionlogs t1  
 --       WHERE  t1.classid=@classid order by actiondatetime desc
	--END
	--ELSE
	--BEGIN
	
	--	INSERT INTO #actionlogs(actionuserid,actionusername,actiondescription,actiondatetime,actiontype,headpic,headpicupdate)
	--SELECT top(30) t1.actionuserid,t1.actionusername,t1.actiondesc,t1.actiondatetime,t1.actiontypeid,t1.headpic,t1.headpicupdate
	--	FROM  AppLogs.dbo.class_new_actionlogs t1  
 --       WHERE  t1.classid=@classid order by actiondatetime desc
	--END

	--SELECT TOP(30) actionuserid,actionusername,actiondescription,actiondatetime,actiontype,headpic,headpicupdate FROM #actionlogs ORDER BY actiondatetime DESC
	--drop table #sys_actionlogsid
	--drop table #actionlogs

GO
