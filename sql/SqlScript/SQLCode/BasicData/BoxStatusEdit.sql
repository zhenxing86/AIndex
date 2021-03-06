USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BoxStatusEdit]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- =============================================
-- Author:		Master谭
-- Create date: 2014-02-18
-- Description:	更新任务盒子状态
-- Memo:
exec BasicData..BoxStatusEdit @Kid = @Kid, @StatusNo = 2	
*/
CREATE PROCEDURE [dbo].[BoxStatusEdit]
	@Kid int,
	@StatusNo int --1 更新网址 2 开通家园联系册
AS
BEGIN
	SET NOCOUNT ON;
	Begin tran   
	BEGIN TRY  
		UPDATE kindergarten
			SET BoxStatus = Commonfun.dbo.fn_RoleAdd(BoxStatus,@StatusNo)   
			WHERE kid = @kid
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		SELECT  0  
		return    
	end Catch  
	SELECT 1
END

GO
