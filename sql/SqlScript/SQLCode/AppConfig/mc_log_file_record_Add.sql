USE [AppConfig]
GO
/****** Object:  StoredProcedure [dbo].[mc_log_file_record_Add]    Script Date: 2014/11/24 21:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[mc_log_file_record_Add]   
@kid int  
,@devid nvarchar(50)  
,@filepath nvarchar(100)  
,@filename nvarchar(100)  
,@totalcnt int  
as  
  
insert into mc_log_file_record(kid,devid,filepath,[filename],totalcnt)  
 values(@kid,@devid,@filepath,@filename,@totalcnt)  
   
 if @@ERROR<>0  
 return -1  
 else   
 return 1  
GO
