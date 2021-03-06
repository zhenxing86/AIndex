USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_log_file_record_GetListV2]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
author: xie    
altertime: 2014-09-16 17:40    
des: 获取待处理的晨检日志记录    
    
demo：   
mc_log_file_record_GetListV2 '2014-11-17 11:55:40',21   
*/    
  
CREATE proc [dbo].[mc_log_file_record_GetListV2]   
@lastdate datetime    
,@net int = 0     
as    
	update r
	 set r.ftype = 1    
	 output Deleted.id,Deleted.kid,Deleted.devid,Deleted.filepath,Deleted.[filename]  
	from ( select top (100) * from mc_log_file_record where ftype=0 and totalcnt>0 and net=@net and crtdate<=@lastdate   
	order by crtdate desc ) r 


GO
