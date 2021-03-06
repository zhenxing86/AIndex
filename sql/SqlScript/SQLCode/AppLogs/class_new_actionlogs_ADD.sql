USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[class_new_actionlogs_ADD]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		wuzy
-- Create date: 2011-04-27
-- Description:	班级主页日志导入
-- =============================================
CREATE PROCEDURE [dbo].[class_new_actionlogs_ADD]
AS
	declare @datetime datetime
	select @datetime=actiondatetime FROM sync_datetime where tablename='class_new_actionlogs'
	INSERT INTO class_new_actionlogs(actionuserid,actionusername,actiondesc,actiondatetime,actiontypeid,classid,headpic,headpicupdate)
	SELECT  t1.actionuserid,t1.actionusername,t1.actiondesc,t1.actiondatetime,t1.actiontypeid,t1.classid,t2.headpic,t2.headpicupdate
	FROM class_log t1 
	LEFT JOIN BasicData.dbo.[user] t2 ON t1.actionuserid=t2.userid         
    WHERE  t1.classid>0 and t1.actionuserid>0 and t1.actiondatetime between @datetime and getdate()
	UPDATE sync_datetime SET actiondatetime=getdate() where tablename='class_new_actionlogs'

GO
