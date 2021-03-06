USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[hb_Temp_GetListTag]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
Author: xie      
DataTime: 2014-09-15      
Desitipation:获取模板      
      
[hb_Temp_GetListTag] '常用',560725,12511,1,10        
      
*/      
CREATE proc [dbo].[hb_Temp_GetListTag]      
@tmptype nvarchar(50),        
@uid int,        
@kid int,      
@page int,      
@size int      
as      
BEGIN     
     
 if(not exists(select * from ossapp..kinbaseinfo where status='正常缴费' and kid=@kid))        
 begin        
  SELECT top 7 1 pcount,id,catid,tmptype,tmpcontent    
   from zgyey_om..hb_remark_temp ht    
 left join ebook..uid_temp ut on ht.id=ut.tempid and ut.userid=@uid        
   where tmptype=@tmptype and catid=0        
   ORDER BY ut.userid        
end        
else     
begin     
 DECLARE @fromstring NVARCHAR(2000)    
                    
 SET @fromstring = 'zgyey_om..hb_remark_temp ht     
  left join ebook..uid_temp ut on ht.id=ut.tempid and ut.userid=@D1    
   where ht.tmptype=@S1 and ht.catid=0   '         
 --分页查询                
 exec sp_MutiGridViewByPager                
  @fromstring = @fromstring,      --数据集                
  @selectstring =                 
  ' id,catid,tmptype,tmpcontent',      --查询字段                
  @returnstring =                 
  ' id,catid,tmptype,tmpcontent',      --返回字段                
  @pageSize = @Size,                 --每页记录数                
  @pageNo = @page,                     --当前页                
  @orderString = ' ut.userid  ',          --排序条件                
  @IsRecordTotal = 1,             --是否输出总记录条数                
  @IsRowNo = 0,           --是否输出行号                
  @D1 = @uid,    
  @S1 = @tmptype    
end    
      
END 
GO
