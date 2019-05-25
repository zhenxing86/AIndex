USE BasicData
GO
/****** Object:  StoredProcedure [dbo].[leave_student_GetList]    Script Date: 12/18/2013 14:49:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      xie  
-- Create date: 2013-12-18
-- Description:  根据kid获取班级列表，及班级在校人数，离园人数 
-- Memo:    
exec leave_student_GetList 12511,1,10,0,'','','2010-12-17 00:00:00','2013-12-18 23:59:59'
*/  

create PROCEDURE [dbo].leave_student_GetList      
@kid int, 
@page int,
@size int,     
@cid int,  
@cname nvarchar(20),   
@username nvarchar(20),  
@bgndate datetime,  
@enddate datetime   
 AS       
begin      
 DECLARE @fromstring NVARCHAR(2000)   
 
 SET @fromstring =       
 'leave_kindergarten l   
    left join dict_xml d on l.leavereason=d.ID  
    inner join BasicData..[User] u on u.userid=l.userid  
    inner join BasicData..[class] c on c.cid=l.cid  
   where l.kid = @D1 and  
   l.outtime>=@T1 and l.outtime<=@T2 '    
    
  IF @username <> '' SET @fromstring = @fromstring + ' AND u.name like @S1 + ''%'''  
  IF @cname <> '' SET @fromstring = @fromstring + ' AND c.cname like @S2 + ''%'''   
  IF @cid>0 SET @fromstring = @fromstring + ' AND l.cid =@D2'
                   
 --分页查询      
 exec sp_MutiGridViewByPager      
  @fromstring = @fromstring,      --数据集      
  @selectstring =       
  ' l.userid,u.name,u.mobile,d.[Catalog],l.outtime,c.cname',      --查询字段      
  @returnstring =       
  ' userid,name,mobile,[Catalog],outtime,cname',      --返回字段      
  @pageSize = @Size,                 --每页记录数      
  @pageNo = @page,                     --当前页      
  @orderString = ' l.[cid] ',          --排序条件      
  @IsRecordTotal = 1,             --是否输出总记录条数      
  @IsRowNo = 0,           --是否输出行号      
  @D1 = @kid,  
  @D2 = @cid,    
  @S1 = @username, 
  @S2 = @cname,  
  @T1 = @bgndate,
  @T2 = @enddate    
end 