USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[page_public_Edit]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-17
-- Description:	编辑组件值，page_public表
-- Memo:	
DECLARE	@I INT
exec @I = page_public_Edit 1,'Txt1', '文字编辑测试'
SELECT @I
SELECT * FROM page_public
*/
CREATE PROC [dbo].[page_public_Edit]
	@diaryid bigint,
	@ckey varchar(20),
	@cvalue varchar(1000),
	@CrtDate datetime = null
AS
BEGIN
	SET NOCOUNT ON
	Begin tran   
	BEGIN TRY
			UPDATE page_public 
				set cvalue = @cvalue
				WHERE diaryid = @diaryid 
					AND ckey = @ckey	
			UPDATE diary 
				set CrtDate = ISNULL(@CrtDate,CrtDate)
				WHERE diaryid = @diaryid 
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return -1        
	end Catch     
		RETURN 1
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑page_public' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_public_Edit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_public_Edit', @level2type=N'PARAMETER',@level2name=N'@diaryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'组件参数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_public_Edit', @level2type=N'PARAMETER',@level2name=N'@ckey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'组件值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_public_Edit', @level2type=N'PARAMETER',@level2name=N'@cvalue'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'page_public_Edit', @level2type=N'PARAMETER',@level2name=N'@CrtDate'
GO
