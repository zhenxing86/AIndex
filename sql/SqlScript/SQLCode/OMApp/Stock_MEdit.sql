USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Stock_MEdit]    Script Date: 2014/11/24 23:20:50 ******/
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
CREATE PROC [dbo].[Stock_MEdit] 
	@ID bigint,
	@kid int, 
	@FirUserid int,
	@StkType int, 
	@SortCode varchar(10), 
	@SortSubCode varchar(10), 
	@type int,--0 新增 2删除
	@DoUserID int = 0
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Msg varchar(50) = '操作失败'
	IF @type = 2 AND EXISTS(SELECT * FROM Stock_M WHERE ID = @ID and IsOnStock <> 0) 
	BEGIN
		SELECT @ID = -1, @Msg = '申请已提交，不允许删除'
		GOTO Finish
	END
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'Stock_MEdit' --设置上下文标志
	Begin tran   
	BEGIN TRY
		IF @type = 0
		begin
			INSERT INTO dbo.Stock_M(kid, FirUserid, StkType)  
				SELECT @kid, @FirUserid, @StkType
			SELECT @ID =  ident_current('Stock_M') , @Msg = '新增成功'	
		IF @StkType = 0
			INSERT INTO dbo.Stock_D(kid, StkSigNo, BarCode, OldNum)
			SELECT @kid, @ID, o.BarCode, o.Qty
				FROM Object_M o
				WHERE o.kid = @kid 
					and o.SortCode = @SortCode    
		ELSE IF @StkType = 1
			INSERT INTO dbo.Stock_D(kid, StkSigNo, BarCode, OldNum)
			SELECT @kid, @ID, o.BarCode, o.Qty
				FROM Object_M o
				WHERE o.kid = @kid 
					and o.SortCode = @SortCode    
					and o.SortSubCode = @SortSubCode  
		end
		ELSE IF @type = 2
		begin
			DELETE Stock_M
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑盘点单主表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Stock_MEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Stock_MEdit', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Stock_MEdit', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'建档人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Stock_MEdit', @level2type=N'PARAMETER',@level2name=N'@FirUserid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'盘点类型(0按大类、1按小类、2按物品)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Stock_MEdit', @level2type=N'PARAMETER',@level2name=N'@StkType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'大类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Stock_MEdit', @level2type=N'PARAMETER',@level2name=N'@SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'小类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Stock_MEdit', @level2type=N'PARAMETER',@level2name=N'@SortSubCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 新增 1修改 2删除  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Stock_MEdit', @level2type=N'PARAMETER',@level2name=N'@type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Stock_MEdit', @level2type=N'PARAMETER',@level2name=N'@DoUserID'
GO
