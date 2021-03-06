USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_phoneupdate]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2011-4-20
-- Description:	修改手机号码
-- =============================================
CREATE PROCEDURE [dbo].[kmp_phoneupdate]
@userid int,
@mobile nvarchar(100)
AS

BEGIN TRANsACTION

UPDATE kmp..Sms_userMobile
SET Mobile=@mobile
WHERE userid=@userid

declare @usertype int

SELECT @usertype=UserType
FROM kmp..T_Users
WHERE ID=@userid

IF(@usertype=0)
BEGIN
UPDATE kmp..T_Child
SET Mobile=@mobile
WHERE UserID=@userid

UPDATE blog..child
SET b_mobilephone=@mobile
WHERE kmpuserid=@userid
END

ELSE
BEGIN
UPDATE kmp..T_Staffer
SET Mobile=@mobile
WHERE UserID=@userid

UPDATE blog..teacher
SET b_mobilephone=@mobile
WHERE kmpuserid=@userid
END
	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN (1)
	END



GO
