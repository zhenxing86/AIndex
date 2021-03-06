USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[viewcount_Update]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：更新查看次数 
--项目名称：ServicePlatform
--说明：
--时间：2009-9-4 9:09:49
------------------------------------
CREATE PROCEDURE [dbo].[viewcount_Update]
@id int,
@viewtype int
 AS		
	IF(@viewtype=1)
	BEGIN
		UPDATE company SET viewcount=viewcount+1 WHERE companyid=@id
	END
	ELSE IF(@viewtype=2)
	BEGIN
		UPDATE product SET viewcount=viewcount+1 WHERE productid=@id
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
