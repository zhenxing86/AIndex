USE [CommonFun]
GO
/****** Object:  StoredProcedure [dbo].[SetDoInfo]    Script Date: 2014/11/24 22:58:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 该存储过程用于保存存储过程名和用户ID到上下文信息中
-- Description:	
-- Memo:		
*/
CREATE PROC [dbo].[SetDoInfo]
	@DoUserID int ,
	@DoProc varchar(50)
as
BEGIN
	SET NOCOUNT ON
	declare @guid binary(100)
	SET @guid = CAST(ISNULL(@DoProc,'')+'#' + CAST(ISNULL(@DoUserID,0) AS VARCHAR(50)) + '$' as binary(100))
	EXEC CommonFun.dbo.sp_TrgSignal_Set
		@guid = @guid,
		@pos = 1;----------设置上下文标志，用于告诉触发器操作人员  
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用于保存存储过程名和用户ID到上下文信息中' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SetDoInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SetDoInfo', @level2type=N'PARAMETER',@level2name=N'@DoUserID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'存储过程名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'SetDoInfo', @level2type=N'PARAMETER',@level2name=N'@DoProc'
GO
