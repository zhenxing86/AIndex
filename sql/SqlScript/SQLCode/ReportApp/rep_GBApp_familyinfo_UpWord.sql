USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_GBApp_familyinfo_UpWord]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[rep_GBApp_familyinfo_UpWord]
@gbid int,
@parent_word varchar(max)
as


update  GBApp..familyinfo set parent_word=@parent_word  
where gbid=@gbid




GO
