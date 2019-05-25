USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[supplyanddemand_Delete]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：删除一条供求记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-8-26 15:00:28
------------------------------------
CREATE PROCEDURE [dbo].[supplyanddemand_Delete]
@supplyanddemandid int
 AS 
--	DELETE [supplyanddemand]
--	 WHERE supplyanddemandid=@supplyanddemandid 
	UPDATE supplyanddemand SET status=-1 WHERE supplyanddemandid=@supplyanddemandid

	IF(@@ERROR<>0)
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END

GO
