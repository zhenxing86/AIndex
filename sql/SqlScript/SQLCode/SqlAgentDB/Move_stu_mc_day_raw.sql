USE [SqlAgentDB]
GO
/****** Object:  StoredProcedure [dbo].[Move_stu_mc_day_raw]    Script Date: 2014/11/24 23:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--转移stu_mc_day_raw表的数据
Create Procedure [dbo].[Move_stu_mc_day_raw]
as
Set Nocount On

Delete [mcapp].[dbo].[stu_mc_day_raw]
  Output Deleted.ID, Deleted.stuid, Deleted.card, Deleted.cdate, Deleted.tw, Deleted.zz, Deleted.ta, Deleted.toe, 
         Deleted.devid, Deleted.gunid, Deleted.kid, Deleted.Status, Deleted.adate, Deleted.sendtime
  Into [mcapp].[dbo].[stu_mc_day_raw_history](ID, stuid, card, cdate, tw, zz, ta, toe, devid, gunid, kid, Status, adate, sendtime)
  Where cdate < Dateadd(mm, -1, Getdate()) and Status = 1 


GO
