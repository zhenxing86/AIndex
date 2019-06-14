USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_GBApp_GrowthBook]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[rep_GBApp_GrowthBook]
@uid int
as

select gbid,gb.hbid,grade_name,term,gb.cellsetid,cellsettings,celltype from GBApp..GrowthBook gb
inner join GBApp..CellSet cs on cs.cellsetid=gb.cellsetid
where gb.userid=@uid
 


GO
