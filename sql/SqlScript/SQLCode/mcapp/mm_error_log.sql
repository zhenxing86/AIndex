USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mm_error_log]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*          
-- Author:     xie
-- Create date: 2014-06-20          
-- Description:  某段时间各异常日志总表      
-- Memo:            
exec mm_error_log '2014-6-1 00:00:00','2014-6-2 23:59:59'  
              
*/  
create PROCEDURE [dbo].[mm_error_log]               
@bgntime datetime=null,          
@endtime datetime=null              
 AS    
 BEGIN
	select logtype,smalllogtype,COUNT(1) logcnt from LogInfo_ex
	 where logtype<>8 and logtime>=@bgntime and logtime<=@endtime
	 group by logtype,smalllogtype
	 
   union all
   select logtype,smalllogtype,COUNT(1) logcnt from LogInfo_ex
	 where logtype=8 and smalllogtype=1 
	  and logtime>=@bgntime and logtime<=@endtime
	  and result<1.0
	 group by logtype,smalllogtype 
	 
	order by logtype,smalllogtype
 END    
GO
