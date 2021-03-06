USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[T_class_Update]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：修改班级论坛内容 
--项目名称：ClassHomePage
--说明：
--时间：2009-2-19 17:09:59
------------------------------------
CREATE PROCEDURE [dbo].[T_class_Update]
@classid int,
@classgrade int,
@classname nvarchar(20),
@code nvarchar(200) 
 AS 
	BEGIN TRANSACTION
	DECLARE @kid int
	SELECT @kid=kindergartenid FROM T_class WHERE id=@classid	

	UPDATE [t_class] set [name]=@classname,shotname=@classname,code=@code where 
id=@classid

	IF((SELECT [dbo].[IsSyncKindergarten](@kid))=1)
	BEGIN
		INSERT INTO [T_SyncClass]([classid],[action],[actiondatetime],[issync])
		VALUES (@classid,2,getdate(),0)
	END	

	IF @@ERROR <> 0 
	BEGIN 
	   ROLLBACK TRANSACTION 
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN (1)
	END


GO
