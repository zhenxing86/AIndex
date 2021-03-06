USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SMS_GetSmsTask]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--作者：along
--更新日期：2006-03-30
--取需要发送的短信列表
--2006-10-19

CREATE PROCEDURE [dbo].[SMS_GetSmsTask]
AS
declare @Now varchar(50)  --当前时间
declare @Zero varchar(50) --当天零点

SET @Now = getdate()
SET @Zero = str(year(@Now),4) + '-' + str(month(@Now),2) + '-' + str(day(@Now),2) + ' 00:00:00.000'

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION

SELECT TOP 100
	[ID],
	[Guid],
	[RecMobile],
	[Content],
	[Status],
	[SendTime],
	[WriteTime]
FROM
	[dbo].[T_SmsMessage_Emay]

WHERE [SendTime] < @Now AND [SendTime] > @Zero AND [Status] = 0

ORDER BY [SendTime] ASC, [ID] DESC

IF @@ERROR <> 0 
BEGIN
   -- Fail
   ROLLBACK TRANSACTION
   RETURN(-1)
END
ELSE
BEGIN
   -- Success
   COMMIT TRANSACTION
   RETURN(1)
END

--endregion






GO
