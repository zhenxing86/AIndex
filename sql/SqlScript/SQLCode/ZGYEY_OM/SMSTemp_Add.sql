USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[SMSTemp_Add]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：增加一条记录 
--项目名称：storybook
--说明：
--时间：2011/11/20 21:20:08
------------------------------------
CREATE PROCEDURE [dbo].[SMSTemp_Add]
@smstype int,
@smscontent nvarchar(500)

 AS 
	INSERT INTO SMS_Temp(
	[smstype],[smscontent],[lastUpdateTime]
	)VALUES(
	@smstype,@smscontent,GETDATE()
	)
	
IF @@ERROR <> 0	
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN 1
	END

GO
