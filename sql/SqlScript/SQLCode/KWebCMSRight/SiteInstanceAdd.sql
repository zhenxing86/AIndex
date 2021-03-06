USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceAdd]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-8-14
-- Description:	添加站点实例
-- =============================================
CREATE PROCEDURE [dbo].[SiteInstanceAdd]
@org_id int,
@site_id int,
@site_instance_name nvarchar(50),
@personalized int
 AS
BEGIN
    DECLARE @site_instance_id int
	INSERT INTO sac_site_instance(
	org_id,site_id,site_instance_name,personalized
	)VALUES(
	@org_id,@site_id,@site_instance_name,@personalized
	)
	SET @site_instance_id = @@IDENTITY

    IF(@@ERROR<>0)
    BEGIN
	    RETURN (-1)
    END
    ELSE
    BEGIN
	    RETURN (@site_instance_id)
    END
END
GO
