USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[GetSiteConfigModelBySiteid]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetSiteConfigModelBySiteid]
@siteid int
AS
BEGIN
	declare @isyxt int

	select @isyxt=count(*) from appconfig..tem_kidapp where opkid=@siteid and appid=29
	select siteid,guestopen,@isyxt from kwebcms..site_config where siteid=@siteid
END



GO
