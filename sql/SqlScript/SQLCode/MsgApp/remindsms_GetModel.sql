USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[remindsms_GetModel]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[remindsms_GetModel]
@rid int,
@userid int

 AS
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	DECLARE @tmpuserid int
	select @tmpuserid=COUNT(1) from remindsmsread  WHERE rid=@rid and userid=@userid
	IF (@tmpuserid>0)
	BEGIN
		SELECT 
			rid,actionuserid,actionusername,actiontypeid,actionobjectid,actiondesc,actiondatetime,classid,kid,fromid
		 FROM remindsms 
		 WHERE rid=@rid 	
	END
	ELSE
	BEGIN 	
		INSERT INTO remindsmsread(rid,userid,readtime) values(@rid,@userid,getdate())
		SELECT 
			rid,actionuserid,actionusername,actiontypeid,actionobjectid,actiondesc,actiondatetime,classid,kid,fromid
		 FROM remindsms 
		 WHERE rid=@rid 
	END




GO
