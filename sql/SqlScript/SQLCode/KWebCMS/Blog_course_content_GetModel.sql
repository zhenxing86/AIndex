USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Blog_course_content_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-03-28
-- Description:	GetModel
-- =============================================
create PROCEDURE [dbo].[Blog_course_content_GetModel]
@id int
AS
BEGIN	
	SELECT id,coursetypeid,subtypeno,'coursetitle'=title,gradeid,filepath,filename,
	thumbpath,thumbfilename,orderno,viewcount,[level],status
	FROM resourceapp..course_content
	WHERE id=@id
END











GO
