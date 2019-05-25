use mcapp
go
      
author xie      
altertime 2014-09-16 1740      
des 获取待处理的晨检日志记录      
      
demo：     
mc_log_file_record_GetListV2 '2014-11-17 115540',21     
      
    
CREATE proc mc_log_file_record_GetListV2BJ     
@lastdate datetime      
,@net int = 0       
as      
 update r  
  set r.ftype = 1      
  output Deleted.id,Deleted.kid,Deleted.devid,Deleted.filepath,Deleted.[filename]    
 from ( select top (100)  from mc_log_file_recordBJ where ftype=0 and totalcnt0 and net=@net and crtdate=@lastdate     
 order by crtdate desc ) r   