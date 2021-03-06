USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[GetVideoByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      Master谭    
-- Create date:     
-- Description:     
-- Memo: GetVideoByPage 1 ,1, 10     
*/    
CREATE PROC [dbo].[GetVideoByPage]    
 @Categoryid bigint,    
 @page int,    
 @size int    
AS    
BEGIN    
 SET NOCOUNT ON    
 exec sp_GridViewByPager      
    @viewName = 'Videos',             --表名      
    @fieldName = ' VideoID, Title, CoverPic, PicUpdateTime, PicNet, ViewCNT, VideoUpdateTime,VideoNet',      --查询字段      
    @pageSize = @size,                 --每页记录数      
    @pageNo = @page,                     --当前页      
    @orderString = ' VideoUpdateTime desc ',          --排序条件      
    @whereString = ' DeleteTag = 1 AND Categoriesid = @D1 ' ,  --WHERE条件      
    @IsRecordTotal = 1,             --是否输出总记录条数      
    @IsRowNo = 0,      
    @D1 = @Categoryid     
             
END 

GO
