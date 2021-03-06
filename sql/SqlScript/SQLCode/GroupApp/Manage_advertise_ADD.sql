USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_advertise_ADD]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：增加广告 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-1-27 15:25:27
------------------------------------
CREATE PROCEDURE [dbo].[Manage_advertise_ADD]
@titile nvarchar(50),
@links nvarchar(300),
@filepath nvarchar(200),
@filename nvarchar(50),
@position int,
@filetype int,
@isshow int,
@begintime datetime,
@endtime datetime

 AS 
	BEGIN TRANSACTION

	DECLARE @advertiseid INT
	DECLARE @orderno INT 
--	SELECT @orderno=count(1) FROM advertise WHERE position=@position
	UPDATE advertise SET orderno=orderno+1 WHERE position=@position and status=1

	INSERT INTO [advertise](
	[titile],[links],[filepath],[filename],[position],[filetype],[isshow],[orderno],[status],[begintime],[endtime],[createdatetime]
	)VALUES(
	@titile,@links,@filepath,@filename,@position,@filetype,@isshow,1,1,@begintime,@endtime,getdate()
	)
	SET @advertiseid = @@IDENTITY

IF(@@ERROR<>0)
BEGIN
	ROLLBACK TRANSACTION
	RETURN (-1)
END
ELSE
BEGIN
	COMMIT TRANSACTION
	RETURN (@advertiseid)
END




GO
