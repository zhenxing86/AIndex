USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[UP_Sms_smsmessage_Delete]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UP_Sms_smsmessage_Delete]
@ID int
 AS 
	DELETE Sms_userMobile
	 WHERE [ID] = @ID

GO
