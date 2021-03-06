USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_draft_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-28
-- Description:	设置草稿  -1为草稿状态,0为发布状态
-- Memo:		
*/
CREATE PROCEDURE [dbo].[cms_content_draft_Add]
	@contentid int,
	@status int
AS
BEGIN
	Begin tran   
	BEGIN TRY  
		UPDATE cms_content 
			SET draftstatus = @status 
			WHERE contentid = @contentid
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return  -1      
	end Catch  
	Return 1   
END

GO
