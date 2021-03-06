USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[Comment_Edit]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-12-3
-- Description:	操作日志的评论
-- Memo:	
*/
CREATE PROC [dbo].[Comment_Edit]
	@diaryid bigint,
	@type int, -- 0 新增， 2 删除
	@userid int,
	@Contents nvarchar(100)='',
	@ID bigint = 0
AS
BEGIN
	SET NOCOUNT ON
	IF @type = 0
	BEGIN
		INSERT INTO Comment(diaryid,userid,Contents)
		VALUES(@diaryid, @userid, @Contents)
	END
	ELSE IF @type = 2
	BEGIN
		Delete Comment where ID = @ID
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑Comment' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Comment_Edit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Comment_Edit', @level2type=N'PARAMETER',@level2name=N'@diaryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 新增， 2 删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Comment_Edit', @level2type=N'PARAMETER',@level2name=N'@type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Comment_Edit', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Comment_Edit', @level2type=N'PARAMETER',@level2name=N'@Contents'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Comment_Edit', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
