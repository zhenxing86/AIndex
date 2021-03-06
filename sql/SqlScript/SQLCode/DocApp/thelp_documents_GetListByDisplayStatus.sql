USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_GetListByDisplayStatus]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询文档列表根据文档显示状态
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-03 21:30:07
--作者：along
--exec [thelp_documents_GetListByDisplayStatus] 58,1,1,5
--select * from thelp_documents
--select * From thelp_categories select * From blog_user select * From bloguserkmpuser
------------------------------------
CREATE PROCEDURE [dbo].[thelp_documents_GetListByDisplayStatus] 
@kid int,
@display int,
@page int,
@size int
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

	IF(@display=0)--班级显示
	BEGIN
	INSERT INTO @documents(docid)
		SELECT
			docid
		FROM
			thelp_documents
		WHERE
			deletetag=1 and classdisplay=1
		ORDER BY
			createdatetime DESC
	END
	ELSE IF (@display=1)--幼儿园文档
	BEGIN
		INSERT INTO @documents(docid)
		SELECT
			t1.docid
		FROM
			thelp_documents t1 		
		inner JOIN BasicData.dbo.user_bloguser t3
		ON t1.userid = t3.bloguserid
		inner join BasicData.dbo.[user] t4 on t3.userid=t4.userid
		WHERE
			t1.deletetag=1 and t1.kindisplay=1 and t4.kid=@kid
		ORDER BY
			t1.createdatetime DESC
	END
	ELSE IF (@display=2)--公共文档
	BEGIN
		INSERT INTO @documents(docid)
		SELECT
			docid
		FROM
			thelp_documents
		WHERE
			deletetag=1 and publishdisplay=1 AND aprove=1
		ORDER BY
			createdatetime DESC
	END

		SET ROWCOUNT @size
		SELECT
			t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,userid,author,
			(select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount
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
	IF(@display=0)
	BEGIN		
		SELECT
				t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,userid,author,
				(select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount
			FROM
				thelp_documents t1
			where deletetag=1 and classdisplay=1
		order by createdatetime desc
	END
	ELSE IF (@display=1)
	BEGIN
			SELECT
				t1.docid,t1.categoryid,t1.title,t1.description,t1.body,t1.classdisplay,t1.kindisplay,
				t1.publishdisplay,t1.createdatetime,t1.viewcount,t1.userid,t1.author,
				(select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount
			FROM
				thelp_documents t1
		inner JOIN BasicData.dbo.user_bloguser t3
		ON t1.userid = t3.bloguserid
		inner join BasicData.dbo.[user] t4 on t3.userid=t4.userid
		WHERE
			t1.deletetag=1 and t1.kindisplay=1 and t4.kid=@kid			
		order by t1.createdatetime desc
	END
	ELSE IF (@display=2)
	BEGIN
			SELECT
				t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,userid,author,
				(select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount
			FROM
				thelp_documents t1
			where deletetag=1 and publishdisplay=1 AND aprove=1
		order by createdatetime desc
	END
END

GO
