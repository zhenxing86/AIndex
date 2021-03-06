USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[company_image_Update]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改商家图片 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 9:09:49
------------------------------------
CREATE PROCEDURE [dbo].[company_image_Update]
@companyid int,
@imagepath nvarchar(200),
@imagename nvarchar(100)
 AS 
	UPDATE company SET 
	[imagepath]=@imagepath,[imagename]=@imagename
	WHERE companyid=@companyid

	IF @@ERROR <> 0 
	BEGIN
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN(1)
	END

GO
