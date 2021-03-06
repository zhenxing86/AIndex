USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Apply_MEdit]    Script Date: 2014/11/24 23:20:50 ******/
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
CREATE PROC [dbo].[Apply_MEdit] 
	@ID bigint,
	@kid int = null,
	@AppType int = null, --申请类型(1借用,2领用)
	@Title varchar(50) = null, 
	@FirUserid int = null, 
	@cid int = null, 
	@Memo varchar(200) = null,
	@RetDate datetime = null,
	@type int,--0 新增 1修改 2删除
	@DoUserID int = 0
AS
BEGIN
	SET NOCOUNT ON
	IF @RetDate = '1900-01-01' SET @RetDate = NULL
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'Apply_MEdit' --设置上下文标志
	DECLARE @Msg varchar(50) = '操作失败', @Status int, @AppSigNo int = -1
	IF @type <> 0
		SELECT @Status = Status from Apply_M where ID = @ID
	IF @type <> 0 AND @Status <> 0 
	BEGIN
		SELECT @ID = -1, @Msg = '申请已提交，不允许' + CASE @type WHEN 1 THEN '编辑' WHEN 2 THEN '删除' END
		GOTO Finish
	END
	Begin tran   
	BEGIN TRY
		IF @type = 0
		begin
			INSERT INTO dbo.Apply_M(kid, AppType, Title, FirUserid, cid, Memo, RetDate)  
				SELECT @kid, @AppType, @Title, @FirUserid, @cid, @Memo, @RetDate
			SELECT @ID =  ident_current('Apply_M') , @Msg = '提交申请成功'		
		end
		ELSE IF @type = 1
		begin
			UPDATE Apply_M
				SET	Title = @Title, 
						cid = @cid, 
						Memo = @Memo, 
						RetDate = @RetDate
				WHERE ID = @ID
			SET @Msg = '更新成功'	
		end
		ELSE IF @type = 2
		begin
			DELETE Apply_M
				WHERE ID = @ID
			SET @Msg = '删除成功'		
		end
		Commit tran                              
	End Try      
	Begin Catch  
		SELECT @ID = -1, @Msg = error_message()   
		Rollback tran      
	end Catch  
Finish:
	EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志    
	select @AppSigNo = AppSigNo	from Apply_M where ID = @ID
	SELECT @ID ID, @Msg Msg, @AppSigNo AppSigNo
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑领用（借用）主表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MEdit', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MEdit', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'申请类型(1借用,2领用)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MEdit', @level2type=N'PARAMETER',@level2name=N'@AppType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MEdit', @level2type=N'PARAMETER',@level2name=N'@Title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'建档人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MEdit', @level2type=N'PARAMETER',@level2name=N'@FirUserid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MEdit', @level2type=N'PARAMETER',@level2name=N'@cid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MEdit', @level2type=N'PARAMETER',@level2name=N'@Memo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'归还时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MEdit', @level2type=N'PARAMETER',@level2name=N'@RetDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 新增 1修改 2删除  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MEdit', @level2type=N'PARAMETER',@level2name=N'@type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MEdit', @level2type=N'PARAMETER',@level2name=N'@DoUserID'
GO
