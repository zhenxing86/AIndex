USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_IsKindergartenManager]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：判断是否是园长
--项目名称：classhomepage
--说明：
--时间：2009-2-9 11:14:19
------------------------------------
CREATE PROCEDURE [dbo].[class_IsKindergartenManager]
@kid int,
@userid int
AS	
	DECLARE @usertype int
	DECLARE @kindergartenid int	
	SELECT @usertype=usertype,@kindergartenid=kid FROM BasicData.dbo.[user]  WHERE userid=@userid
	
		IF(@usertype=97 OR @usertype=98)
		BEGIN
				IF (@kid=@kindergartenid)
				BEGIN
					RETURN 1
				END
				ELSE
				BEGIN
					RETURN 0
				END
		END	
		ELSE
		BEGIN
			RETURN 0
		END

GO
