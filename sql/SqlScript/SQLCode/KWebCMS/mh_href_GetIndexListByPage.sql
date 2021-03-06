USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_href_GetIndexListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-25
-- Description:	GetList
-- =============================================
--exec mh_href_GetIndexListByPage 1, 20
create PROCEDURE [dbo].[mh_href_GetIndexListByPage]
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
		INSERT INTO @tmptable(tmptableid) SELECT id FROM portal_href where isindexshow=1 and showmode=0
		ORDER BY orderno DESC,id DESC

		SET ROWCOUNT @size
		SELECT id,title,url,orderno,isindexshow,imgurl,showmode 
		FROM portal_href p join @tmptable on p.id=tmptableid WHERE row > @ignore ORDER BY orderno DESC,id DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT id,title,url,orderno,isindexshow,imgurl,showmode 
		FROM portal_href  
		WHERE isindexshow=1 and showmode=0
		ORDER BY orderno DESC,id DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT id,title,url,orderno,isindexshow,imgurl,showmode 
		FROM portal_href 
		WHERE isindexshow=1 and showmode=0
		ORDER BY orderno DESC,id DESC
	END
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_href_GetIndexListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
