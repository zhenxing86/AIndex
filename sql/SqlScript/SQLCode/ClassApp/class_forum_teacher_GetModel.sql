USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_teacher_GetModel]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：得到实体对象的详细信息 
--项目名称：CodematicDemo
--说明：
--时间：2009-2-13 17:09:59
------------------------------------
CREATE PROCEDURE [dbo].[class_forum_teacher_GetModel]
@classforumid int
 AS 
	SELECT 
	t1.classforumid,t1.title,t1.contents,t1.userid,t1.author,t1.kid,t1.createdatetime,t1.istop,t1.parentid,(select count(1) as neralytime from class_forum  where parentid=@classforumid)as commentcount,
	t2.bloguserid,t1.approve
	 FROM class_forum_teacher t1
		LEFT JOIN 
		BasicData.dbo.user_bloguser t2
		ON t1.userid=t2.userid
	 WHERE t1.classforumid=@classforumid 






GO
