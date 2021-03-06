USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companycategory_Delete]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除一条商家分类记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-8-5 11:48:26
------------------------------------
CREATE PROCEDURE [dbo].[companycategory_Delete]
@companycategoryid int
 AS 
	DECLARE @companycount int
	SELECT @companycount=count(1) FROM company WHERE companycategoryid=@companycategoryid
	IF(@companycount=0)
	BEGIN
		DELETE [companycategory]
		 WHERE companycategoryid=@companycategoryid 
	END
	ELSE
	BEGIN
		RETURN (-2)
	END

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (1)
END
GO
