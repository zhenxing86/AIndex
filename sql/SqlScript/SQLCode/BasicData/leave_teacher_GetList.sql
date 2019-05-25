use BasicData 
go
/*    
-- Author:      xie    
-- Create date: 2013-12-18  
-- Description:  根据kid获取班级列表，及班级在校人数，离园人数   
-- Memo:      
exec leave_teacher_GetList 12511,1,10,'','2013-8-17 00:00:00','2013-12-18 23:59:59'  
*/    
  
create PROCEDURE [dbo].leave_teacher_GetList      
@kid int, 
@page int,
@size int,        
@username nvarchar(20),  
@bgndate datetime,  
@enddate datetime  
 AS       
begin      
 DECLARE @fromstring NVARCHAR(2000)   
 
 SET @fromstring =       
 'user_kindergarten_history l   
    inner join BasicData..[User] u on u.userid=l.userid  
   where l.kid = @D1 and  
   l.actiondatetime>=@T1 and l.actiondatetime<=@T2 '    
    
  IF @username <> '' SET @fromstring = @fromstring + ' AND u.name like @S1 + ''%'''
                   
 --分页查询      
 exec sp_MutiGridViewByPager      
  @fromstring = @fromstring,      --数据集      
  @selectstring =       
  ' l.userid,u.name,u.mobile,l.actiondatetime  ',      --查询字段      
  @returnstring =       
  ' userid,name,mobile,actiondatetime',      --返回字段      
  @pageSize = @Size,                 --每页记录数      
  @pageNo = @page,                     --当前页      
  @orderString = ' u.name ',          --排序条件      
  @IsRecordTotal = 1,             --是否输出总记录条数      
  @IsRowNo = 0,           --是否输出行号      
  @D1 = @kid,   
  @S1 = @username, 
  @T1 = @bgndate,
  @T2 = @enddate    
end 