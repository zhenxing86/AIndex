USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[GetObject_PicByPage]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-12-11
-- Description:	
-- Memo:		GetObject_PicByPage 12511,'010010000003',1,10
*/
CREATE PROC [dbo].[GetObject_PicByPage]
	@kid int,
	@BarCode varchar(50),
	@page int,
	@size int
AS
BEGIN
	SET NOCOUNT ON
	   exec sp_GridViewByPager    
    @viewName = 'Object_Pic',             --表名  
    @fieldName = ' ID, kid, BarCode, Title, FileName, FilePath, Crtdate',      --查询字段  
    @keyName = 'ID',       --索引字段  
    @pageSize = @size,                 --每页记录数  
    @pageNo = @page,                     --当前页  
    @orderString = ' Crtdate desc ',          --排序条件  
    @whereString = ' kid = @D1 and BarCode = @S1  ' ,  --WHERE条件  
    @IsRecordTotal = 1,             --是否输出总记录条数  
    @IsRowNo = 0,  
    @D1 = @kid ,  
    @S1 = @BarCode 

END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分页取物品的图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetObject_PicByPage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetObject_PicByPage', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品条码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetObject_PicByPage', @level2type=N'PARAMETER',@level2name=N'@BarCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分页页数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetObject_PicByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分页大小' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetObject_PicByPage', @level2type=N'PARAMETER',@level2name=N'@size'
GO
