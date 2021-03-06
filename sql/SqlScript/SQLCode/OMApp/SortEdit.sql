USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[SortEdit]    Script Date: 2014/11/24 23:20:50 ******/
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
CREATE PROC [dbo].[SortEdit] 
	@ID bigint,
	@kid int,
	@SortCode varchar(10),
	@Title varchar(50),
	@IsConsum bit = 0,
	@Audit bit = 0,
	@type int,--0 新增 1修改 2删除
	@DoUserID int = 0
AS
BEGIN
	SET NOCOUNT ON
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'SortEdit' --设置上下文标志
	DECLARE @Msg varchar(50) = '操作失败'	
	IF @type = 2 AND exists(select * from Object_M o inner join Sort s on o.kid = s.kid and o.SortCode = s.SortCode where s.ID = @ID)   
	BEGIN  
		SELECT @ID = -1, @Msg = '存在该大类物品，不允许删除'  
		GOTO Finish  
	END  
	IF @type = 2 AND exists(select * from Sort s inner join SortSub ss on s.kid = ss.kid and s.SortCode = ss.SortCode
			where s.ID = @ID) 
	BEGIN
		SELECT @ID = -1, @Msg = '存在小类，不允许删除'
		GOTO Finish
	END  
	Begin tran   
	BEGIN TRY
		IF @type = 0
		begin
			INSERT INTO Sort(kid, Title, IsConsum, Audit)
				SELECT @kid, @Title, @IsConsum, @Audit	
			IF @@ROWCOUNT > 0
			SELECT @ID = ident_current('Sort'), @Msg = '新增成功'	
		end
		ELSE IF @type = 1
		begin
			UPDATE Sort
				SET Title = @Title,
						IsConsum = @IsConsum, 
						Audit = @Audit
				WHERE ID = @ID
			IF @@ROWCOUNT > 0
			SET @Msg = '更新成功'		
		end
		ELSE IF @type = 2
		begin
			DELETE Sort
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
Finish:  
	EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志     
	SELECT @ID ID, @Msg Msg
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑大类表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortEdit', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortEdit', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'大类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortEdit', @level2type=N'PARAMETER',@level2name=N'@SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortEdit', @level2type=N'PARAMETER',@level2name=N'@Title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否消耗品' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortEdit', @level2type=N'PARAMETER',@level2name=N'@IsConsum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'园长审批标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortEdit', @level2type=N'PARAMETER',@level2name=N'@Audit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 新增 1修改 2删除  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortEdit', @level2type=N'PARAMETER',@level2name=N'@type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作人ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SortEdit', @level2type=N'PARAMETER',@level2name=N'@DoUserID'
GO
