USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[T_SiteSettings_Save]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

--Select * FROM T_SiteSettings

create  procedure [dbo].[T_SiteSettings_Save]
(
	@Disabled		smallint,
	@SettingsXML	 	ntext = null,
	@ApplicationName	nvarchar(256),
	@SettingsID 		int
)
AS
SET Transaction Isolation Level Read UNCOMMITTED
BEGIN
		UPDATE
			T_SiteSettings
		SET
			Disabled = @Disabled,
			SettingsXML = @SettingsXML,
			ApplicationName = @ApplicationName
		WHERE
			SettingsID  = @SettingsID
END

















GO
