USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[questions_GetList]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
-- =============================================          
     
/*          
memo: exec questions_GetList  1,10,2     
*/          
-- =============================================          
CREATE PROCEDURE [dbo].[questions_GetList]  
 @page int,    
@size int,  
 @testid int ,  
 @categoryid int=0        
AS                
BEGIN              
  DECLARE @fromstring NVARCHAR(2000)     
  declare @pcount int    
   
      if(@testid>0 and @categoryid>0)    
   begin    
   SELECT @pcount=count(1) FROM Questions where testid=@testid   and categoryid=@categoryid and deletetag=1      
   end    
   else if(@testid>0)    
   begin    
   SELECT @pcount=count(1) FROM Questions where testid=@testid  and deletetag=1      
   end     
        
      else    
      begin    
       SELECT @pcount=count(1) FROM Questions where    deletetag=1     
      end           
  SET @fromstring =                 
  'Questions q left join category c  on q.categoryid=c.id left join SubCategory sc on c.id=sc.categoryid and q.testid=sc.testid and sc.deletetag=1 where q.deletetag=1 '           
   
    if(@testid>0)    
   begin    
  set @fromstring = @fromstring + ' and q.testid=@D3'      
   end        
     if(@categoryid>0)    
   begin    
  set @fromstring = @fromstring + ' and q.categoryid=@D2'      
   end           
  --分页查询                
  exec sp_MutiGridViewByPager                
   @fromstring = @fromstring,      --数据集                
   @selectstring =                 
   ' @D1 pcount,q.id,q.title,q.describe ,c.categorytitle,q.categoryid,sc.subtit',      --查询字段                
   @returnstring =                 
   ' @D1,id, title, describe , categorytitle,categoryid,subtit  ',      --返回字段                
   @pageSize = @Size,                 --每页记录数                
   @pageNo = @page,                     --当前页                
   @orderString = '  q.orderno DESC ',          --排序条件                
   @IsRecordTotal = 0,             --是否输出总记录条数                
   @IsRowNo = 0,           --是否输出行号                
   @D1 = @pcount,          
    @D2=@categoryid,   
   @D3=@testid       
END 
GO
