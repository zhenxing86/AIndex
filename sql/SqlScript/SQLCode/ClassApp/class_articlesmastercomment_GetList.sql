USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_articlesmastercomment_GetList]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取班级文章园长点评列表 
--项目名称：zgyeyblog
--说明：
--时间：2009-5-14 14:43:20
------------------------------------
CREATE PROCEDURE [dbo].[class_articlesmastercomment_GetList]
	@articleid int
 AS
BEGIN
	SET NOCOUNT ON 
		SELECT	ca.commentid,ca.articleid,ca.content,ca.userid,ca.author,
						ca.commentdatetime,ca.parentid,ub.bloguserid,u.headpic,u.headpicupdate
			FROM	BasicData.dbo.[user] u 
				INNER JOIN  BasicData.dbo.user_bloguser ub
				ON u.userid = ub.userid
				RIGHT JOIN class_articlesmastercomment ca
				ON ub.userid = ca.userid
			WHERE articleid = @articleid 
				and ca.status = 1 
			ORDER BY ca.commentdatetime DESC
END

GO
