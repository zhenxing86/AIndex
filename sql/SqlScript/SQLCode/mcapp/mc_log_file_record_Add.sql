USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_log_file_record_Add]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
author: xie  
altertime: 2014-09-16 17:40  
des: 新增晨检日志记录  
demo：  

*/  
CREATE proc [dbo].[mc_log_file_record_Add]   
@kid int  
,@devid nvarchar(50)  
,@filepath nvarchar(100)  
,@filename nvarchar(100)  
,@totalcnt int  
,@crtdate datetime=null
,@net int=0   
as  
  
insert into mc_log_file_record(kid,devid,filepath,[filename],totalcnt,crtdate,net)      
 values(@kid,@devid,@filepath,@filename,@totalcnt,@crtdate,@net) 
   
 if @@ERROR<>0  
 return -1  
 else   
 return 1  
 

GO
