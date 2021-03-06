USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[syn_data_monthtohistory]    Script Date: 05/14/2013 14:54:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[syn_data_monthtohistory] '2013-01-01','2013-02-01'
CREATE PROCEDURE [dbo].[syn_data_monthtohistory]
@sday datetime,
@eday datetime

as

INSERT INTO [mcapp_history].[dbo].[stu_at_201301]
           ([stuid]
           ,[card]
           ,[cdate]
           ,[ctype]
           ,[adate])
     SELECT [stuid]
      ,[card]
      ,[cdate]
      ,[ctype]
      ,[adate]
  FROM [mcapp].[dbo].[stu_at_month]
where adate between @sday and @eday

delete from [stu_at_day] where adate between @sday and @eday

INSERT INTO [mcapp_history].[dbo].[stu_mc_201301]
           ([stuid]
           ,[card]
           ,[cdate]
           ,[tw]
           ,[zz]
           ,[adate])
     SELECT [stuid]
      ,[card]
      ,[cdate]
      ,[tw]
      ,[zz]
      ,[adate]
  FROM [mcapp].[dbo].[stu_mc_month]
where adate between @sday and @eday

delete from [stu_mc_month] where adate between @sday and @eday
GO
