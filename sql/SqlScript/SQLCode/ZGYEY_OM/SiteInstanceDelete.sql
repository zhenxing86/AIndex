USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceDelete]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：删除站点实例 
--项目名称：Right
--建立人：麦
--说明:
--时间：2010-05-05
------------------------------------
CREATE PROCEDURE [dbo].[SiteInstanceDelete]
@site_instance_id int
 AS 
BEGIN

	DELETE from [sac_site_instance] WHERE site_instance_id=@site_instance_id --删除站点实例

    IF(@@ERROR<>0)
    BEGIN
	      RETURN (-1)
    END
    ELSE
    BEGIN
	      RETURN (1)
    END
end






GO
