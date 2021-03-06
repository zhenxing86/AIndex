USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_commoncompany_Delete]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除品牌商家 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-2-1 16:29:55
------------------------------------
CREATE PROCEDURE [dbo].[Manage_commoncompany_Delete]
@commoncompanyid int,
@commonproductcategoryid int
 AS 
	BEGIN TRANSACTION
--	DECLARE @commonproductcategoryid INT
	DECLARE @currentorderno INT
	SELECT @currentorderno=orderno FROM commoncompany WHERE commoncompanyid=@commoncompanyid and commonproductcategoryid=@commonproductcategoryid and status=1
	UPDATE [commoncompany] SET orderno=orderno-1 WHERE commonproductcategoryid=@commonproductcategoryid and status=1 and orderno>@currentorderno
	UPDATE [commoncompany] SET status=-1 WHERE commoncompanyid=@commoncompanyid and commonproductcategoryid=@commonproductcategoryid 
IF(@@ERROR<>0)
BEGIN
	ROLLBACK TRANSACTION
	RETURN (-1)
END
ELSE
BEGIN
	COMMIT TRANSACTION
	RETURN (1)
END
GO
