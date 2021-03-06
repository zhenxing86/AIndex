USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Object_PicEdit]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-10-24
-- Description:	
-- Memo:	
EXEC Object_PicEdit @kid = 12511, @BarCode = '010010000005'	, @Title = 'xxx', @FileName = 'XXX.JPG' , @FilePath = '/XXX', @type = 0, @DoUserID = 123
EXEC Object_PicEdit @ID = 2, @Title = 'xxx1', @type = 1, @DoUserID = 123
EXEC Object_PicEdit @ID = 2, @type = 2, @DoUserID = 123
*/
CREATE PROC [dbo].[Object_PicEdit] 
	@ID bigint = 0,
	@kid int = 0, 
	@BarCode varchar(50) = '', 
	@Title varchar(50) = '', 
	@FileName varchar(50) = '', 
	@FilePath varchar(50) = '',
	@type int,--0 新增 1修改 2删除
	@DoUserID int = 0
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Msg varchar(50) = '操作失败'	,@url varchar(100)
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'Object_PicEdit' --设置上下文标志
	Begin tran   
	BEGIN TRY
		IF @type = 0
		begin
			INSERT INTO dbo.Object_Pic(kid,BarCode,Title,FileName,FilePath)  
				SELECT @kid,@BarCode,@Title,@FileName,@FilePath
			SELECT @ID =  ident_current('Object_Pic') , @Msg = '新增成功'		
		end
		ELSE IF @type = 1
		begin
			UPDATE Object_Pic
				SET	Title = @Title
				WHERE ID = @ID
			SET @Msg = '更新成功'	
		end
		ELSE IF @type = 2
		begin			
			select @url = FilePath + FileName from Object_Pic WHERE ID = @ID
			DELETE Object_Pic
				WHERE ID = @ID
			SET @Msg = '删除成功'		
		end
		Commit tran                              
	End Try      
	Begin Catch    
		SELECT @ID = -1, @Msg = error_message() 
		Rollback tran      
	end Catch  
	EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志  
Finish:   
	SELECT @ID ID, @Msg Msg,@url
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑物品图片表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_PicEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_PicEdit', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_PicEdit', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品条码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_PicEdit', @level2type=N'PARAMETER',@level2name=N'@BarCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_PicEdit', @level2type=N'PARAMETER',@level2name=N'@Title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_PicEdit', @level2type=N'PARAMETER',@level2name=N'@FileName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片路径' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_PicEdit', @level2type=N'PARAMETER',@level2name=N'@FilePath'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 新增 1修改 2删除  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_PicEdit', @level2type=N'PARAMETER',@level2name=N'@type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_PicEdit', @level2type=N'PARAMETER',@level2name=N'@DoUserID'
GO
