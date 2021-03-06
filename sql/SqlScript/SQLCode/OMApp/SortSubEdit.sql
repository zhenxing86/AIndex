USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[SortSubEdit]    Script Date: 2014/11/24 23:20:50 ******/
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
CREATE PROC [dbo].[SortSubEdit] 
	@ID bigint,
	@kid int,
	@SortCode varchar(10),
	@SortSubCode varchar(10),
	@Title varchar(50),
	@type int,--0 新增 1修改 2删除
	@DoUserID int = 0
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Msg varchar(50) = '操作失败'
	IF @type = 2 AND exists(
		select * 
			from Object_M o 
				inner join SortSub ss on o.kid = ss.kid and o.SortCode = ss.SortCode and o.SortSubCode = ss.SortSubCode 
			where ss.ID = @ID) 
	BEGIN
		SELECT @ID = -1, @Msg = '存在该小类物品，不允许删除'
		GOTO Finish
	END 
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'SortSubEdit' --设置上下文标志
	Begin tran   
	BEGIN TRY
		IF @type = 0
		begin
			INSERT INTO SortSub(kid, SortCode, Title)
				SELECT @kid, @SortCode, @Title		
			IF @@ROWCOUNT > 0
			SELECT @ID = ident_current('SortSub'), @Msg = '新增成功'		
		end
		ELSE IF @type = 1
		begin
			UPDATE SortSub
				SET Title = @Title
				WHERE ID = @ID
			IF @@ROWCOUNT > 0
			SET @Msg = '更新成功'		
		end
		ELSE IF @type = 2
		begin
			DELETE SortSub
				WHERE ID = @ID
			IF @@ROWCOUNT > 0
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑小类表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortSubEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortSubEdit', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortSubEdit', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'大类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortSubEdit', @level2type=N'PARAMETER',@level2name=N'@SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'小类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortSubEdit', @level2type=N'PARAMETER',@level2name=N'@SortSubCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortSubEdit', @level2type=N'PARAMETER',@level2name=N'@Title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 新增 1修改 2删除  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortSubEdit', @level2type=N'PARAMETER',@level2name=N'@type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortSubEdit', @level2type=N'PARAMETER',@level2name=N'@DoUserID'
GO
