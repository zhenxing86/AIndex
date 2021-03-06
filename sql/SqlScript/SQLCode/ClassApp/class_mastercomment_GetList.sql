USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_mastercomment_GetList]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取园长点评列表 
--项目名称：zgyeyblog
--说明：
--时间：2009-2-7 10:20:28
------------------------------------
CREATE PROCEDURE [dbo].[class_mastercomment_GetList]
@docid int
 AS 
	SELECT	cs.mastercommentid,cs.docid,cs.content,cs.userid,cs.author,cs.commentdatetime,
					cs.parentid,ub.bloguserid,u.headpic,u.headpicupdate as headpicupdatetime
		FROM BasicData.dbo.[user] u  
			INNER JOIN  BasicData.dbo.user_bloguser ub
				ON u.userid = ub.bloguserid
			RIGHT JOIN class_schedulemastercomment cs 
				ON ub.userid = cs.userid
		WHERE cs.docid = @docid 
			order by cs.commentdatetime DESC

GO
