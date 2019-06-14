USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[SMS_Auto_Count]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-01
-- Description:	
-- Paradef: 
-- Memo:	
*/
create PROCEDURE [dbo].[SMS_Auto_Count]  
	@kid int,  
	@smsautocount int  
AS
BEGIN  
	SET NOCOUNT ON 
	update KWebCMS.dbo.site_config 
		set autosmslimit = @smsautocount 
		where  siteid = @kid 
END


GO
