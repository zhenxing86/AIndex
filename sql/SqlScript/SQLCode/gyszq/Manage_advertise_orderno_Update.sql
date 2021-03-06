USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_advertise_orderno_Update]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改广告排序 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-1-27 15:25:27
------------------------------------
CREATE PROCEDURE [dbo].[Manage_advertise_orderno_Update]
@advertiseid int,
@order int
 AS 
	BEGIN TRANSACTION	
	DECLARE @currentorderno INT
	DECLARE @currentposition INT
	DECLARE @nextorderno INT
	DECLARE @nextadvertiseid INT
	SELECT @currentorderno=orderno,@currentposition=position FROM advertise WHERE advertiseid=@advertiseid

	DECLARE @maxorderno INT
	DECLARE @minorderno INT
	SELECT @maxorderno=max(orderno),@minorderno=min(orderno) FROM advertise WHERE position=@currentposition AND status=1
	IF((@order=-1 and @currentorderno=@minorderno) or (@order=1 and @currentorderno=@maxorderno))
	BEGIN
		COMMIT TRANSACTION 
		RETURN (-2)
	END
	ELSE
	BEGIN
		SET @nextorderno=@currentorderno+@order
		SELECT @nextadvertiseid=advertiseid FROM advertise WHERE position=@currentposition and orderno=@nextorderno
		UPDATE advertise SET orderno=@nextorderno WHERE advertiseid=@advertiseid
		UPDATE advertise SET orderno=@currentorderno WHERE advertiseid=@nextadvertiseid
	END

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
