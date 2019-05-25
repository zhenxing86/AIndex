use ClassApp
go
/*      
-- Author:      xie  
-- Create date: 2013-12-20     
-- Description:       
-- Memo:        
exec class_notice_GetList_del 12511,1,10,'','','2010-7-1 10:00:00','2013-12-19 23:59:59'      
*/      
alter PROCEDURE [dbo].class_notice_GetList_del      
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
 'class_notice cn
   inner join basicdata..class c on cn.classid=c.cid
    where cn.kid = @D1 and cn.[status]<=0 and
     cn.createdatetime>=@T1 and cn.createdatetime<=@T2 '    
    
  IF @title <> '' SET @fromstring = @fromstring + ' AND cn.[title] like @S1 + ''%'''         
  IF @cname <> '' SET @fromstring = @fromstring + ' AND c.cname like @S2 + ''%'''                  
 --分页查询      
 exec sp_MutiGridViewByPager      
  @fromstring = @fromstring,      --数据集      
  @selectstring =       
  ' cn.noticeid,cn.title,cn.createdatetime,c.cname,author ',      --查询字段      
  @returnstring =       
  ' noticeid,title,createdatetime,cname,author ',      --返回字段      
  @pageSize = @Size,                 --每页记录数      
  @pageNo = @page,                     --当前页      
  @orderString = ' cn.[classid] ',          --排序条件      
  @IsRecordTotal = 1,             --是否输出总记录条数      
  @IsRowNo = 0,           --是否输出行号      
  @D1 = @kid,  
  @S1 = @title, 
  @S2 = @cname,  
  @T1 = @bgndate,
  @T2 = @enddate    
end 

