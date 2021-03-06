USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_periodical_ADD]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加期刊 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-4-20 10:24:40
------------------------------------
CREATE PROCEDURE [dbo].[Manage_periodical_ADD]
@title nvarchar(50)
 AS 
	DECLARE @periodicalid int 
	INSERT INTO [periodical](
	[title],[createdatetime],[status]
	)VALUES(
	@title,getdate(),1
	)
	SET @periodicalid = @@IDENTITY

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (@periodicalid )
END
GO
