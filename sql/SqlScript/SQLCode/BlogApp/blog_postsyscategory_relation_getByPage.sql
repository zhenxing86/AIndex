USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_postsyscategory_relation_getByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[blog_postsyscategory_relation_getByPage]
	@startdatetime Datetime,
@enddatetime Datetime,
@title nvarchar(20),
@content nvarchar(20),
@page int,
@size int
AS
BEGIN
	DECLARE @prep int,@ignore int
SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
begin
IF(@page>1)
	BEGIN
						

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) SELECT postid FROM blog_posts 
		WHERE (postdatetime BETWEEN @startdatetime AND @enddatetime) 
		--AND contentid NOT IN (SELECT contentid FROM portalarticle)
		AND postid not in (SELECT postid FROM blog_postsyscategory_relation)
		--AND ([content] LIKE '%'+@content+'%')
		and title<>'我的博客开通啦'
		and title<>'我的成长档案开通啦'
		ORDER BY postdatetime DESC

		SET ROWCOUNT @size
		SELECT c.postid,c.[content],c.[title],c.postdatetime,c.[author],c.userid,b.usertype
		FROM blog_posts c JOIN @tmptable 
		ON c.postid=tmptableid 
		join KWebCMS.dbo.blog_lucidaUser_log b on c.userid=b.bloguserid
		WHERE row > @ignore ORDER BY postdatetime DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT t1.postid,t1.[content],t1.[title],t1.postdatetime,t1.[author],t1.userid,b.usertype
		FROM blog_posts t1,KWebCMS.dbo.blog_lucidaUser_log b
		WHERE t1.userid=b.bloguserid
		and (t1.postdatetime BETWEEN @startdatetime AND @enddatetime) 
		--AND contentid NOT IN (SELECT contentid FROM portalarticle)
		AND t1.postid not in (SELECT postid FROM blog_postsyscategory_relation)
		--AND ([content] LIKE '%'+@content+'%')
		and title<>'我的博客开通啦'
		and title<>'我的成长档案开通啦'
		ORDER BY t1.postdatetime DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SET ROWCOUNT @size
		SELECT t1.postid,t1.[content],t1.[title],t1.postdatetime,t1.[author],t1.userid,b.usertype
		FROM blog_posts t1,KWebCMS.dbo.blog_lucidaUser_log b
	    WHERE t1.userid=b.bloguserid
		and (t1.postdatetime BETWEEN @startdatetime AND @enddatetime) 
		--AND contentid NOT IN (SELECT contentid FROM portalarticle)
		AND t1.postid not in (SELECT postid FROM blog_postsyscategory_relation)
		--AND ([content] LIKE '%'+@content+'%')
		and title<>'我的博客开通啦'
		and title<>'我的成长档案开通啦'

		ORDER BY t1.postdatetime DESC
	END
end
END
GO
