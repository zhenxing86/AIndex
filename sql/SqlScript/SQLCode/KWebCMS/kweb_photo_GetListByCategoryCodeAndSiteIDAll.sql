USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_photo_GetListByCategoryCodeAndSiteIDAll]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===========================================
-- Author:		lx
-- alter date: 2009-03-04
-- Description:	分页获取图片
-- =============================================
CREATE  PROCEDURE [dbo].[kweb_photo_GetListByCategoryCodeAndSiteIDAll]
@categorycode nvarchar(10),
@siteid VARCHAR(50),
@page int,
@size int
AS
BEGIN
     DECLARE @newsiteid int
    SELECT top 1 @newsiteid=string FROM [dbo].[SpitString] (@siteid ,',')
   
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
		INSERT INTO @tmptable(tmptableid) SELECT photoid FROM cms_photo t1 left join cms_category t2 on t1.categoryid=t2.categoryid
		WHERE categorycode=@categorycode AND indexshow=1 and t1.deletetag = 1
	    and t1.siteid IN (SELECT string FROM [dbo].[SpitString] (@siteid ,','))
        ORDER BY t1.orderno DESC,photoid DESC

		SET ROWCOUNT @size
		SELECT photoid,categoryid,albumid,title,[filename],filepath,filesize,commentcount,indexshow,flashshow,createdatetime ,s.siteDNS,net
      FROM cms_photo c join @tmptable on c.photoid=tmptableid  join site s
         on c.siteid=s.siteid 
          where  row > @ignore and c.deletetag = 1
         and c.siteid IN (SELECT string FROM [dbo].[SpitString] (@siteid ,','))
        ORDER BY orderno DESC,photoid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT photoid,c.categoryid,albumid,c.title,[filename],filepath,filesize,commentcount,indexshow,flashshow,c.createdatetime,s.siteDNS,net 
      FROM cms_photo  c left join cms_category t2 on c.categoryid=t2.categoryid left join site s on c.siteid=s.siteid
		  WHERE t2.categorycode=@categorycode AND indexshow=1 and c.deletetag = 1
        AND c.siteid=s.siteid
        and c.siteid IN (SELECT string FROM [dbo].[SpitString] (@siteid ,','))
		ORDER BY c.orderno DESC,photoid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT photoid,categoryid,albumid,title,[filename],filepath,filesize,commentcount,indexshow,flashshow,createdatetime ,net 
      FROM cms_photo 
		  WHERE categoryid in (SELECT categoryid FROM cms_category WHERE (siteid=0 or siteid=@siteid) and  categorycode=@categorycode) AND indexshow=1
        and siteid=@siteid and deletetag = 1
      ORDER BY orderno DESC,photoid DESC
	END
  
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_photo_GetListByCategoryCodeAndSiteIDAll', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_photo_GetListByCategoryCodeAndSiteIDAll', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_photo_GetListByCategoryCodeAndSiteIDAll', @level2type=N'PARAMETER',@level2name=N'@page'
GO
