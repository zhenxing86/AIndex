USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[site_instanceCheck]    Script Date: 05/14/2013 14:58:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-3
-- Description:	站点实例查询
-- =============================================
CREATE PROCEDURE [dbo].[site_instanceCheck]
@site_id int,
@site_instance_name nvarchar(50)
AS
SELECT
   site_instance_id,site_instance_name
FROM
   sac_site_instance
WHERE
   site_id=@site_id AND 
   site_instance_name like '%'+@site_instance_name+'%'
GO
