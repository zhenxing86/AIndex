USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[Manage_QuerySmsList]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-06-04
-- Description:	
-- Paradef: 
-- Memo: EXEC Manage_QuerySmsList	298682
*/     
CREATE PROCEDURE [dbo].[Manage_QuerySmsList]    
	@userid int  
AS  
BEGIN
	SET NOCOUNT ON
	;WITH CET AS
	(
		SELECT recuserid,recmobile,content,sendtime,status,writetime 
			FROM sms..sms_message_curmonth
		UNION ALL
		SELECT recuserid,recmobile,content,sendtime,status,writetime 
			FROM sms_history..sms_message
	)  
		select top 10 recmobile,content,sendtime,status,writetime 
			from CET
			where recuserid=@userid  
			order by sendtime desc   			

  
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'短信发送历史记录' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Manage_QuerySmsList'
GO
