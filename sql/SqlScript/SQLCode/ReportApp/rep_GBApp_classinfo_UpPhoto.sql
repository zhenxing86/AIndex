USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_GBApp_classinfo_UpPhoto]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[rep_GBApp_classinfo_UpPhoto]
@hbid int,
@m_class_photo varchar(1000),
@net int
as


update  GBApp..classinfo set m_class_photo=@m_class_photo,net=@net  
where hbid=@hbid



GO
