USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_backgroundmusic_ADD]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：上传班级背景音乐 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-15 16:21:36
------------------------------------
CREATE  PROCEDURE [dbo].[class_backgroundmusic_ADD]
@kid int,
@classid int,
@backgroundmusicpath nvarchar(500),
@backgroundmusictitle nvarchar(200),
@isdefault bit,
@datatype nvarchar(200),
@uploaddatetime datetime

 AS 
	DECLARE @count int
	SELECT @count=count(1) FROM class_backgroundmusic WHERE classid=@classid
	IF(@count=0)
	BEGIN
		SET @isdefault=1
	END
	INSERT INTO class_backgroundmusic(
	[kid],[classid],[backgroundmusicpath],[backgroundmusictitle],[isdefault],[datatype],[uploaddatetime],[status]
	)VALUES(
	@kid,@classid,@backgroundmusicpath,@backgroundmusictitle,@isdefault,@datatype,@uploaddatetime,1
	)
	
	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN @@IDENTITY
	END






GO
