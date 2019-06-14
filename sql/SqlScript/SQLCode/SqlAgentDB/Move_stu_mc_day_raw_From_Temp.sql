USE [SqlAgentDB]
GO
/****** Object:  StoredProcedure [dbo].[Move_stu_mc_day_raw_From_Temp]    Script Date: 2014/11/24 23:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--转移stu_mc_day_raw_temp to [stu_mc_day_raw] 表的数据
CREATE Procedure [dbo].[Move_stu_mc_day_raw_From_Temp]
as
Set Nocount On

Delete [mcapp].[dbo].[stu_mc_day_raw_Temp]
  Output Deleted.stuid, Deleted.card, Deleted.cdate, Deleted.tw, Deleted.zz, Deleted.ta, Deleted.toe, 
         Deleted.devid, Deleted.gunid, Deleted.kid, Deleted.Status, Deleted.adate, Deleted.sendtime
  Into [mcapp].[dbo].[stu_mc_day_raw]( stuid, card, cdate, tw, zz, ta, toe, devid, gunid, kid, Status, adate, sendtime)  


GO
