USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_docattachs_GetList]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：取附件列表
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-03 22:21:32
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[thelp_docattachs_GetList]
@docid int
 AS 
	SELECT 
	attachsid,docid,title,filepath,filename,filesize,filetype,createdatetime
	 FROM thelp_docattachs
	WHERE docid=@docid






GO
