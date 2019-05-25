use ClassApp
go
/*      
-- Author:      xie  
-- Create date: 2013-12-20     
-- Description:       
-- Memo:        
exec class_photos_GetList_del 11373,1,10,0,'',0,'','2010-12-19 10:00:00','2013-12-19 23:59:59'      
*/      
create PROCEDURE [dbo].class_photos_GetList_del      
@kid int, 
@page int,
@size int, 
@cid int, 
@cname nvarchar(20),
@albumid int,
@ptitle nvarchar(20), 
@bgndate datetime,  
@enddate datetime    
 AS       
begin      
 DECLARE @fromstring NVARCHAR(2000)   
 
 SET @fromstring =       
 'class_photos cp
   inner join class_album ca on ca.albumid=cp.albumid
   inner join basicdata..class c on cp.cid=c.cid
    where cp.kid = @D1 and
    cp.status<=0 and
     cp.uploaddatetime>=@T1 and cp.uploaddatetime<=@T2 '    
    
  IF @ptitle <> '' SET @fromstring = @fromstring + ' AND ca.[title] like @S1 + ''%'''  
  IF @cname <> '' SET @fromstring = @fromstring + ' AND c.cname like @S2 + ''%'''   
  IF @cid>0 SET @fromstring = @fromstring + ' AND cp.cid =@D2'
  IF @albumid>0 SET @fromstring = @fromstring + ' AND cp.albumid =@D3'
                   
 --分页查询      
 exec sp_MutiGridViewByPager      
  @fromstring = @fromstring,      --数据集      
  @selectstring =       
  ' cp.photoid,c.cname,ca.title,cp.[filename],cp.filepath,cp.uploaddatetime',      --查询字段      
  @returnstring =       
  ' photoid,cname,title,[filename],filepath,uploaddatetime',      --返回字段      
  @pageSize = @Size,                 --每页记录数      
  @pageNo = @page,                     --当前页      
  @orderString = ' cp.[cid],cp.albumid ',          --排序条件      
  @IsRecordTotal = 1,             --是否输出总记录条数      
  @IsRowNo = 0,           --是否输出行号      
  @D1 = @kid,  
  @D2 = @cid,  
  @D3 = @albumid,  
  @S1 = @ptitle, 
  @S2 = @cname,  
  @T1 = @bgndate,
  @T2 = @enddate    
end 