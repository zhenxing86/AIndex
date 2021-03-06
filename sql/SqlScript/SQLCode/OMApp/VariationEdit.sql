USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[VariationEdit]    Script Date: 2014/11/24 23:20:50 ******/
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
CREATE PROC [dbo].[VariationEdit]
	@kid INT, 
	@BarCode VARCHAR(50), 
	@UserID INT, --登记人
	@VarNum INT --盘点数量需带正负号
as
BEGIN
	SET NOCOUNT ON
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @UserID, @DoProc = 'VariationEdit' --设置上下文标志
	DECLARE @ID bigint = -1, @Msg varchar(50) = '操作失败'
	Begin tran   
	BEGIN TRY  
		INSERT INTO Variation(kid, BarCode, VarType, VarPlace, DutyUserID, CrtUserID, VarNum)     
		SELECT   @kid, @BarCode, 6, 0, @UserID, @UserID, @VarNum 
		SELECT @ID =  ident_current('Variation') , @Msg = '操作成功'		
		Commit tran                              
	End Try      
	Begin Catch   
		SELECT @ID = -1, @Msg = error_message()   
		Rollback tran   
	end Catch  
Finish:
	EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志     
	SELECT @ID ID, @Msg Msg
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑异动表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'VariationEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'VariationEdit', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品条码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'VariationEdit', @level2type=N'PARAMETER',@level2name=N'@BarCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'VariationEdit', @level2type=N'PARAMETER',@level2name=N'@UserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'异变数量（盘点数量需带正负号） ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'VariationEdit', @level2type=N'PARAMETER',@level2name=N'@VarNum'
GO
