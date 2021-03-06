USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_GetListByPage_lv1]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[cms_content_GetListByPage_lv1] 
@categoryid int,
@page int,
@size int,
@siteid int
AS
BEGIN
	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size


		;with temp as
		(
		select ROW_NUMBER() over (ORDER BY  orderno DESC,contentid DESC) as rownum,*
		from cms_content WHERE categoryid=@categoryid and siteid=@siteid and orderno!=-1 and deletetag = 1
		)

		select contentid,categoryid,content,title,titlecolor,author,createdatetime,searchkey,searchdescription,browsertitle
		,viewcount,commentcount,orderno,commentstatus,ispageing,status,siteid from temp
		where rownum>@ignore and rownum<=@prep 
		
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT * FROM cms_content 
		WHERE categoryid=@categoryid and orderno!=-1  and siteid=@siteid and deletetag = 1
		ORDER BY orderno DESC, contentid DESC
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_GetListByPage_lv1', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_GetListByPage_lv1', @level2type=N'PARAMETER',@level2name=N'@page'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_GetListByPage_lv1', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
