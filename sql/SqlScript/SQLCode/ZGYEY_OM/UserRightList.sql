USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[UserRightList]    Script Date: 2014/11/24 23:34:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：选择用户权限 
--项目名称：Right
--说明：
--时间：2010-5-5
------------------------------------
CREATE PROCEDURE [dbo].[UserRightList]
@user_id int
AS 
BEGIN
	select distinct a.right_id,b.right_name from sac_role_right a inner join sac_right b on a.right_id=b.right_id where role_id in(
    select role_id from sac_user_role where [user_id]=@user_id)
END





GO
