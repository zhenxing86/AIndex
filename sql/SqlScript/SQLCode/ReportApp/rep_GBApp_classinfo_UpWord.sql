USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_GBApp_classinfo_UpWord]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[rep_GBApp_classinfo_UpWord]
@hbid int,
@class_notice varchar(max)
as


update  GBApp..classinfo set class_notice=@class_notice
where hbid=@hbid




GO
