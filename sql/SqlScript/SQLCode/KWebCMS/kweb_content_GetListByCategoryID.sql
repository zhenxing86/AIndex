USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_content_GetListByCategoryID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-29
-- Description:	分页读取文章数据
-- Memo:	
*/
CREATE PROCEDURE [dbo].[kweb_content_GetListByCategoryID]
	@categoryid int,
	@page int,
	@size int
AS
BEGIN	
	SET NOCOUNT ON
	exec	sp_MutiGridViewByPager
		@fromstring = 'cms_content c1 
			LEFT join cms_category c2 
				on c2.categoryid = c1.categoryid
		WHERE c1.categoryid = @D1 and c1.deletetag = 1
			AND status = 1 
			and c1.orderno <> -1
			AND isnull(c1.draftstatus,0) = 0',      --数据集
		@selectstring = 
		'c1.contentid, c1.categoryid, c1.content, c1.title, 
					c1.titlecolor, c1.author, c1.createdatetime, c2.title AS categoryTitle',      --查询字段
		@returnstring = 
		'contentid, categoryid, content, title, titlecolor, author, createdatetime, categoryTitle',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' c1.orderno DESC, c1.contentid DESC	',          --排序条件
		@IsRecordTotal = 0,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@D1 = @categoryid

END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetListByCategoryID', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetListByCategoryID', @level2type=N'PARAMETER',@level2name=N'@page'
GO
