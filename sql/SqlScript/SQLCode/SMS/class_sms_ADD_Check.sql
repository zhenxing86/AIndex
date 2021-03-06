USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[class_sms_ADD_Check]    Script Date: 05/14/2013 14:52:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：短信发送检查
--项目名称：classhomepage
--说明：
--时间：2009-4-15 22:54:31
------------------------------------
ALTER PROCEDURE [dbo].[class_sms_ADD_Check]
	@content varchar(500),
	@senderuserid int,
	@recuserid int,
	@sendtime datetime,
	@istime int
 AS 
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
--BEGIN TRANSACTION

declare @smsnum int
declare @kid int
declare @classid int
declare @recmobile nvarchar(200)
declare @guid varchar(50)
declare @smsid int

	select @recmobile=mobile from BasicData.dbo.[user] where userid=@recuserid 


	DECLARE @writetime datetime
	IF(@istime!=1)
	BEGIN

			IF EXISTS(select 1 from sms..sms_message where recuserid=@recuserid and content=@content)
			BEGIN
				select @writetime=writetime from sms..sms_message where recuserid=@recuserid and content=@content
				IF(datediff(minute,@writetime,GETDATE())>10)
				BEGIN
					RETURN (1)
				END
				ELSE
				BEGIN
					RETURN (-6)
				END
			END
			ELSE
			BEGIN
				RETURN (1)
			END
	END
	ELSE
	BEGIN
		IF EXISTS(select 1 from sms..sms_message_temp where recuserid=@recuserid and content=@content)
		BEGIN
			declare @writetime1 datetime
			select @writetime1=writetime from sms..sms_message where recuserid=@recuserid and content=@content
			IF(datediff(minute,@writetime1,getdate())>10)
			BEGIN
				RETURN (1)
			END
			ELSE
			BEGIN
				RETURN (-6)
			END
		END
		ELSE
		BEGIN
			RETURN (1)
		END
	END

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (1)
END
GO
