USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Income_MEdit]    Script Date: 2014/11/24 23:20:50 ******/
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
CREATE PROC [dbo].[Income_MEdit] 
	@ID bigint,
	@kid int, 
	@Userid int, 
	@PurSigNo int= null, 
	@type int--0 新增 2删除
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Msg varchar(50) = '操作失败', @IncSigNo int = -1
	IF @type = 2 AND EXISTS(SELECT * FROM Income_M WHERE ID = @ID and IsCheck = 1) 
	BEGIN
		SELECT @ID = -1, @Msg = '已确认，不允许删除'
		GOTO Finish
	END
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @Userid, @DoProc = 'Income_MEdit' --设置上下文标志
	Begin tran   
	BEGIN TRY
		IF @type = 0
		begin
			INSERT INTO dbo.Income_M(kid, FirUserid)  
				SELECT @kid, @Userid
			SELECT @ID =  ident_current('Income_M') , @Msg = '新增成功'		
		end
		ELSE IF @type = 2
		begin
			DELETE Income_M
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
	SELECT @IncSigNo = IncSigNo FROM Income_M WHERE ID = @ID
	SELECT @IncSigNo IncSigNo, @Msg Msg,  @ID ID
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑入库单主表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_MEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_MEdit', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_MEdit', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_MEdit', @level2type=N'PARAMETER',@level2name=N'@Userid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'采购单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_MEdit', @level2type=N'PARAMETER',@level2name=N'@PurSigNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 新增 1修改 2删除  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_MEdit', @level2type=N'PARAMETER',@level2name=N'@type'
GO
