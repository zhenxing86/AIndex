USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companycategory_ADD]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加一条公司分类记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-8-5 11:48:26
------------------------------------
CREATE PROCEDURE [dbo].[companycategory_ADD]
@title nvarchar(50),
@description nvarchar(200),
@source int,
@parentid int

 AS 
	DECLARE @categorycount int
	DECLARE @orderno int
	SELECT @categorycount=count(1) FROM companycategory 
	SET @orderno=@categorycount+1

	INSERT INTO [companycategory](
	[title],[description],[source],[orderno],[companycount],[createdate],[parentid]
	)VALUES(
	@title,@description,@source,@orderno,0,getdate(),@parentid
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
