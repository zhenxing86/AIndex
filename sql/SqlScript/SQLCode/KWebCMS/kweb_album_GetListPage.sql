USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_album_GetListPage]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-06
-- Description:	分页获取相册
-- =============================================
CREATE PROCEDURE [dbo].[kweb_album_GetListPage]
@categorycode nvarchar(10),
@siteid int,
@page int,
@size int
AS
BEGIN	

if(exists(select 1 from theme_kids where kid=@siteid) or not exists(select 1 from cms_album where siteid=@siteid))
begin
	--SET @siteid=14499
	exec KWebCMS_Temp..[kweb_album_GetListPage] @categorycode,@siteid,@page,@size
end


	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) 
		SELECT albumid FROM cms_album t1 left join cms_category t2 on t1.categoryid=t2.categoryid
	   WHERE categorycode=@categorycode AND photocount>0
		and t1.siteid=@siteid and t1.deletetag = 1
        ORDER BY t1.orderno DESC

		SET ROWCOUNT @size
		SELECT albumid,c.categoryid,title,searchkey,searchdescription,photocount,cover,c.orderno,createdatetime ,net
		FROM cms_album c join @tmptable on c.albumid=tmptableid 
		WHERE row > @ignore and c.deletetag = 1 ORDER BY c.orderno DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT albumid,t1.categoryid,t1.title,searchkey,searchdescription,photocount,cover,t1.orderno,t1.createdatetime ,t1.net 
		FROM cms_album t1 left join cms_category t2 on t1.categoryid=t2.categoryid
		WHERE  categorycode=@categorycode AND photocount>0
		and t1.siteid=@siteid and t1.deletetag = 1
        ORDER BY t1.orderno DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT albumid,t1.categoryid,t1.title,searchkey,searchdescription,photocount,cover,t1.orderno,t1.createdatetime,t1.net  
		from cms_album t1 left join cms_category t2 on t1.categoryid=t2.categoryid
		WHERE  categorycode=@categorycode AND photocount>0	
	    and t1.siteid=@siteid and t1.deletetag = 1
       ORDER BY t1.orderno DESC
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_album_GetListPage', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_album_GetListPage', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_album_GetListPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
