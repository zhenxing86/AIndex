USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_log_file_record_GetList]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[mc_log_file_record_GetList]  
as  
  
update mc_log_file_record   
 set ftype = 1  
 output Deleted.id,Deleted.kid,Deleted.devid,Deleted.filepath,Deleted.[filename]  
where ftype=0  
GO
