USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_GBApp_advcelllist]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[rep_GBApp_advcelllist]
@gbid int
as

--高级版幼儿表现
select teacher_point,parent_point,al.teacher_word,al.parent_word,cellsettings,celltype,target from 
 GBApp..advcelllist al 
left join GBApp..CellSet cs on cs.hbid=al.hbid
left join GBApp..CellTarget ct on ct.hbid=al.hbid
where al.gbid=@gbid



GO
