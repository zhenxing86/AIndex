USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_Delete]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：删除一条短信息
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-5 11:07:33
------------------------------------
CREATE PROCEDURE [dbo].[blog_messagebox_Delete]
@messageboxid int
 AS
update  blog_messagebox set deletetag=0
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
