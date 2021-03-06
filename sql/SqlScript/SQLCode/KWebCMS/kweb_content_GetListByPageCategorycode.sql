USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_content_GetListByPageCategorycode]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-29
-- Description:	分页读取文章数据
-- Memo:	[kweb_content_GetListByPageCategorycode] 'JYKY_KYDT',1,10       
*/
CREATE PROCEDURE [dbo].[kweb_content_GetListByPageCategorycode]
	@categorycode nvarchar(10),
	@page int,
	@size int
AS
BEGIN
	SET NOCOUNT ON
	exec	sp_MutiGridViewByPager
		@fromstring = 'cms_content c
				left join cms_category t2 
					on c.categoryid = t2.categoryid 
			WHERE t2.categorycode = @S1 and c.deletetag = 1
				AND status = 1 
				AND isnull(c.draftstatus,0) = 0',      --数据集
		@selectstring = 
		'c.contentid, c.categoryid, c.content, c.title, 
						c.titlecolor,c.author,c.createdatetime',      --查询字段
		@returnstring = 
		'contentid, categoryid, content, title, titlecolor, author, createdatetime',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' c.createdatetime DESC	',          --排序条件
		@IsRecordTotal = 0,             --是否输出总记录条数
		@IsRowNo = 0,										 --是否输出行号
		@S1 = @categorycode

END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetListByPageCategorycode', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetListByPageCategorycode', @level2type=N'PARAMETER',@level2name=N'@page'
GO
