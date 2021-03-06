USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[kindergartenDescript_Edit]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-15
-- Description:	更新kindergarten表
-- Memo:		
exec kindergartenDescript_Edit 12511,'幼儿园描述更新测试', '幼儿园照片更新测试'
*/
CREATE PROC [dbo].[kindergartenDescript_Edit]
	@kid int,
	@Desc varchar(8000),
	@Pic varchar(200)
AS
BEGIN
	SET NOCOUNT ON
	Begin tran   
	BEGIN TRY	
		
		UPDATE BasicData..kindergarten 
		SET NGB_Descript = @Desc,
			NGB_Pic = @Pic			
			WHERE kid = @kid		
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return -1        
	end Catch     
		RETURN 1
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新kindergarten表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kindergartenDescript_Edit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kindergartenDescript_Edit', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kindergartenDescript_Edit', @level2type=N'PARAMETER',@level2name=N'@Desc'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kindergartenDescript_Edit', @level2type=N'PARAMETER',@level2name=N'@Pic'
GO
