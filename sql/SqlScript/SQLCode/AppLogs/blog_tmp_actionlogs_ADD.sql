USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[blog_tmp_actionlogs_ADD]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取最新动态
--项目名称：zgyeyblog
--说明：
--时间：2008-09-28 22:56:46
------------------------------------
CREATE PROCEDURE [dbo].[blog_tmp_actionlogs_ADD]
 AS 
delete from blog_tmp_actionlogs
INSERT INTO blog_tmp_actionlogs
           ([actionuserid]
           ,[actionusername]
           ,[actiondesc]
           ,[actiondatetime]
           ,[headpic]
           ,[headpicupdate])
select top 20 actionuserid,actionusername, 
actiondesc,actiondatetime,t4.headpic,t4.headpicupdate
	from blog_new_actionlogs t1 
	inner join BasicData.dbo.user_bloguser t2 on t1.actionuserid=t2.bloguserid 
	inner join BasicData.dbo.[user] t4 on t4.userid=t2.userid
where datediff(dd,t4.regdatetime,getdate())>3 
 order by actiondatetime desc

GO
