USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[RightGetList]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		麦
-- Create date: 2009-01-13
-- Description:	获得权限列表
-- =============================================
CREATE PROCEDURE [dbo].[RightGetList]
AS
BEGIN	  
    BEGIN
        SELECT [right_id],site_id,site_instance_id,up_right_id,right_name,right_code
        FROM sac_right
    END
END
GO
