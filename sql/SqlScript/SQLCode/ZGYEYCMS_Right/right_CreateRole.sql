USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[right_CreateRole]    Script Date: 05/14/2013 14:58:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-6
-- Description:	创建角色
-- =============================================
CREATE PROCEDURE [dbo].[right_CreateRole]
@site_id int,
@site_instance_id int,
@role_name nvarchar(30)
AS
INSERT INTO sac_role(site_id,site_instance_id,role_name)
VALUES(@site_id,@site_instance_id,@role_name)
RETURN @@IDENTITY
GO
