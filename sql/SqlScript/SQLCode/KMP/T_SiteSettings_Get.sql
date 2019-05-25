USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[T_SiteSettings_Get]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



create   PROCEDURE [dbo].[T_SiteSettings_Get]

AS
SET Transaction Isolation Level Read UNCOMMITTED


Select 
	top 1 ss.SettingsXML, ss.Disabled, ss.Version, ss.SettingsKey, ss.ApplicationName, ss.SettingsID, null as SiteUrl 
	FROM 
		T_SiteSettings ss
	ORDER BY ss.SettingsID asc









GO
