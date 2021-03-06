USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_Stat_GetListByDate_tmp]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-08-05
-- Description:	GetLogStat
-- =============================================
CREATE PROCEDURE [dbo].[actionlogs_Stat_GetListByDate_tmp]  
@startdatetime datetime,  
@enddatetime datetime,  
@page int,  
@size int  
AS  
BEGIN  
 IF(@page>-1)  
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
  SELECT DISTINCT s.siteid,   
  'actioncount'=(select count(a.userid) from actionlogs a,site_user u where a.userid=u.userid and s.siteid=u.siteid and actiondatetime>=@startdatetime AND actiondatetime<=@enddatetime)  
  FROM site s,actionlogs a,site_user u   
  WHERE a.userid=u.userid AND s.siteid=u.siteid AND actiondatetime>=@startdatetime AND actiondatetime<=@enddatetime  
  ORDER BY actioncount DESC,s.siteid DESC  
  
  SET ROWCOUNT @size  
  SELECT   
  DISTINCT  
  s.siteid,  
  s.name,  
  accesscount,  
  'actioncount'=(select count(a.userid) from actionlogs a,site_user u where a.userid=u.userid and s.siteid=u.siteid and actiondatetime>=@startdatetime AND actiondatetime<=@enddatetime),  
  'newscount'=(select count(contentid) from cms_content t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode='xw' and s.siteid=t3.siteid and t1.deletetag = 1),  
  'ggcount'=(select count(contentid) from cms_content t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode='gg' and s.siteid=t3.siteid and t1.deletetag = 1),  
  'mzspcount'=(select count(contentattachsid) from cms_contentattachs t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode='mzsp' and s.siteid=t3.siteid and t1.deletetag = 1),  
  'bjyycount'=(select count(contentattachsid) from cms_contentattachs t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode='bjyy' and s.siteid=t3.siteid and t1.deletetag = 1),  
  'jcspcount'=(select count(contentattachsid) from cms_contentattachs t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode='jcsp' and s.siteid=t3.siteid and t1.deletetag = 1),  
  'yezpalbumcount'=(select count(albumid) from cms_album t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode='yezp' and s.siteid=t3.siteid and t1.deletetag = 1),  
  'yezpphotocount'=(select count(photoid) from cms_photo t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode='yezp' and s.siteid=t3.siteid and t1.deletetag = 1),  
  'hlsgalbumcount'=(select count(albumid) from cms_album t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode='hlsg' and s.siteid=t3.siteid and t1.deletetag = 1),  
  'hlsgphotocount'=(select count(photoid) from cms_photo t1,cms_category t2,site t3 where t1.categoryid=t2.categoryid and t2.siteid=t3.siteid and categorycode='hlsg' and s.siteid=t3.siteid and t1.deletetag = 1)  
  
  FROM site s,@tempTable  
  WHERE siteid=tempid AND row>@ignore  
  ORDER BY actioncount DESC,s.siteid DESC  
 END  
END  

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'actionlogs_Stat_GetListByDate_tmp', @level2type=N'PARAMETER',@level2name=N'@page'
GO
