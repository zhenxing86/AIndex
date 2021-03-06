USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[GetVideo_CategoriesByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:	GetVideo_CategoriesByPage 1 ,1, 10	
*/
CREATE PROC [dbo].[GetVideo_CategoriesByPage]  
 @userid int,  
 @page int,  
 @size int  
AS  
BEGIN  
 SET NOCOUNT ON  
 exec sp_MutiGridViewByPager  
  @fromstring = 'Video_Categories vc   
    left join Videos_ViewSum vv   
     on vc.Categoriesid = vv.Categoriesid   
   WHERE DeleteTag = 1 AND userid = @D1',      --数据集  
  @selectstring =   
  'vc.Categoriesid, vc.Title, ISNULL(vv.cnt,0) VideoCNT, vc.CoverPic, vc.PicUpdateTime, vc.PicNet, vc.Is_Public',      --查询字段  
  @returnstring =   
  'Categoriesid, Title, VideoCNT, CoverPic, PicUpdateTime, PicNet, Is_Public',      --返回字段  
  @pageSize = @Size,                 --每页记录数  
  @pageNo = @page,                     --当前页  
  @orderString = ' CrtDate desc',          --排序条件  
  @IsRecordTotal = 1,             --是否输出总记录条数  
  @IsRowNo = 0,           --是否输出行号  
  @D1 = @userid   
           
END 

GO
