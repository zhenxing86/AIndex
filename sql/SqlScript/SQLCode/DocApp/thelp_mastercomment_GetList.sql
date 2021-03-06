USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_mastercomment_GetList]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--获取头像
CREATE PROCEDURE [dbo].[thelp_mastercomment_GetList]
@docid int
 AS
	SELECT 	t.mastercommentid,t.docid,t.content,t.userid,t.author,
					t.commentdatetime,t.parentid ,u.headpicupdate,u.headpic  
		FROM thelp_mastercomment t 
			left join basicdata..[user] u  
				on t.userid = u.userid  
		WHERE t.docid = @docid

GO
