USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[RightGetListById]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		wuzy
-- Create date: 2010-08-04
-- Description:	根据id获得下级权限列表
-- =============================================
CREATE PROCEDURE [dbo].[RightGetListById]
@rightid int,
@siteid int,
@instanceid int
AS
BEGIN	  
    BEGIN
        SELECT [right_id],site_id,site_instance_id,up_right_id,right_name,right_code
        FROM sac_right WHERE up_right_id=@rightid and site_id=@siteid  and (site_instance_id=@instanceid or site_instance_id=0) order by right_id
    END
END
GO
