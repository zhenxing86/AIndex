USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_postsyscategory_relation_getCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[blog_postsyscategory_relation_getCount]
	@startdatetime Datetime,
@enddatetime Datetime,
@title nvarchar(20),
@content nvarchar(20)
AS
BEGIN
	DECLARE @count int
	SELECT @count=COUNT(*)
			FROM 
			(
				SELECT	ROW_NUMBER() OVER(order by c.postid desc) AS rows, 
								c.postid 
					FROM
								blog_posts c
					WHERE 
					    c.title  LIKE '%'+@title+'%' 
					    and title<>'我的博客开通啦'
						and (c.postdatetime BETWEEN  @startdatetime  AND  @enddatetime)
						AND c.postid not in (SELECT postid FROM blog_postsyscategory_relation)
			) AS main_temp 
			
			print @count
			return @count
END

GO
