USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[site_copyright_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[site_copyright_GetModel]
@kid int
as
    
	IF EXISTS (SELECT copyrightid,siteid,contents FROM kwebcms..site_copyright WHERE siteid=@kid)
	BEGIN
		SELECT copyrightid,siteid,contents FROM kwebcms..site_copyright WHERE siteid=@kid
	END
	ELSE
	BEGIN
		select copyrightid,siteid,contents from kwebcms..site_copyright where siteid=58
	END





GO
