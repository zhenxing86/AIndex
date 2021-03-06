USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[Nice_Edit]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-12-3
-- Description:	操作日志的赞
-- Memo:	
*/
CREATE PROC [dbo].[Nice_Edit]
	@diaryid bigint,
	@type int, -- 1 赞， 0 取消赞
	@userid int
AS
BEGIN
	SET NOCOUNT ON
	declare @result int = -1
	IF @type = 1
	BEGIN
		IF NOT EXISTS(SELECT * FROM Nice WHERE diaryid = @diaryid and userid = @userid)
		BEGIN
			INSERT INTO Nice(diaryid,userid)
			VALUES(@diaryid, @userid)
			SET @result = 1
		END
	END
	ELSE IF @type = 0
	BEGIN
		Delete Nice where diaryid = @diaryid and userid = @userid
		SET @result = 1
	END
	RETURN @result
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑Nice' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Nice_Edit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Nice_Edit', @level2type=N'PARAMETER',@level2name=N'@diaryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 赞， 0 取消赞' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Nice_Edit', @level2type=N'PARAMETER',@level2name=N'@type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Nice_Edit', @level2type=N'PARAMETER',@level2name=N'@userid'
GO
