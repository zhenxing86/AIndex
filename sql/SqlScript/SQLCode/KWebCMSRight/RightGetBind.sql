USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[RightGetBind]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途:  权限绑定
--项目名称：Right
--说明：
--时间：2010-3-31 17:49:11
------------------------------------
CREATE PROCEDURE [dbo].[RightGetBind]
 AS
SELECT 	right_id,right_name 
FROM [sac_right]
WHERE site_instance_id=0
GO
