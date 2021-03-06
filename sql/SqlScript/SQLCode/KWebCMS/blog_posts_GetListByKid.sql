USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_GetListByKid]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[blog_posts_GetListByKid]
@kid int,
@page int,
@size int
AS
IF(@page>1)
BEGIN
	DECLARE @prep int,@ignore int
	
	SET @prep = @size * @page
	SET @ignore=@prep - @size

	DECLARE @tmptable TABLE
	(
		--定义临时表
		row int IDENTITY (1, 1),
		tmptableid bigint
	)
	
	SET ROWCOUNT @prep
	INSERT INTO @tmptable(tmptableid)
		SELECT
			t1.postid
		FROM
			blogapp..blog_posts t1 INNER JOIN basicdata..user_bloguser t2 ON t1.userid=t2.bloguserid
			inner join basicdata..[user] t3 on t2.userid=t3.userid
		WHERE
			t3.kid=@kid
		ORDER BY
			t1.postupdatetime DESC


		SET ROWCOUNT @size
		SELECT
			t1.postid,t1.userid,t1.author,t1.title,t1.postupdatetime
		FROM
			@tmptable as tmptable
		INNER JOIN
			blogapp..blog_posts t1
		ON
			tmptable.tmptableid = t1.postid
		WHERE
			row > @ignore  ORDER BY	t1.postupdatetime DESC
END
ELSE
BEGIN
	SET ROWCOUNT @size
	SELECT
		t1.postid,t1.userid,t1.author,t1.title,t1.postupdatetime
	FROM
			blogapp..blog_posts t1 INNER JOIN basicdata..user_bloguser t2 ON t1.userid=t2.bloguserid
			inner join basicdata..[user] t3 on t2.userid=t3.userid
		WHERE
			t3.kid=@kid
		ORDER BY
			t1.postupdatetime DESC

END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'blog_posts_GetListByKid', @level2type=N'PARAMETER',@level2name=N'@page'
GO
