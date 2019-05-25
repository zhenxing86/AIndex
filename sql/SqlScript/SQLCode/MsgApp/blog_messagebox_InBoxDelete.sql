USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_InBoxDelete]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[blog_messagebox_InBoxDelete]
@UserId int,
@Viewstatus int
 AS
if @Viewstatus=-1
update  blog_messagebox set deletetagmy=0 WHERE touserid=@UserId 
else
update  blog_messagebox set deletetagmy=0 WHERE touserid=@UserId and viewstatus=@Viewstatus

	IF @@ERROR <> 0 
		BEGIN		
		  RETURN(-1)
		END
		ELSE
		BEGIN		
		  RETURN (1)
		END

GO
