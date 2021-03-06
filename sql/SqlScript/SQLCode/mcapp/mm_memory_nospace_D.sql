USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mm_memory_nospace_D]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*          
-- Author:     xie
-- Create date: 2014-06-20          
-- Description:  某段时间各异常日志总表      
-- Memo:  
输入：参数不能为空
输出：Kid,Kname,Devid,devicetype，logmsg，logtime,uploadtime

exec mm_memory_nospace_D
@page = 1 ,
@size = 10,
@devid = '001251113',
@devicetype = 0,
@bgntime = '2013-1-2 00:00:00',
@endtime = '2014-3-2 23:59:59' ,
@logtype = 8,
@smalllogtype =1
       
*/  
CREATE PROCEDURE [dbo].[mm_memory_nospace_D]               
@page int ,
@size int,
@devid nvarchar(50),
@bgntime DateTime,
@endtime DateTime,
@logtype int = 8,
@smalllogtype int =1
 AS    
 BEGIN
  DECLARE @fromstring NVARCHAR(2000)
  SET @fromstring =           
	' LogInfo_ex l
	   left join basicdata..kindergarten k 
	    on l.kid = k.kid    
	  where l.logtime>=@T1 and l.logtime<=@T2
	   AND l.logtype = @D1
	   AND l.smalllogtype = @D2 AND l.[devid] = @S1'    

 --分页查询          
 exec sp_MutiGridViewByPager          
  @fromstring = @fromstring,      --数据集          
  @selectstring =
  ' l.Kid,k.Kname,l.Devid,l.devicetype,l.result Diskspace, l.logmsg,l.logtime,l.uploadtime',      --查询字段          
  @returnstring =           
  ' Kid,Kname,Devid,devicetype,Diskspace,logmsg,logtime,uploadtime',      --返回字段          
  @pageSize = @Size,                 --每页记录数          
  @pageNo = @page,                     --当前页          
  @orderString = ' logtime desc,uploadtime desc ',          --排序条件          
  @IsRecordTotal = 1,             --是否输出总记录条数          
  @IsRowNo = 0,           --是否输出行号           
  @D1 = @logtype,
  @D2 = @smalllogtype,        
  @S1 = @devid,        
  @T1 = @bgntime,          
  @T2 = @endtime 
 END    
GO
