USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_docattachs_Delete]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：删除附件
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-03 22:21:32
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[thelp_docattachs_Delete]
@attachsid int
 AS 
	DELETE thelp_docattachs
	 WHERE attachsid=@attachsid 

	IF @@ERROR <> 0 
	BEGIN 				
	   RETURN(-1)
	END
	ELSE
	BEGIN			
	   RETURN (1)
	END








GO
