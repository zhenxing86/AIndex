use ClassApp
go
/*      
-- Author:      xie  
-- Create date: 2013-12-20     
-- Description:       
-- Memo:        
exec class_schedule_GetList_del 12511,1,10,'','','2013-12-19 10:00:00','2013-12-19 23:59:59'      
*/      
create PROCEDURE [dbo].class_schedule_GetList_del      
@kid int, 
@page int,
@size int, 
@cname nvarchar(20),
@title nvarchar(20), 
@bgndate datetime,  
@enddate datetime    
 AS       
begin      
 DECLARE @fromstring NVARCHAR(2000)   
 
 
 SET @fromstring =       
 'class_schedule cs
   inner join basicdata..class c on cs.classid=c.cid
    where cs.kid = @D1 and
    cs.status=0 and
    cs.createdatetime>=@T1 and cs.createdatetime<=@T2 '    
    
  IF @title <> '' SET @fromstring = @fromstring + ' AND cs.[title] like @S1 + ''%'''  
  IF @cname <> '' SET @fromstring = @fromstring + ' AND c.cname like @S2 + ''%'''   
                   
 --分页查询      
 exec sp_MutiGridViewByPager      
  @fromstring = @fromstring,      --数据集      
  @selectstring =       
  ' cs.scheduleid,cs.title,cs.author,c.cname,cs.createdatetime',      --查询字段      
  @returnstring =       
  ' scheduleid,title,author,cname,createdatetime',      --返回字段      
  @pageSize = @Size,                 --每页记录数      
  @pageNo = @page,                     --当前页      
  @orderString = ' cs.[classid] ',          --排序条件      
  @IsRecordTotal = 1,             --是否输出总记录条数      
  @IsRowNo = 0,           --是否输出行号      
  @D1 = @kid,  
  @S1 = @title, 
  @S2 = @cname,  
  @T1 = @bgndate,
  @T2 = @enddate    
end 