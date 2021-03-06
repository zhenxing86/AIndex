USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinbaseinfo_actionlogs_Stat]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[kinbaseinfo_actionlogs_Stat]
@kid int
 AS 
	
	
	SELECT 
	siteid,
	name,
	accesscount,
	actioncount=
	(
		select count(a.userid) from kwebcms..actionlogs a,kwebcms..site_user u 
		where a.userid=u.userid and s.siteid=u.siteid
	),
	newscount=
	(
		select count(contentid) from kwebcms..[site] t3 
		left join kwebcms..cms_category t2 on  t2.siteid=t3.siteid 
		left join kwebcms..cms_content t1 on t1.categoryid=t2.categoryid and t1.deletetag = 1
		where   categorycode='xw' and  s.siteid=t1.siteid
	),
	ggcount=
	(
		select count(contentid) from kwebcms..[site] t3 
		left join kwebcms..cms_category t2 on  t2.siteid=t3.siteid 
		left join kwebcms..cms_content t1 on t1.categoryid=t2.categoryid and t1.deletetag = 1
		where   categorycode='gg' and  s.siteid=t1.siteid
	),
	mzspcount=
	(
		select count(contentattachsid) 
		from kwebcms..cms_contentattachs t1,kwebcms..cms_category t2,kwebcms..[site] t3 
		where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid 
		and categorycode='mzsp' and s.siteid=t1.siteid and t1.deletetag = 1
	),
	bjyycount=(select count(contentattachsid) from kwebcms..cms_contentattachs t1,kwebcms..cms_category t2,kwebcms..site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode='bjyy' and s.siteid=t1.siteid and t1.deletetag = 1),
	jcspcount=(select count(contentattachsid) from kwebcms..cms_contentattachs t1,kwebcms..cms_category t2,kwebcms..site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode='jcsp' and s.siteid=t1.siteid and t1.deletetag = 1),
	--yezpalbumcount=(select count(albumid) from kwebcms..cms_album t1,kwebcms..cms_category t2,kwebcms..site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode='yezp' and s.siteid=t3.siteid),
	--yezpphotocount=(select sum(photocount) from kwebcms..cms_album t1,kwebcms..cms_category t2,kwebcms..site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode='yezp' and s.siteid=t3.siteid),
	--hlsgalbumcount=(select count(albumid) from kwebcms..cms_album t1,kwebcms..cms_category t2,kwebcms..site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode='hlsg' and s.siteid=t3.siteid),
	--hlsgphotocount=(select sum(photocount) from kwebcms..cms_album t1,kwebcms..cms_category t2,kwebcms..site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode='hlsg' and s.siteid=t3.siteid)
	yezpalbumcount=0,
	yezpphotocount=0,
	hlsgalbumcount=0,
	hlsgphotocount=0
	
	FROM kwebcms..[site] s where siteid=@kid
	

GO
