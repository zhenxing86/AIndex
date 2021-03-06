USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[T_class_Update]    Script Date: 2014/11/24 23:13:55 ******/
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
	--BEGIN TRANSACTION
	--DECLARE @kid int
	--SELECT @kid=kindergartenid FROM T_class WHERE id=@classid	

    IF NOT EXISTS(SELECT * FROM basicdata..personalize_class where cid=@classid)
    BEGIN
     INSERT INTO  basicdata..personalize_class values(@classid,@code)
    END
    ELSE
    BEGIN
      update  basicdata..personalize_class set code=@code where cid=@classid
    END
--	UPDATE [t_class] set [name]=@classname,shotname=@classname,code=@code where 

--id=@classid

	--IF((SELECT [dbo].[IsSyncKindergarten](@kid))=1)
	--BEGIN
	--	INSERT INTO [T_SyncClass]([classid],[action],[actiondatetime],[issync])
	--	VALUES (@classid,2,getdate(),0)
	--END	

	IF @@ERROR <> 0 
	BEGIN 
	   --ROLLBACK TRANSACTION 
	   RETURN(-1)
	END
	ELSE
	BEGIN
		--COMMIT TRANSACTION
	   RETURN (1)
	END





GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'T_class_Update', @level2type=N'PARAMETER',@level2name=N'@classid'
GO
