USE [fmcapp]
GO
/****** Object:  StoredProcedure [dbo].[jzxxGetVideoByGrade]    Script Date: 2014/11/24 23:06:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
         
/*                  
-- Author:                   
-- Create date:  2014-10-30         
-- Description: 分页读取视频的列表                  
-- Memo:                
exec fmcapp..jzxxGetVideoByGrade   1 ,10,828972                
             
*/                  
--                  
CREATE PROC [dbo].[jzxxGetVideoByGrade]                  
 @page int,      
 @userid int ,      
 @size int=8           
AS                
BEGIN            
              
 SET NOCOUNT ON         
 declare @jzxxgrade int =35          
  select @jzxxgrade=isnull(jzxxgrade,0)   from BasicData..[user] u  where u.userid=@userid   and deletetag=1            
  if(@jzxxgrade=0)        
 begin        
  set @jzxxgrade=35        
 end               
 DECLARE                 
   @fromstring NVARCHAR(2000)                
 SELECT  @fromstring =   'fmc_videoapp a                
  inner join fmc_authorityexpert fa                
   on a.expertid = fa.ID                
  where a.deletetag = 1 and a.jzxxgrade=@D1  '                 
 exec sp_MutiGridViewByPager                
   @fromstring = @fromstring,      --数据集                
   @selectstring =                 
   'isnull(fa.name,'''') author,a.id,isnull(a.vtype,1) vtype, isnull(a.title,'''') title,isnull(a.mobilepicurl,'''') mobilepicurl,isnull(a.jzxxgrade,0) jzxxgrade,isnull(''       ''+fa.direction,'''') direction ,isnull(''       ''+a.describe,0) describe,  
   isnull(a.mp4url,'''') mp4url ',      --查询字段                
   @returnstring =                 
   'author,id,vtype, title,mobilepicurl,jzxxgrade,direction,describe,mp4url ',      --返回字段                
   @pageSize = @size,                 --每页记录数                
   @pageNo = @page,                     --当前页                
   @orderString = ' a.intime desc',          --排序条件                
   @IsRecordTotal = 1,             --是否输出总记录条数                
   @IsRowNo = 0,          --是否输出行号         
   @D1=@jzxxgrade         
            
END 
GO
