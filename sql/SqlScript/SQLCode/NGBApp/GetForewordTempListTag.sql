USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetForewordTempListTag]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*          
Author: xie          
DataTime: 2014-09-15          
Desitipation:获取学期寄语模板(目前学期寄语所有幼儿园共用，不按班级获取)      
          
[GetForewordTempListTag] 46144,12511,1,100        
          
*/   
  
CREATE PROCEDURE [dbo].[GetForewordTempListTag]    
@classid int,    
@kid int,    
@page int,    
@size int    
 AS     
BEGIN   
declare @catid int    
set @catid=1    
    
    
if(not exists(select * from ossapp..kinbaseinfo where status='正常缴费' and kid=@kid))            
 begin            
  SELECT top 7 1 pcount,id,catid,tmptype,tmpcontent        
   from zgyey_om..hb_remark_temp ht        
-- inner join ebook..cid_temp ct on ht.id=ct.tempid          
   where ht.catid=1 --and ct.classid=@classid     
   order by id desc        
end            
else         
begin         
 DECLARE @fromstring NVARCHAR(2000)        
                        
 SET @fromstring = 'zgyey_om..hb_remark_temp ht  
   where ht.catid=1 '             
 --分页查询                    
 exec sp_MutiGridViewByPager                    
  @fromstring = @fromstring,      --数据集                    
  @selectstring =                     
  ' id,catid,tmptype,tmpcontent',      --查询字段                    
  @returnstring =                     
  ' id,catid,tmptype,tmpcontent',      --返回字段                    
  @pageSize = @Size,                 --每页记录数                    
  @pageNo = @page,                     --当前页                    
  @orderString = 'id desc ',          --排序条件                    
  @IsRecordTotal = 1,             --是否输出总记录条数                    
  @IsRowNo = 0           --是否输出行号                        
end        
          
END   
     
     
    
    
    
    
    
    
      
    
GO
