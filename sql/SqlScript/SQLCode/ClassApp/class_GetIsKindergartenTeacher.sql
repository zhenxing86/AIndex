USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_GetIsKindergartenTeacher]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：是否为本班老师
--项目名称：classhomepage
--时间：2009-02-23 9:23:01
------------------------------------
CREATE PROCEDURE [dbo].[class_GetIsKindergartenTeacher]
@userid int,
@kid int
 AS	
		DECLARE @kindergartenid int	
		DECLARE @usertype int

		SELECT @usertype=usertype,@kindergartenid=kid FROM BasicData.dbo.[user]  WHERE userid=@userid

		IF(@usertype=97 OR @usertype=98 OR @usertype=1)
		BEGIN
			IF(@kid = @kindergartenid)
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
