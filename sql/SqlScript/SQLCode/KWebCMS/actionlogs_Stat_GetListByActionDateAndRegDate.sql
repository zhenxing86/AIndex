USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_Stat_GetListByActionDateAndRegDate]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












-- =============================================
-- Author:		hanbin
-- Create date: 2009-08-05
-- Description:	GetLogStat
-- =============================================
CREATE PROCEDURE [dbo].[actionlogs_Stat_GetListByActionDateAndRegDate]
@startactiondatetime datetime,
@endactiondatetime datetime,
@startregdatetime datetime,
@endregdatetime datetime,
@page int,
@size int
AS
BEGIN
	DECLARE @count int
	DECLARE @ignore int
	SET @count=@page*@size
	SET @ignore=@count-@size

	DECLARE @tempTable TABLE
	(
		row int primary key identity(1,1),			
		tempid int,
		tempactioncount int
	)
	SET ROWCOUNT @count
	INSERT INTO @tempTable	
	select a.kid, count(1) as actioncount  from actionlogs_history a 
left join site s on a.kid=s.siteid
where regdatetime between @startregdatetime and @endregdatetime
and actiondatetime between @startactiondatetime and @endactiondatetime
GROUP BY s.name, a.kid
order by actioncount desc

	SET ROWCOUNT @size
	SELECT 	
	s.tempid,
	site.name+'',
	accesscount,
	'actioncount'=tempactioncount,0,0,0,0,0,0,0,0,0
--
--	'newscount'=(select count(contentid) from cms_content t1,cms_category t2 where t1.categoryid=t2.categoryid and t1.siteid=s.tempid and categorycode='xw'),
--	'ggcount'=(select count(contentid) from cms_content t1,cms_category t2 where t1.categoryid=t2.categoryid and t1.siteid=s.tempid and categorycode='gg'),
--	'mzspcount'=(select count(contentattachsid) from cms_contentattachs t1,cms_category t2 where t1.categoryid=t2.categoryid and t1.siteid=s.tempid and categorycode='mzsp'),
--	'bjyycount'=(select count(contentattachsid) from cms_contentattachs t1,cms_category t2 where t1.categoryid=t2.categoryid and t1.siteid=s.tempid and categorycode='bjyy'),
--	'jcspcount'=(select count(contentattachsid) from cms_contentattachs t1,cms_category t2 where t1.categoryid=t2.categoryid and t1.siteid=s.tempid and categorycode='jcsp'),
--	'yezpalbumcount'=(select count(albumid) from cms_album t1,cms_category t2 where t1.categoryid=t2.categoryid and t1.siteid=s.tempid and categorycode='yezp'),
--	'yezpphotocount'=(select sum(photocount) from cms_album t1,cms_category t2 where t1.categoryid=t2.categoryid and t1.siteid=s.tempid and categorycode='yezp'),
--	'hlsgalbumcount'=(select count(albumid) from cms_album t1,cms_category t2 where t1.categoryid=t2.categoryid and t1.siteid=s.tempid and categorycode='hlsg'),
--	'hlsgphotocount'=(select sum(photocount) from cms_album t1,cms_category t2 where t1.categoryid=t2.categoryid and t1.siteid=s.tempid and categorycode='hlsg')
	FROM site ,@tempTable s
	WHERE siteid=tempid AND row>@ignore
	ORDER BY actioncount DESC,s.tempid DESC
END




















GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'actionlogs_Stat_GetListByActionDateAndRegDate', @level2type=N'PARAMETER',@level2name=N'@page'
GO
