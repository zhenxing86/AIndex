USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[GetCms_contentYsdtByPage]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-12-5
-- Description:	函数用于获取Categoryid
-- Memo:		
EXEC GetCms_contentYsdtByPage 12511,1,'ysdt'
EXEC GetCms_contentYsdtByPage 12511,1,'mzsp'
*/
CREATE PROC [dbo].[GetCms_contentYsdtByPage]
	@kid int,
	@page int,
	@type varchar(10)
as
BEGIN
declare @categoryid1 int,@categoryid2 int
DECLARE @whereString VARCHAR(200) =  ' siteid = @D1 '
IF @type = 'ysdt'
BEGIN
	SELECT @categoryid1 = dbo.fn_GetCategoryid(@kid,'gg')
	SELECT @categoryid2 = dbo.fn_GetCategoryid(@kid,'xw')
	SET @whereString = @whereString + ' and categoryid IN(@D2,@D3) '
END 
else IF @type = 'mzsp'  
BEGIN
	SELECT @categoryid1 = dbo.fn_GetCategoryid(@kid,'mzsp')
	SET @whereString = @whereString + ' and categoryid = @D2 and deletetag = 1 '
END
	exec sp_GridViewByPager  
    @viewName = 'cms_content',             --表名  
    @fieldName = ' contentid, title, content, createdatetime',      --查询字段  
    @keyName = 'contentid',       --索引字段  
    @pageSize = 10,                 --每页记录数  
    @pageNo = @page,                     --当前页  
    @orderString = ' createdatetime DESC ',          --排序条件  
    @whereString = @whereString ,  --WHERE条件  
    @IsRecordTotal = 0,             --是否输出总记录条数  
    @IsRowNo = 0,  
    @D1 = @kid ,  
    @D2 = @categoryid1,  
    @D3 = @categoryid2 		
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetCms_contentYsdtByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
