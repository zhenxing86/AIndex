USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_viewcount_Update]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：更新查看次数 
--项目名称：ServicePlatformManage
--说明：
--时间：2009-9-4 9:09:49
------------------------------------
CREATE PROCEDURE [dbo].[Manage_viewcount_Update]
@id int,
@viewtype int,
@viewcount int
 AS		
	IF(@viewtype=1)
	BEGIN
		UPDATE company SET viewcount=@viewcount WHERE companyid=@id
	END
	ELSE IF(@viewtype=2)
	BEGIN
		UPDATE product SET viewcount=@viewcount WHERE productid=@id
	END

	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN	
	   RETURN (1)
	END


GO
