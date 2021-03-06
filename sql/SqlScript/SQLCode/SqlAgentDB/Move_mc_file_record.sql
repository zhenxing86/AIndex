USE [SqlAgentDB]
GO
/****** Object:  StoredProcedure [dbo].[Move_mc_file_record]    Script Date: 2014/11/24 23:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--转移mc_file_record to mc_file_record_History 表的数据
CREATE Procedure [dbo].[Move_mc_file_record]
as
Set Nocount On

Delete [mcapp].[dbo].[mc_file_record]
  Output Deleted.id,Deleted.kid,Deleted.devid,Deleted.filepath,Deleted.[filename],
	Deleted.crtdate,Deleted.startdate,Deleted.enddate,Deleted.ftype,Deleted.totalCnt,
	Deleted.succeedCnt,Deleted.errorCnt
  Into [mcapp].[dbo].[mc_file_record_History]( id,kid,devid,filepath,[filename],crtdate,startdate,enddate,ftype,totalCnt,succeedCnt,errorCnt)  
 where ftype>1


GO
