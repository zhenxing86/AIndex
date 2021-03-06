USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_doccomment_GetList]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：取文档评论列表
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-06 22:57:51
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[thelp_doccomment_GetList]
@docid int,
@page int,
@size int
 AS 
IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)
	
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
			SELECT 
				doccommentid
			FROM	 
				thelp_doccomment 
			WHERE docid=@docid
			order by
				commentdatetime desc

		SET ROWCOUNT @size
		SELECT 
			t1.doccommentid,t1.docid,t1.userid,t1.author,t1.body,t1.commentdatetime,t1.parentid
		FROM 
			@tmptable AS tmptable		
		INNER JOIN
 			thelp_doccomment t1
		ON 
			tmptable.tmptableid=t1.doccommentid 	
		WHERE
			row>@ignore 
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
			doccommentid,docid,userid,author,body,commentdatetime,parentid
		FROM thelp_doccomment
		WHERE docid=@docid
		ORDER BY commentdatetime desc
	END






GO
