USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_log_file_record_Update]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[mc_log_file_record_Update]  
@id bigint  
,@ftype int  
,@startdate datetime  
,@enddate datetime  
,@succeedcnt int=0  
,@errorcnt int=0  
as  
  
update mc_log_file_record  
 set ftype=@ftype,startdate=@startdate,enddate=@enddate,  
  succeedcnt=case when @succeedcnt+@errorcnt>0 then @succeedcnt else succeedcnt end,  
  errorcnt=case when @succeedcnt+@errorcnt>0 then @errorcnt else errorcnt end  
 where id = @id  
  
 if @@ERROR<>0  
 return -1  
 else   
 return 1 
GO
