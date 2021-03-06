USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Stock_DEdit]    Script Date: 2014/11/24 23:20:50 ******/
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
CREATE PROC [dbo].[Stock_DEdit] 
	@ID bigint,	
	@kid int,
	@StkSigNo int,
	@ObjectIDList varchar(max),
	@NewNum int,
	@type int,--0 新增 1修改 2删除
	@DoUserID int = 0
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Msg varchar(50) = '操作失败'	
	IF @type in(0,2) AND exists(select * from Stock_M where StkSigNo = @StkSigNo AND StkType in(0,1)) 
	BEGIN
		SELECT @ID = -1, @Msg = '按类别盘点，不允许' + CASE @type WHEN 0 THEN '新增' WHEN 2 THEN '删除' END
		GOTO Finish
	END	
	IF @type in(0,2) AND exists(select * from Stock_M where StkSigNo = @StkSigNo AND IsOnStock <> 0) 
	BEGIN
		SELECT @ID = -1, @Msg = '已开始盘点，不允许' + CASE @type WHEN 0 THEN '新增' WHEN 2 THEN '删除' END
		GOTO Finish
	END	
	IF @type = 1 AND exists (select * from Stock_M where StkSigNo = @StkSigNo AND IsCheck = 1) 
	BEGIN
		SELECT @ID = -1, @Msg = '盘点已确认，不允许编辑'
		GOTO Finish
	END	
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'Stock_DEdit' --设置上下文标志
	Begin tran   
	BEGIN TRY
		IF @type = 0
		begin			
			SELECT Col INTO #Col FROM CommonFun.dbo.f_split(@ObjectIDList,',')	
			INSERT INTO dbo.Stock_D(kid, StkSigNo, BarCode, OldNum)
			SELECT @kid, @StkSigNo, o.BarCode, o.Qty
				FROM Object_M o INNER JOIN #Col c ON o.ID = CAST(C.col AS INT)
				WHERE o.kid = @kid 
					AND NOT EXISTS(SELECT * FROM Stock_D WHERE kid = @kid and StkSigNo = @StkSigNo and BarCode = o.BarCode)
			SELECT @ID =  ident_current('Stock_D') , @Msg = '新增成功'		
			DROP TABLE #Col
		end
		ELSE IF @type = 1
		begin
			UPDATE Stock_D
				SET	NewNum = @NewNum
				WHERE ID = @ID
			SET @Msg = '更新成功'	
		end
		ELSE IF @type = 2
		begin
			DELETE Stock_D
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑盘点单明细表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Stock_DEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Stock_DEdit', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Stock_DEdit', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'盘点单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Stock_DEdit', @level2type=N'PARAMETER',@level2name=N'@StkSigNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品ID字串' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Stock_DEdit', @level2type=N'PARAMETER',@level2name=N'@ObjectIDList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Stock_DEdit', @level2type=N'PARAMETER',@level2name=N'@NewNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 新增 1修改 2删除  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Stock_DEdit', @level2type=N'PARAMETER',@level2name=N'@type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Stock_DEdit', @level2type=N'PARAMETER',@level2name=N'@DoUserID'
GO
