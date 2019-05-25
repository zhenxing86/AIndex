USE [SqlAgentDB]
GO
/****** Object:  StoredProcedure [dbo].[Move_loginfo_From_Temp]    Script Date: 2014/11/24 23:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--转移loginfo_temp to [loginfo] 表的数据
create Procedure [dbo].[Move_loginfo_From_Temp]
as
Set Nocount On

Delete [mcapp].[dbo].[loginfo_Temp]
  Output Deleted.devid,Deleted.gunid,Deleted.logtype,Deleted.logmsg,Deleted.result,Deleted.logtime,Deleted.uploadtime,Deleted.kid,Deleted.ftype
  Into [mcapp].[dbo].[loginfo]( devid,gunid,logtype,logmsg,result,logtime,uploadtime,kid,ftype)  
GO
