USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mm_error_log_M]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*          
-- Author:     xie
-- Create date: 2014-06-20          
-- Description:  某段时间各异常日志总表      
-- Memo:  
输出：Kid,Kname,Devid,devicetype,logtype,smalllogtype,logcnt
          
exec mm_error_log_M 
@page = 1 ,
@size = 10,
@kid = -1,
@kname = '',
@devid = '',
@devicetype = -1,
@bgntime = '2013-1-2 00:00:00',
@endtime = '2014-3-2 23:59:59' ,
@logtype = -1,
@smalllogtype =-1
              
*/  
CREATE PROCEDURE [dbo].[mm_error_log_M]               
@page int ,
@size int,
@kid int,
@kname nvarchar(50),
@devid nvarchar(50),
@devicetype int,
@bgntime DateTime,
@endtime DateTime,
@logtype int,
@smalllogtype int
 AS    
 BEGIN
  DECLARE @fromstring NVARCHAR(2000),@selectstring NVARCHAR(4000),@ParmDefinition NVARCHAR(4000)    
  SET @fromstring =           
	'select l.Kid,k.Kname,l.Devid,l.devicetype,l.logtype,l.smalllogtype, COUNT(1) logcnt
	  from LogInfo_ex l
	  left join basicdata..kindergarten k 
	   on l.kid = k.kid    
	 where l.logtime>=@T1 and l.logtime<=@T2 '    
	 
  IF @kid >0 SET @fromstring = @fromstring + ' AND l.kid = @D1'      
  IF @devicetype >0 SET @fromstring = @fromstring + ' AND l.devidtype = @D2'  
  IF @logtype >0 SET @fromstring = @fromstring + ' AND l.logtype = @D3'  
  IF @smalllogtype >0 SET @fromstring = @fromstring + ' AND l.smalllogtype = @D4'            
  IF @devid <> '' SET @fromstring = @fromstring + ' AND l.[devid] = @S1'  
  IF @kname <> '' SET @fromstring = @fromstring + ' AND k.kname like @S2 + ''%'''                  
 
 Select @fromstring = @fromstring + '
   group by l.Kid,k.Kname,l.Devid,l.devicetype,l.logtype,l.smalllogtype  '

 SET @ParmDefinition =   
    N'@D1 INT = NULL,  
      @D2 INT = NULL,   
      @D3 INT = NULL,   
      @D4 INT = NULL,  
      @S1 varchar(50) = NULL,  
      @S2 varchar(50) = NULL,  
      @T1 DATETIME = NULL,   
      @T2 DATETIME = NULL';    
 
 Create table #RECORD(Kid int,Kname nvarchar(50),Devid nvarchar(50),
  devicetype int,logtype int,smalllogtype int, logcnt int)
  print @fromstring
 insert into #RECORD 
 EXEC SP_EXECUTESQL @fromstring,@ParmDefinition,
  @D1 = @kid,          
  @D2 = @devicetype, 
  @D3 = @logtype,
  @D4 = @smalllogtype,        
  @S1 = @devid,   
  @S2 = @kname,        
  @T1 = @bgntime,          
  @T2 = @endtime  
    
 --分页查询          
 exec sp_MutiGridViewByPager          
  @fromstring = ' #RECORD ',      --数据集          
  @selectstring =
  ' Kid,Kname,Devid,devicetype,logtype,smalllogtype,logcnt',      --查询字段          
  @returnstring =           
  ' Kid,Kname,Devid,devicetype,logtype,smalllogtype,logcnt',      --返回字段          
  @pageSize = @Size,                 --每页记录数          
  @pageNo = @page,                     --当前页          
  @orderString = ' Kid,Devid,devicetype,logtype ',          --排序条件          
  @IsRecordTotal = 1,             --是否输出总记录条数          
  @IsRowNo = 0           --是否输出行号          
        
 END 
GO
