USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_GBApp_celllist]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[rep_GBApp_celllist]
@gbid int
as

--普通版幼儿表现
select teacher_point,parent_point,teacher_word,parent_word,cellsettings,celltype from 
 GBApp..celllist cl 
left join GBApp..CellSet cs on cs.hbid=cl.hbid
where cl.gbid=@gbid



GO
