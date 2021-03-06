USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_blog_posts_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-16
-- Description:	获取精彩文章
-- Memo:		
exec [kweb_blog_posts_GetList] 12511,1,10
*/
CREATE PROCEDURE [dbo].[kweb_blog_posts_GetList]
	@siteid int,
	@page int,
	@size int
AS
BEGIN

	SET NOCOUNT ON
	if(exists(select 1 from theme_kids where kid=@siteid))	
	SET @siteid=12511
		
	exec sp_GridViewByPager
			 @viewName = 'blog_posts_list',             --表名
			 @fieldName = 'postid,author,userid,postdatetime,title,postupdatetime,commentcount,viewcounts,siteid',      --查询字段
			 @keyName = 'postid',       --索引字段
			 @pageSize = @size,                 --每页记录数
			 @pageNo = @page,                     --当前页
			 @orderString = ' postupdatetime DESC ',          --排序条件
			 @whereString = ' siteid = @D1  ' ,  --WHERE条件
			 @IsRecordTotal = 0,             --是否输出总记录条数
			 @IsRowNo = 0,			
			 @D1 = @siteid

END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_blog_posts_GetList', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_blog_posts_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
