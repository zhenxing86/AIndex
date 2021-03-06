USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_content_GetListPageByAllSiteid]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-29
-- Description:	分页读取文章数据
-- Memo:	
--    SELECT top 1 string FROM dbo.SpitString ('58,1023,7748' ,',')
--EXEC kweb_content_GetListPageByAllSiteid 'gg','7748,58',1,4
*/
CREATE PROCEDURE [dbo].[kweb_content_GetListPageByAllSiteid]
	@categorycode nvarchar(10),
	@siteid varchar(100),
	@page int,
	@size int
AS
BEGIN 
    DECLARE @categorycode2 varchar(30),@newsiteid int, @Filter varchar(100)

    IF @categorycode<>'JGXX'
    BEGIN
      SET @Filter=' and cc.categorycode = @S1 '
    END
    ELSE
    BEGIN
      SET @Filter= ' and cc.categorycode in(@S1,''XW'') '
    END       
	
        SELECT top 1 @newsiteid=string FROM dbo.SpitString (@siteid ,',')
        
    SELECT DISTINCT string siteid 
			into #siteid 
			FROM dbo.SpitString (@siteid ,',')    

	DECLARE @fromstring NVARCHAR(2000)
	SET @fromstring = 'cms_content a,site b, cms_category cc
		WHERE cc.categoryid= a.categoryid
			and cc.siteid in(@D1,0)										
			AND a.status=1 and a.deletetag = 1
			AND isnull(a.draftstatus,0) = 0
      and a.siteid IN ('+@siteid+')
      and a.siteid = b.siteid
      ' + @Filter
      
	exec	sp_MutiGridViewByPager
		@fromstring = @fromstring,      --数据集
		@selectstring = 
		'a.contentid,a.categoryid,a.content,a.title,a.titlecolor,
						a.author,a.createdatetime,b.name,b.sitedns',      --查询字段
		@returnstring = 
		'contentid, categoryid, content, title, titlecolor,
						 author, createdatetime, name, sitedns',      --返回字段
		@pageSize = @Size,                 --每页记录数
		@pageNo = @page,                     --当前页
		@orderString = ' a.orderno DESC,a.contentid DESC		',          --排序条件
		@IsRecordTotal = 0,             --是否输出总记录条数
		@IsRowNo = 0,									 --是否输出行号
		@D1 = @newsiteid,								
		@S1 = @categorycode
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetListPageByAllSiteid', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetListPageByAllSiteid', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_content_GetListPageByAllSiteid', @level2type=N'PARAMETER',@level2name=N'@page'
GO
