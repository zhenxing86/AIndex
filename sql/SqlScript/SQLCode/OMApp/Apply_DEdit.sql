USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Apply_DEdit]    Script Date: 2014/11/24 23:20:50 ******/
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
CREATE PROC [dbo].[Apply_DEdit] 
	@ID bigint,
	@kid int = 0,
	@AppSigNo int = 0,
	@BarCode varchar(50) = '',
	@Num int = 0,
	@BadNum int = 0,
	@LoseNum int = 0,
	@ReturnNum int = 0,
	@type int,--0 新增 1修改 2删除 3归还
	@DoUserID int = 0
AS
BEGIN
	SET NOCOUNT ON
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'Apply_DEdit' --设置上下文标志
	DECLARE @Msg varchar(50) = '操作失败'	
	IF @kid = 0
	SELECT @kid = kid from Apply_D where ID = @ID
	IF @type = 0 
	IF exists(select * from Apply_M WHERE kid = @kid and AppSigNo = @AppSigNo AND Status > 0) 
	BEGIN
		SELECT @ID = -1, @Msg = '申请已提交，不允许新增'	GOTO Finish
	END
	IF @type = 1 
	IF exists(
		select * from Apply_M m 
			inner join Apply_D d 
				on d.ID = @ID 
				and m.kid = d.kid 
				and m.AppSigNo = d.AppSigNo 
				AND m.Status > 0 
				and d.Num <> @Num) 
	BEGIN
		SELECT @ID = -1, @Msg = '申请已提交，不允许修改数量' GOTO Finish
	END
	IF @type = 3
	BEGIN 
		IF exists(select * from Apply_M m inner join Apply_D d on d.ID = @ID and m.kid = d.kid and m.AppSigNo = d.AppSigNo AND m.Status < 5 )
		BEGIN
			SELECT @ID = -1, @Msg = '物品未出库，不允许做归还操作' GOTO Finish
		END
		IF CommonFun.dbo.GetRight(@kid,@DoUserID,'物品管理员') = 0
		BEGIN
			SELECT @ID = -1, @Msg = '您需要拥有物品管理员权限，才可以做归还操作' GOTO Finish
		END
		IF exists(select * from Apply_D where ID = @ID AND IsReturn = 1) 
		BEGIN
			SELECT @ID = -1, @Msg = '物品已归还完毕，不允许操作'	GOTO Finish
		END		
	END
	IF @type = 2 
	IF exists(select * from Apply_M m inner join Apply_D d on d.ID = @ID and m.kid = d.kid and m.AppSigNo = d.AppSigNo AND m.Status > 0) 
	BEGIN
		SELECT @ID = -1, @Msg = '申请已提交，不允许删除'	GOTO Finish
	END
	Begin tran   
	BEGIN TRY
		IF @type = 0
		begin
			INSERT INTO dbo.Apply_D(kid, AppSigNo, BarCode, Num)  
				SELECT @kid, @AppSigNo, @BarCode, @Num
			SELECT @ID =  ident_current('Apply_D') , @Msg = '新增成功'		
		end
		ELSE IF @type = 1
		begin
			UPDATE Apply_D
				SET	BarCode = @BarCode, 
						Num = @Num
				WHERE ID = @ID
			SET @Msg = '更新成功'	
		end
		ELSE IF @type = 3
		begin
			UPDATE Apply_D
				SET	BadNum = BadNum + ISNULL(@BadNum,0),
						LoseNum = LoseNum + ISNULL(@LoseNum,0),
						ReturnNum = ReturnNum + ISNULL(@ReturnNum,0)
				WHERE ID = @ID
			SET @Msg = '归还成功'	
		end
		ELSE IF @type = 2
		begin
			DELETE Apply_D
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
	SELECT @ID ID, @Msg Msg
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑领用（借用）明细表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_DEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_DEdit', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_DEdit', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'申请单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_DEdit', @level2type=N'PARAMETER',@level2name=N'@AppSigNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品条码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_DEdit', @level2type=N'PARAMETER',@level2name=N'@BarCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_DEdit', @level2type=N'PARAMETER',@level2name=N'@Num'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'损坏数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_DEdit', @level2type=N'PARAMETER',@level2name=N'@BadNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'遗失数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_DEdit', @level2type=N'PARAMETER',@level2name=N'@LoseNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'归还数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_DEdit', @level2type=N'PARAMETER',@level2name=N'@ReturnNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 新增 1修改 2删除  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_DEdit', @level2type=N'PARAMETER',@level2name=N'@type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_DEdit', @level2type=N'PARAMETER',@level2name=N'@DoUserID'
GO
