USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Purchase_MEdit]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-10-24
-- Description:	
-- Memo:		
*/
CREATE PROC [dbo].[Purchase_MEdit] 
	@ID bigint,
	@kid int, 
	@FirUserid int, 
	@type int,--0 新增 2删除
	@DoUserID int = 0
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Msg varchar(50) = '操作失败'
	IF @type = 2 AND EXISTS(SELECT * FROM Purchase_M WHERE ID = @ID and Status <> 0) 
	BEGIN
		SELECT @ID = -1, @Msg = '申请已提交，不允许删除'
		GOTO Finish
	END
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'Purchase_MEdit' --设置上下文标志
	Begin tran   
	BEGIN TRY
		IF @type = 0
		begin
			INSERT INTO dbo.Purchase_M(kid, FirUserid)  
				SELECT @kid, @FirUserid
			SELECT @ID =  ident_current('Purchase_M') , @Msg = '新增成功'		
		end
		ELSE IF @type = 2
		begin
			DELETE Purchase_M
				WHERE ID = @ID
			SET @Msg = '删除成功'		
		end
		Commit tran                              
	End Try      
	Begin Catch     
		Rollback tran      
	end Catch  
	EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志  
Finish:   
	SELECT @ID ID, @Msg Msg
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑采购单主表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_MEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_MEdit', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_MEdit', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'建档人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_MEdit', @level2type=N'PARAMETER',@level2name=N'@FirUserid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 新增 1修改 2删除  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_MEdit', @level2type=N'PARAMETER',@level2name=N'@type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_MEdit', @level2type=N'PARAMETER',@level2name=N'@DoUserID'
GO
