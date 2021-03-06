USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetTea_UpPhotoByPageV2]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:     xie  
-- Create date: 2014-8-16    
-- Description: 分页读取在园剪影，并显示总页数  
-- Memo:use ngbapp      
exec GetTea_UpPhotoByPageV2 2151,2,10    
*/      
--      
CREATE PROC [dbo].[GetTea_UpPhotoByPageV2]    
 @gbid bigint,    
 @page int,    
 @size int  
AS    
BEGIN      
 SET NOCOUNT ON        
 exec sp_MutiGridViewByPager    
  @fromstring = 'tea_UpPhoto       
   where gbid=@D1 and deletetag=1',      --数据集    
  @selectstring =     
  'photo_desc,m_path,updatetime',      --查询字段    
  @returnstring =     
  'photo_desc,m_path,updatetime',      --返回字段    
  @pageSize = @size,                 --每页记录数    
  @pageNo = @page,                     --当前页    
  @orderString = ' updatetime desc',          --排序条件    
  @IsRecordTotal = 1,             --是否输出总记录条数    
  @IsRowNo = 0,           --是否输出行号    
  @D1 = @gbid     
    
END 
GO
