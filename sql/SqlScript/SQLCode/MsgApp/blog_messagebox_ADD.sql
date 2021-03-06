USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_ADD]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


--------------------------------------------------------
CREATE PROCEDURE [dbo].[blog_messagebox_ADD]
@touserid int,
@fromuserid int,
@msgtitle nvarchar(30),
@msgcontent ntext,
@viewstatus int,
@parentid int,
@deletetag int

 AS
INSERT INTO blog_messagebox(
	[touserid],[fromuserid],[msgtitle],[msgcontent],[sendtime],[viewstatus],[parentid],[deletetag],[deletetagmy]
	)VALUES(
	@touserid,@fromuserid,@msgtitle,@msgcontent,getdate(),@viewstatus,@parentid,@deletetag,@deletetag
	)
	DECLARE @messageboxid int
	SET @messageboxid=@@identity
	
	
	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN(-1)
	END
	ELSE
	BEGIN	
		
	   RETURN (@messageboxid)
	END



GO
