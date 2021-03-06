USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[UserAdd]    Script Date: 2014/11/24 23:34:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：增加用户
--项目名称：Right
--建立人:麦
--说明：
--时间：2010-5-5
------------------------------------
CREATE PROCEDURE [dbo].[UserAdd]
@account nvarchar(30),
@password nvarchar(64),
@username nvarchar(30),
@org_id int,
@status int
 AS
	INSERT INTO [sac_user](
	[account],[password],[username],[createdatetime],[org_id],[status]
	)VALUES(
	@account,@password,@username,getdate(),@org_id,@status
	) 
    IF(@@ERROR<>0)
    BEGIN
	      RETURN (-1)
    END
    ELSE
    BEGIN
	      RETURN @@IDENTITY
    END


GO
