USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[SMSTemp_GetModel]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SMSTemp_GetModel]
@tempid int
 AS 
	SELECT 
	id,3,smstype,smscontent,1,lastUpdateTime
	 FROM SMS_Temp
	 WHERE id=@tempid 

GO
