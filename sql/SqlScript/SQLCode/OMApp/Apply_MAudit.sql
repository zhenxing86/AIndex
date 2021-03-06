USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Apply_MAudit]    Script Date: 2014/11/24 23:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		
*/
CREATE Proc [dbo].[Apply_MAudit]
	@ID bigint,
	@kid int,
	@userid int, 
	@yzuserid int, --当指定园长审核时，使用，即 状态 1->2 时使用
	@AuditName varchar(50),
	@AuditType int, --1 确认， 0取消确认
	@RetDate datetime = null
AS
BEGIN
	SET NOCOUNT ON
	IF @RetDate = '1900-01-01' SET @RetDate = NULL
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @userid, @DoProc = 'Apply_MAudit' --设置上下文标志
	DECLARE @Msg varchar(50) = '操作成功', @Result int = 1,@Status int
	SELECT @Status = Status FROM Apply_M WHERE ID = @ID
	IF @AuditName = 'IsApp'
	BEGIN
		IF @Status Not IN(0,1)  
		BEGIN
			SELECT @Result = -1, @Msg = '该状态下不允许此操作' 
			GOTO Finish
		END
		UPDATE Apply_M 
			SET AppUserID = @userid,
					IsApp = @AuditType,
					AppDate = GETDATE()
			WHERE ID = @ID
	END
	ELSE IF @AuditName = 'NeedAudit'
	BEGIN
		IF CommonFun.dbo.GetRight(@kid,@userid,'物品管理员') = 0
		BEGIN
			SELECT @Result = -1, @Msg = '您需要拥有物品管理员权限，才可以进行该操作' 
			GOTO Finish
		END
		IF @AuditType = 1 and ISNULL(@yzuserid, 0) <= 0
		BEGIN
			SELECT @Result = -1, @Msg = '请指定审核的园长' 
			GOTO Finish
		END
		IF @Status Not IN(1,2)  
		BEGIN
			SELECT @Result = -1, @Msg = '该状态下不允许此操作' 
			GOTO Finish
		END
		UPDATE Apply_M 
			SET AuditUserid = @yzuserid,
					NeedAudit = @AuditType,
					NeedUserid = @userid,
					NeedDate = GETDATE()
			WHERE ID = @ID
		SELECT @Msg = '指定审批园长（'+ISNULL(Name,'')+'）成功' from BasicData..[user] where userid = @yzuserid 
	END
	ELSE IF @AuditName = 'IsAudit'
	BEGIN
		IF NOT EXISTS(SELECT * FROM Apply_M WHERE ID = @ID AND AuditUserid = @userid)
		BEGIN
			SELECT @Result = -1, @Msg = '您不是指定审批的园长，无权进行该操作' 
			GOTO Finish
		END
		IF @Status Not IN(2,3)  
		BEGIN
			SELECT @Result = -1, @Msg = '该状态下不允许此操作' 
			GOTO Finish
		END
		UPDATE Apply_M 
			SET IsAudit = @AuditType,
					AuditDate = GETDATE()
			WHERE ID = @ID
		SELECT @Msg = '审批成功' 
		IF @AuditType = 1
		begin		
			EXEC Apply_MAudit
				@ID = @ID, 
				@kid = @kid,
				@userid = @userid, 
				@yzuserid = -1, --当指定园长审核时，使用，即 状态 1->2 时使用
				@AuditName = 'IsPass',
				@AuditType = 1 --1 确认， 0取消确认
		end
	END	
	ELSE IF @AuditName = 'IsPass'
	BEGIN
		IF CommonFun.dbo.GetRight(@kid, @userid, '物品管理员') = 0 and @Status <> 3
		BEGIN
			SELECT @Result = -1, @Msg = '您需要拥有物品管理员权限，才可以进行该操作' 
			GOTO Finish
		END
		IF @Status Not IN(1,3,4)  
		BEGIN
			SELECT @Result = -1, @Msg = '该状态下不允许此操作' 
			GOTO Finish
		END
		UPDATE Apply_M 
			SET IsPass = @AuditType,
					PassUserID = @userid,
					PassDate = GETDATE()
			WHERE ID = @ID
		SELECT @Msg = '审批成功' 
	END
	ELSE IF @AuditName = 'IsCheck'
	BEGIN
		IF CommonFun.dbo.GetRight(@kid,@userid,'物品管理员') = 0
		BEGIN
			SELECT @Result = -1, @Msg = '您需要拥有物品管理员权限，才可以进行该操作' 
			GOTO Finish
		END
		IF @Status Not IN(4)  
		BEGIN
			SELECT @Result = -1, @Msg = '该状态下不允许此操作' 
			GOTO Finish
		END
		UPDATE Apply_M 
			SET IsCheck = @AuditType,
					ChkUserID = @userid,
					ChkDate = GETDATE(),
					RetDate = @RetDate
			WHERE ID = @ID
		insert into Variation(kid,BarCode,VarType,VarPlace,DutyUserID,CrtUserID,VarNum)
			select m.kid, d.BarCode, m.AppType, 0, m.AppUserID, m.ChkUserID, -d.Num 
				from Apply_M m 
					inner join Apply_D d 
						on m.kid = d.kid 
						and m.AppSigNo = d.AppSigNo
				where m.ID = @ID
		SELECT @Msg = '领取成功' 
		
	END	
Finish:	
	EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志     
	SELECT @Result Result, @Msg Msg
	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'审核领用（借用）表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MAudit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MAudit', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MAudit', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MAudit', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'指定园长审核的园长ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MAudit', @level2type=N'PARAMETER',@level2name=N'@yzuserid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'审核类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MAudit', @level2type=N'PARAMETER',@level2name=N'@AuditName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' 1 确认， 0取消确认  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MAudit', @level2type=N'PARAMETER',@level2name=N'@AuditType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'归还时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Apply_MAudit', @level2type=N'PARAMETER',@level2name=N'@RetDate'
GO
