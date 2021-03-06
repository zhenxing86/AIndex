USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_Stat_GetListByPage]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-21
-- Description:	[actionlogs_Stat_GetListByPage] 0,1,10
-- =============================================
CREATE PROCEDURE [dbo].[actionlogs_Stat_GetListByPage]
@siteid int,
@page int,
@size int
AS
BEGIN

--	DECLARE @prep int,@ignore int
--	
--	SET @prep = @size * @page
--	SET @ignore=@prep - @size
--	
--	DECLARE @sql nvarchar(4000)
--	SET @sql='
--	SELECT TOP '+str(@size)+'
--	siteid,
--	name,
--	accesscount,
--	''actioncount''=(select count(a.userid) from actionlogs a,site_user u where a.userid=u.userid and s.siteid=u.siteid)		,
--	''newscount''=(select count(contentid) from cms_content t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode=''xw'' and s.siteid=t3.siteid)		,
--	''ggcount''=(select count(contentid) from cms_content t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode=''gg'' and s.siteid=t3.siteid),
--	''mzspcount''=(select count(contentattachsid) from cms_contentattachs t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode=''mzsp'' and s.siteid=t3.siteid),
--	''bjyycount''=(select count(contentattachsid) from cms_contentattachs t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode=''bjyy'' and s.siteid=t3.siteid),
--	''jcspcount''=(select count(contentattachsid) from cms_contentattachs t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode=''jcsp'' and s.siteid=t3.siteid),
--	''yezpalbumcount''=(select count(albumid) from cms_album t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode=''yezp'' and s.siteid=t3.siteid),
--	''yezpphotocount''=(select sum(photocount) from cms_album t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode=''yezp'' and s.siteid=t3.siteid),
--	''hlsgalbumcount''=(select count(albumid) from cms_album t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode=''hlsg'' and s.siteid=t3.siteid),
--	''hlsgphotocount''=(select sum(photocount) from cms_album t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode=''hlsg'' and s.siteid=t3.siteid)
--	FROM site s where '
--	
--	IF @siteid>0
--	BEGIN
--		SET @sql=@sql+'siteid='+str(@siteid)+' AND '
--	END
--	SET @sql=@sql+'s.siteid NOT IN (SELECT TOP '+str(@ignore)+' siteid FROM site ORDER BY siteid DESC) ORDER BY siteid DESC'
--	EXEC (@sql)



   
SELECT 
	siteid,
	name,
	accesscount,
	(select count(a.userid) from actionlogs_history a where a.kid=s.siteid)	as actioncount,
0,0,0,0,0,0,0,0,0
--(select count(contentid) from cms_content t1,cms_category t2 where t1.categoryid=t2.categoryid and categorycode='xw' and t1.siteid=s.siteid) as newscount,
--	(select count(contentid) from cms_content t1,cms_category t2 where t1.categoryid=t2.categoryid and categorycode='gg' and t1.siteid=s.siteid) as ggcount,
--	(select count(contentattachsid) from cms_contentattachs t1,cms_category t2 where t1.categoryid=t2.categoryid and t1.siteid=s.siteid and categorycode='mzsp') mzspcount,
--	(select count(contentattachsid) from cms_contentattachs t1,cms_category t2 where t1.categoryid=t2.categoryid and t1.siteid=s.siteid and categorycode='bjyy') bjyycount,
--	(select count(contentattachsid) from cms_contentattachs t1,cms_category t2 where t1.categoryid=t2.categoryid and t1.siteid=s.siteid and categorycode='jcsp') jcspcount,
--	(select count(albumid) from cms_album t1,cms_category t2 where t1.categoryid=t2.categoryid and t1.siteid=s.siteid and categorycode='yezp') yezpalbumcount,
--	(select sum(photocount) from cms_album t1,cms_category t2 where t1.categoryid=t2.categoryid and t1.siteid=s.siteid and categorycode='yezp') yezpphotocount,
--	(select count(albumid) from cms_album t1,cms_category t2 where t1.categoryid=t2.categoryid and t1.siteid=s.siteid and categorycode='hlsg') hlsgalbumcount,
--	(select sum(photocount) from cms_album t1,cms_category t2 where t1.categoryid=t2.categoryid and t1.siteid=s.siteid and categorycode='hlsg') hlsgphotocount
	FROM site s where s.siteid=@siteid
-- order by siteid desc

END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'actionlogs_Stat_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'actionlogs_Stat_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
