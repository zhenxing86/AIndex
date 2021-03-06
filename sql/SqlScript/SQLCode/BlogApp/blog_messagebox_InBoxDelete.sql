USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_InBoxDelete]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：清空收件箱的短信 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-12-5 16:07:33
------------------------------------
CREATE PROCEDURE [dbo].[blog_messagebox_InBoxDelete]
@userid int,
@viewstatus int
 AS 
		IF(@viewstatus=-1)
		BEGIN
			DELETE blog_messagebox WHERE touserid=@userid
		END
		ELSE
		BEGIN
			DELETE blog_messagebox 	
			WHERE touserid=@userid AND viewstatus=@viewstatus 
		END

		IF @@ERROR <> 0 
		BEGIN		
		  RETURN(-1)
		END
		ELSE
		BEGIN		
		  RETURN (1)
		END





GO
