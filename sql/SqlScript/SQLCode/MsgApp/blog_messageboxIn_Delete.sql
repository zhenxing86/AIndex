USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messageboxIn_Delete]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE PROCEDURE [dbo].[blog_messageboxIn_Delete]
@messageboxid int
 AS
update  blog_messagebox set deletetagmy=0
	 WHERE messageboxid=@messageboxid 

	IF @@ERROR <> 0 
		BEGIN		
		  RETURN(-1)
		END
		ELSE
		BEGIN		
		  RETURN (1)
		END


GO
