USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portalphoto_GetListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-25
-- Description:	GetList
-- =============================================
CREATE PROCEDURE [dbo].[portalphoto_GetListByPage]
@page int,
@size int
AS
BEGIN
	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) SELECT [photoid] FROM portalphoto
		ORDER BY photoid DESC

		SET ROWCOUNT @size
		SELECT p.photoid,p.siteid,c.title,c.filename,c.filepath,c.createdatetime
		  FROM cms_photo c,portalphoto p,@tmptable 
      WHERE row > @ignore AND c.[photoid]=tmptableid AND c.photoid=p.photoid and c.deletetag = 1 
		  ORDER BY photoid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT p.photoid,p.siteid,c.title,c.filename,c.filepath,c.createdatetime
	  	FROM cms_photo c,portalphoto p 
      WHERE c.photoid=p.photoid and c.deletetag = 1
	  	ORDER BY p.photoid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT p.photoid,p.siteid,c.title,c.filename,c.filepath,c.createdatetime 
	  	FROM cms_photo c,portalphoto p 
      WHERE c.photoid=p.photoid and c.deletetag = 1
	  	ORDER BY p.photoid DESC
	END	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'portalphoto_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
