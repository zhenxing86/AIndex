USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_GetListByYear]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：按时间年份查询文档列表记录信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2010-09-28 15:30:07
------------------------------------
CREATE PROCEDURE [dbo].[thelp_documents_GetListByYear]
@documentyear int,
@page int,
@size int,
@userid int
 AS

IF(@page>1)
BEGIN
	DECLARE @prep int,@ignore int
	
	SET @prep = @size * @page
	SET @ignore=@prep - @size

	DECLARE @documents TABLE
	(
		--定义临时表
		row int IDENTITY (1, 1),
		docid bigint
	)
	
	SET ROWCOUNT @prep	
	INSERT INTO @documents(docid)
		SELECT
			docid
		FROM
			thelp_documents
		WHERE
			deletetag=1 and userid=@userid and year(createdatetime)=@documentyear
		ORDER BY
			createdatetime DESC


		SET ROWCOUNT @size
		SELECT
			t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,t1.userid,t1.author,
			(select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount,
			(select count(1) from thelp_mastercomment where docid=t1.docid) as mastercommentcount
		FROM
			@documents as predocuments
		INNER JOIN
			thelp_documents t1
		ON
			predocuments.docid = t1.docid		
		WHERE
			row > @ignore
END
ELSE
BEGIN
	   SET ROWCOUNT @size	
		SELECT
				t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,userid,author,
				(select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount,
				(select count(1) from thelp_mastercomment where docid=t1.docid) as mastercommentcount
			FROM
				thelp_documents t1
			WHERE deletetag=1 and userid=@userid and year(createdatetime)=@documentyear
		order by createdatetime desc
END






GO
