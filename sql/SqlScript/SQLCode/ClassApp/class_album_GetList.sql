use ClassApp
go
/*      
-- Author:      xie  
-- Create date: 2013-12-20     
-- Description:       
-- Memo:        
exec class_album_GetList 12511,1,10,'','','2013-12-19 10:00:00','2013-12-19 23:59:59'      
*/      
alter PROCEDURE [dbo].class_album_GetList      
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
 'class_album ca
   inner join basicdata..class c on ca.classid=c.cid
    where ca.kid = @D1 and
     ca.lastuploadtime>=@T1 and ca.lastuploadtime<=@T2 '    
    
  IF @title <> '' SET @fromstring = @fromstring + ' AND ca.[title] like @S1 + ''%'''         
  IF @cname <> '' SET @fromstring = @fromstring + ' AND c.cname like @S2 + ''%'''                  
 --分页查询      
 exec sp_MutiGridViewByPager      
  @fromstring = @fromstring,      --数据集      
  @selectstring =       
  ' ca.albumid,ca.title,ca.photocount,ca.author,ca.createdatetime,ca.lastuploadtime,ca.[status],c.cname,ca.classid,ca.kid',      --查询字段      
  @returnstring =       
  ' albumid,title,photocount,author,createdatetime,lastuploadtime,[status],cname,classid,kid',      --返回字段      
  @pageSize = @Size,                 --每页记录数      
  @pageNo = @page,                     --当前页      
  @orderString = ' [status],ca.[classid] ',          --排序条件      
  @IsRecordTotal = 1,             --是否输出总记录条数      
  @IsRowNo = 0,           --是否输出行号      
  @D1 = @kid,  
  @S1 = @title, 
  @S2 = @cname,  
  @T1 = @bgndate,
  @T2 = @enddate    
end 