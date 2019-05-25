use BasicData 
go
/*    
-- Author:      xie    
-- Create date: 2013-12-18  
-- Description:  根据kid获取部门列表
-- Memo:      
exec Department_GetList_All 12511,1,10,'','2013-8-17 00:00:00','2013-12-18 23:59:59'  
*/    
  
alter PROCEDURE [dbo].Department_GetList_All      
@kid int, 
@page int,
@size int,        
@dname nvarchar(20),
@bgndate datetime,
@enddate datetime
 AS       
begin      
 DECLARE @fromstring NVARCHAR(2000)   
 
 SET @fromstring =       
 'department d   
   where d.kid = @D1 and  
   d.actiondatetime>=@T1 and d.actiondatetime<=@T2 '    
    
  IF @dname <> '' SET @fromstring = @fromstring + ' AND d.dname like @S1 + ''%'''
                   
 --分页查询      
 exec sp_MutiGridViewByPager      
  @fromstring = @fromstring,      --数据集      
  @selectstring =       
  ' d.did,d.dname,d.actiondatetime,deletetag ',      --查询字段      
  @returnstring =       
  ' did,dname,actiondatetime,deletetag',      --返回字段      
  @pageSize = @Size,                 --每页记录数      
  @pageNo = @page,                     --当前页      
  @orderString = ' d.deletetag',          --排序条件      
  @IsRecordTotal = 1,             --是否输出总记录条数      
  @IsRowNo = 0,           --是否输出行号      
  @D1 = @kid,   
  @S1 = @dname, 
  @T1 = @bgndate,
  @T2 = @enddate    
end 