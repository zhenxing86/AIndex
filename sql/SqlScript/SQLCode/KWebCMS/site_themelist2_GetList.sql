USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_themelist2_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		lx
-- Create date: 2010-08-29
-- Description:	GetList
-- =============================================
CREATE PROCEDURE [dbo].[site_themelist2_GetList]
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
		INSERT INTO @tmptable(tmptableid) 
		SELECT [themeid] FROM site_themelist where siteid=-1 ORDER BY themeid DESC

		SET ROWCOUNT @size
		SELECT themeid,siteid,title,thumbpath,status,createdatetime,iscustomer ,previewUrl
		FROM site_themelist join @tmptable on themeid=tmptableid WHERE row > @ignore and siteid=-1 ORDER BY themeid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT themeid,siteid,title,thumbpath,status,createdatetime,iscustomer ,previewUrl
		FROM site_themelist  where siteid=-1
		ORDER BY themeid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT themeid,siteid,title,thumbpath,status,createdatetime,iscustomer ,previewUrl
		FROM site_themelist  where siteid=-1
		ORDER BY themeid DESC		 
	END
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_themelist2_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
