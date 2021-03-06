USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[HomeBook_Edit]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-15
-- Description:	编辑学期寄语内容，HomeBook表
-- Memo:		
exec HomeBook_Edit 1,'Foreword', '学期寄语更新测试'
exec HomeBook_Edit 1,'ForewordPic', '学期寄语图片更新测试'
*/
CREATE PROC [dbo].[HomeBook_Edit]
	@hbid int,
	@ColName varchar(100),
	@EditTxt varchar(1000)
AS
BEGIN
	SET NOCOUNT ON
	Begin tran   
	BEGIN TRY
		IF @ColName = 'Foreword'  
			UPDATE HomeBook SET Foreword = @EditTxt
				WHERE hbid = @hbid
		IF @ColName = 'ForewordPic'  
			UPDATE HomeBook SET ForewordPic = @EditTxt
				WHERE hbid = @hbid
		IF @ColName = 'ClassNotice'  
			UPDATE HomeBook SET ClassNotice = @EditTxt
				WHERE hbid = @hbid
		IF @ColName = 'ClassPic'  
			UPDATE HomeBook SET ClassPic = @EditTxt
				WHERE hbid = @hbid
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return -1        
	end Catch     
		RETURN 1
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑HomeBook' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'HomeBook_Edit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'家园联系册ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'HomeBook_Edit', @level2type=N'PARAMETER',@level2name=N'@hbid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'列名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'HomeBook_Edit', @level2type=N'PARAMETER',@level2name=N'@ColName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'HomeBook_Edit', @level2type=N'PARAMETER',@level2name=N'@EditTxt'
GO
