USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[class_actionlogs_new_ADD]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		wuzy
-- Create date: 2011-04-27
-- Description:	班级主页日志导入
-- =============================================
CREATE PROCEDURE [dbo].[class_actionlogs_new_ADD]
AS
	declare @datetime datetime
	select @datetime=actiondatetime FROM sync_datetime where tablename='class_actionlogs_new'
	INSERT INTO class_actionlogs_new(actionuserid,actionusername,actiondescription,actiondatetime,actionmodul,classid,headpic,headpicupdate)
	SELECT  t1.actionuserid,t1.actionusername,t1.actiondescription,t1.actiondatetime,t1.actionmodul,t1.classid,t2.headpic,t2.headpicupdate
	FROM blog..class_actionlogs t1 LEFT JOIN blog..bloguserkmpuser t3 ON t1.actionuserid=t3.kmpuserid 
       INNER JOIN blog..blog_baseconfig t2 ON t3.bloguserid=t2.userid  
    WHERE  t1.classid>0 and t1.actionuserid>0 and t1.actiondatetime between @datetime and getdate()
	UPDATE sync_datetime SET actiondatetime=getdate() where tablename='class_actionlogs_new'

GO
