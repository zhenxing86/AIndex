USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_GBApp_CellSetting]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE  PROCEDURE [dbo].[rep_GBApp_CellSetting]
@cellid int
as

--获取周次或者年月
select cellsettings,celltype 
from GBApp..CellSet where cellsetid=@cellid 




GO
