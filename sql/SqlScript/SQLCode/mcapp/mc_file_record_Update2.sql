USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_file_record_Update2]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
/*  
author: xie  
altertime: 2014-09-16 17:40  
des: 将晨检数据上传到服务器后，将记录待处理记录  
  
demo：  
*/  
  
CREATE proc [dbo].[mc_file_record_Update2]   
@kid int  
,@devid nvarchar(50)  
,@filepath nvarchar(100)  
,@filename nvarchar(100)  
,@totalcnt int=0  
,@crtdate datetime =null
as  
 
if @crtdate is null
 set @crtdate = GETDATE()
insert into mc_file_record(kid,devid,filepath,[filename],totalcnt,crtdate)  
 values(@kid,@devid,@filepath,@filename,@totalcnt,@crtdate)  
   
 if @@ERROR<>0  
 return -1  
 else   
 return 1  
GO
