USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_blog_newactions]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-06-03
-- Description:	blog_newactions
-- =============================================
CREATE PROCEDURE [dbo].[kmp_blog_newactions]
AS
BEGIN
	select top 10 t1.author +':发表了-'+t1.title as description, 
	t1.userid, t1.postdatetime as actiontime,t4.headpic,t2.headpicupdate
	from blog..blog_posts t1, blog..blog_baseconfig t2, blog..blog_hotposts t3, blog..blog_baseconfig t4
	where t1.userid=t2.userid and t1.title <>'我的博客开通啦'
		and t1.postid = t3.postid and t1.userid=t4.userid
	 order by t3.createdate desc
END



GO
