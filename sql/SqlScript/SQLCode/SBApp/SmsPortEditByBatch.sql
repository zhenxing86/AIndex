USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[SmsPortEditByBatch]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- =============================================
-- Author:		Master谭
-- Create date: 2014-2-8
-- Description:	按服务商修改短信通道 0移动，1电信，2联通
-- Memo:	
*/
CREATE PROCEDURE [dbo].[SmsPortEditByBatch] 
	@Channel int, 
	@smsport int
AS
BEGIN
	SET NOCOUNT ON;
	update basicdata..[user] 
		SET smsport = @smsport 
		where CommonFun.dbo.fn_cellphoneNet(mobile) = @Channel
END

GO
