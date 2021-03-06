USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetBlogPostsModel]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到日记文章实体对象的详细信息 
--项目名称：zgyeyblog
--说明：
--时间：2008-12-16 13:55:19
------------------------------------
CREATE PROCEDURE [dbo].[Manage_GetBlogPostsModel]
@postid int,
@type int
 AS 
	 --如果配置表中无数据，初始化一条
 if not exists( select c.userid from blog_baseconfig c join blog_posts b on c.userid=b.userid where b.postid=@postid)
 begin
 declare @bloguserid int,@userid int,@usertype int,@gender nvarchar(50)
	select @bloguserid=b.userid,@userid=u.userid,@usertype=usertype,@gender=gender from blog_posts b join BasicData..user_bloguser ub on b.userid=ub.bloguserid
	join BasicData..[user] u on ub.userid=u.userid where postid=@postid
	exec [blog_Register] @bloguserid,@userid,@usertype,@gender,''
end	
	IF (@type=1)
	BEGIN
		--更新文章查看数
		UPDATE blog_posts SET viewcounts=viewcounts+1 WHERE postid=@postid
	END	

	SELECT 
	t1.postid,t1.author,t1.userid,t1.postdatetime,t1.title,t1.content,t1.poststatus,t1.categoriesid,t1.commentstatus,t1.IsTop,t1.IsSoul,t1.postupdatetime,t1.commentcount,t1.viewcounts,t1.smile,t2.title as categorytitle
	 FROM blog_posts t1
	left JOIN
		blog_postscategories t2
	ON  t1.categoriesid=t2.categoresid
    WHERE postid=@postid 





GO
