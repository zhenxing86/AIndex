USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Purchase_DEdit]    Script Date: 2014/11/24 23:20:50 ******/
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
CREATE PROC [dbo].[Purchase_DEdit] 
	@ID bigint,	
	@kid int,
	@PurSigNo int,
	@SortCode varchar(10),
	@SortSubCode varchar(10),
	@Name varchar(50),
	@BarCode varchar(50),
	@PurNum int,
	@Memo varchar(50),
	@type int,--0 新增 1修改 2删除
	@DoUserID int = 0
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Msg varchar(50) = '操作失败'	
	IF @type <> 0 
		AND exists
		(
			select * 
				from Purchase_M m 
					Inner join Purchase_D d 
						on m.kid = d.kid 
						and m.PurSigNo = d.PurSigNo 
				where d.ID = @ID 
				AND m.Status <> 0
		) 
	BEGIN
		SELECT @ID = -1, @Msg = '申请已提交，不允许' + CASE @type WHEN 1 THEN '编辑' WHEN 2 THEN '删除' END
		GOTO Finish
	END	
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'Purchase_DEdit' --设置上下文标志
	Begin tran   
	BEGIN TRY
		IF @type = 0
		begin		
			INSERT INTO dbo.Purchase_D(kid, PurSigNo, SortCode, SortSubCode, Name, BarCode, PurNum, Memo)  
				SELECT @kid, @PurSigNo, @SortCode, @SortSubCode, @Name, @BarCode, @PurNum, @Memo
			SELECT @ID =  ident_current('Purchase_D') , @Msg = '新增成功'		
		end
		ELSE IF @type = 1
		begin
			UPDATE Purchase_D
				SET	@SortCode = @SortCode, 
						@SortSubCode = @SortSubCode, 
						@Name = @Name, 
						@BarCode = @BarCode, 
						@PurNum = @PurNum, 
						@Memo = @Memo
				WHERE ID = @ID
			SET @Msg = '更新成功'	
		end
		ELSE IF @type = 2
		begin
			DELETE Purchase_D
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑采购单明细表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_DEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_DEdit', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_DEdit', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'采购单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_DEdit', @level2type=N'PARAMETER',@level2name=N'@PurSigNo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'大类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_DEdit', @level2type=N'PARAMETER',@level2name=N'@SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'小类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_DEdit', @level2type=N'PARAMETER',@level2name=N'@SortSubCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_DEdit', @level2type=N'PARAMETER',@level2name=N'@Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品条码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_DEdit', @level2type=N'PARAMETER',@level2name=N'@BarCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'采购数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_DEdit', @level2type=N'PARAMETER',@level2name=N'@PurNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_DEdit', @level2type=N'PARAMETER',@level2name=N'@Memo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 新增 1修改 2删除  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_DEdit', @level2type=N'PARAMETER',@level2name=N'@type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Purchase_DEdit', @level2type=N'PARAMETER',@level2name=N'@DoUserID'
GO
