USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Income_DEdit]    Script Date: 2014/11/24 23:20:50 ******/
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
CREATE PROC [dbo].[Income_DEdit] 
	@ID bigint,
	@kid int,
	@IncSigNo int,
	@BarCode varchar(50),
	@Num int,
	@Price Money,
	@type int,--0 新增 1修改 2删除
	@DoUserID int = 0
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Msg varchar(50) = '操作失败'	
	IF exists
		(
			select * 
				from Income_M m 
					Inner join Income_D d 
						on m.kid = d.kid 
						and m.IncSigNo = d.IncSigNo 
				where d.ID = @ID 
				AND m.IsCheck = 1
		) 
	BEGIN
		SELECT @ID = -1, @Msg = '已确认，不允许' + CASE @type WHEN 0 THEN '新增' WHEN 1 THEN '编辑' WHEN 2 THEN '删除' END
		GOTO Finish
	END
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'Income_DEdit' --设置上下文标志
	Begin tran   
	BEGIN TRY
		IF @type = 0
		begin
			INSERT INTO dbo.Income_D(kid,IncSigNo,BarCode,Num,Price)  
				SELECT @kid, @IncSigNo, @BarCode, @Num, @Price
			SELECT @ID =  ident_current('Income_D') , @Msg = '新增成功'		
		end
		ELSE IF @type = 1
		begin
			UPDATE Income_D
				SET	BarCode = @BarCode, 
						Num = @Num, 
						Price = @Price
				WHERE ID = @ID
			SET @Msg = '更新成功'	
		end
		ELSE IF @type = 2
		begin
			DELETE Income_D
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
	SELECT @ID ID, @Msg Msg
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑入库单明细表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_DEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_DEdit', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_DEdit', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'入库单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_DEdit', @level2type=N'PARAMETER',@level2name=N'@IncSigNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品条码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_DEdit', @level2type=N'PARAMETER',@level2name=N'@BarCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_DEdit', @level2type=N'PARAMETER',@level2name=N'@Num'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_DEdit', @level2type=N'PARAMETER',@level2name=N'@Price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 新增 1修改 2删除  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_DEdit', @level2type=N'PARAMETER',@level2name=N'@type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_DEdit', @level2type=N'PARAMETER',@level2name=N'@DoUserID'
GO
