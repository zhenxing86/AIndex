USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Object_MEdit]    Script Date: 2014/11/24 23:20:50 ******/
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
CREATE PROC [dbo].[Object_MEdit] 
	@ID bigint,
	@kid int,
	@Name varchar(50),
	@SortCode varchar(10),
	@SortSubCode varchar(10),
	@Qty int,
	@WarnQty int,
	@Unit varchar(50),
	@Size varchar(50),
	@Price money,
	@type int,--0 新增 1修改 2删除
	@DoUserID int = 0
AS
BEGIN
	SET NOCOUNT ON
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'Object_MEdit' --设置上下文标志
	DECLARE @Msg varchar(50) = '操作失败'	
	Begin tran   
	BEGIN TRY
		IF @type = 0
		begin
			INSERT INTO Object_M(kid,  Name, SortCode, SortSubCode, Qty, WarnQty, Unit, Size, Price)     
				select	@kid, @Name, @SortCode, @SortSubCode, @Qty, @WarnQty, @Unit, @Size, @Price			
			SELECT @ID =  ident_current('Object_M') , @Msg = '新增成功'		
		end
		ELSE IF @type = 1
		begin
			UPDATE Object_M
				SET	Name = @Name,
						SortCode = @SortCode,
						SortSubCode = @SortSubCode,
						WarnQty = @WarnQty,
						Unit = @Unit,
						Size = @Size,
						Price = @Price
				WHERE ID = @ID
			SET @Msg = '更新成功'					
		end
		ELSE IF @type = 2
		begin
			DELETE Object_M
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑物品表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_MEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_MEdit', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_MEdit', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物品名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_MEdit', @level2type=N'PARAMETER',@level2name=N'@Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'大类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_MEdit', @level2type=N'PARAMETER',@level2name=N'@SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'小类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_MEdit', @level2type=N'PARAMETER',@level2name=N'@SortSubCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'库存数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_MEdit', @level2type=N'PARAMETER',@level2name=N'@Qty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'预警值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_MEdit', @level2type=N'PARAMETER',@level2name=N'@WarnQty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_MEdit', @level2type=N'PARAMETER',@level2name=N'@Unit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'规格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_MEdit', @level2type=N'PARAMETER',@level2name=N'@Size'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'单价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_MEdit', @level2type=N'PARAMETER',@level2name=N'@Price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 新增 1修改 2删除  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_MEdit', @level2type=N'PARAMETER',@level2name=N'@type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Object_MEdit', @level2type=N'PARAMETER',@level2name=N'@DoUserID'
GO
