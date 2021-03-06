USE [OMApp]
GO
/****** Object:  StoredProcedure [dbo].[Income_MAudit]    Script Date: 2014/11/24 23:20:50 ******/
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
CREATE Proc [dbo].[Income_MAudit]
	@ID int,
	@kid int,
	@userid int, 
	@AuditType int --1 确认， 0取消确认
AS
BEGIN
	SET NOCOUNT ON
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @userid, @DoProc = 'Income_MAudit' --设置上下文标志
	DECLARE @Msg varchar(50) = '操作成功'
	IF @AuditType = 0
	BEGIN
			SELECT @ID = -1, @Msg = '暂不支持取消入库' 
			GOTO Finish		
	END
	ELSE
	BEGIN
		IF CommonFun.dbo.GetRight(@kid,@userid,'物品管理员') = 0
		BEGIN
			SELECT @ID = -1, @Msg = '您需要拥有物品管理员权限，才可以进行该操作' 
			GOTO Finish
		END
		UPDATE Income_M 
			SET IsCheck = @AuditType,
					ChkUserID = @userid,
					ChkDate = GETDATE()
			WHERE ID = @ID
		insert into Variation(kid,BarCode,VarType,VarPlace,DutyUserID,CrtUserID,VarNum)
			select m.kid, d.BarCode, 0, 0, m.ChkUserID, m.ChkUserID, d.Num 
				from Income_M m 
					inner join Income_D d 
						on m.kid = d.kid 
						and m.IncSigNo = d.IncSigNo
				where m.ID = @ID
		SELECT @Msg = '入库成功' 		
	END	
Finish:	
	EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志     
	SELECT @ID Result, @Msg Msg
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'审核入库单主表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_MAudit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_MAudit', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_MAudit', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_MAudit', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' 1 确认， 0取消确认  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Income_MAudit', @level2type=N'PARAMETER',@level2name=N'@AuditType'
GO
