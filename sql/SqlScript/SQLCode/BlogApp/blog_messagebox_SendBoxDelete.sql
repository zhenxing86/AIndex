USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_SendBoxDelete]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：清空发件箱的短信 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-12-5 16:07:33
------------------------------------
CREATE PROCEDURE [dbo].[blog_messagebox_SendBoxDelete]
@userid int
 AS 
		DELETE blog_messagebox 	
		WHERE fromuserid=@userid  

		IF @@ERROR <> 0 
		BEGIN		
		  RETURN(-1)
		END
		ELSE
		BEGIN		
		  RETURN (1)
		END
		




GO
