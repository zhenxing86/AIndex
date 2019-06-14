USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[SiteAdd]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-7-28
-- Description:	新增站点
-- =============================================
CREATE PROCEDURE [dbo].[SiteAdd] 
@site_name nvarchar(50)
AS
IF EXISTS(SELECT * FROM sac_site WHERE site_name=@site_name)
RETURN 0
ELSE
INSERT INTO
     sac_site(site_name)
VALUES
    (@site_name)
RETURN @@IDENTITY



GO
