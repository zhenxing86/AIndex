USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-13
-- Description:	注册站点
-- =============================================
CREATE PROCEDURE [dbo].[site_Add]
@name nvarchar(100) ,
@description nvarchar(600) ,
@address nvarchar(500) ,
@sitedns nvarchar(200) ,
@provice int ,
@city int ,
@contractname nvarchar(60) ,
@QQ nvarchar(40) ,
@phone nvarchar(60) 
AS
BEGIN
	BEGIN TRANSACTION

	INSERT INTO site([name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[accesscount],[status])
	VALUES(@name,@description,@address,@sitedns,@provice,@city,getDate(),@contractname,@QQ,@phone,0,1)

	INSERT INTO site_domain VALUES(@@IDENTITY,@sitedns)

	IF @@ERROR <> 0 
	BEGIN	
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN @@IDENTITY
	END
END







GO
