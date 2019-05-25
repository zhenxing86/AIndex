USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_actionlogs_ADD]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：增加一条记录 
--项目名称：ZGYEYBLOG
--说明：
--时间：2009-3-26 13:12:52
------------------------------------
CREATE PROCEDURE [dbo].[class_actionlogs_ADD]
@actionuserid int,
@actionusername nvarchar(30),
@actiondescription nvarchar(300),
@actionmodul nvarchar(20),
@objectid int,
@touserid int,
@tousername nvarchar(30),
@classid int

 AS 
	INSERT INTO class_log(
	[actionuserid],[actionusername],[actiondescription],[actionmodul],[actiondatetime],[objectid],[touserid],[tousername],[classid]
	)VALUES(
	@actionuserid,@actionusername,@actiondescription,@actionmodul,getdate(),@objectid,@touserid,@tousername,@classid
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
