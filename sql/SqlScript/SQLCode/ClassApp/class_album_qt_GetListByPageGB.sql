USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_album_qt_GetListByPageGB]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
  
  
  
  
  
  
  
  
------------------------------------  
--用途：分页取相册信息   
--项目名称：ClassHomePage  
--说明：  
--时间：2009-3-20 10:58:57  
--class_album_qt_GetListByPageGB 55906,2,10  
--class_album_qt_GetListByPageGB 63077,1,10  
------------------------------------  
CREATE PROCEDURE [dbo].[class_album_qt_GetListByPageGB]  
@classid int,  
@page int,  
@size int  
 AS  
  
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
   SELECT  
    albumid  
   FROM  
    class_album  
   WHERE  
    classid=@classid and status=1 --and createdatetime>='2013-09-01 15:15:28.187'  
   ORDER BY  
    createdatetime DESC   
  
   SET ROWCOUNT @size  
  
   SELECT t1.albumid,t1.title,t1.description,t1.photocount,t1.classid,t1.kid,t1.userid,t1.author,t1.createdatetime,t1.coverphoto AS defaultcoverphoto, t1.coverphoto,  
dbo.IsNewPhoto(t1.lastuploadtime) AS newalbum,0 AS isblogalbum,coverphotodatetime AS defaultphotodatetime,t1.coverphotodatetime,t2.cname as classname,t1.net  
   FROM  
    @tmptable as tmptable  
   INNER JOIN  
    class_album t1  
   ON  
    tmptable.tmptableid = t1.albumid  
   INNER JOIN  
    BasicData.dbo.class t2 on t1.classid=t2.cid and t2.deletetag=1  
   WHERE  
    row > @ignore AND t1.classid=@classid and t1.status = 1  
    and t2.deletetag=1  
  
 END  
 ELSE  
 BEGIN  
  SET ROWCOUNT @size  
  --SELECT t1.albumid,t1.title,t1.description,t1.photocount,t1.classid,t1.kid,t1.userid,t1.author,t1.createdatetime, t1.defaultcoverphoto, t1.coverphoto,t1.newalbum,t1.isblogalbum,t1.defaultphotodatetime,t1.coverphotodatetime,t2.cname as classname  
SELECT t1.albumid,t1.title,t1.description,t1.photocount,t1.classid,t1.kid,t1.userid,t1.author,t1.createdatetime,t1.coverphoto AS defaultcoverphoto, t1.coverphoto,  
dbo.IsNewPhoto(t1.lastuploadtime) AS newalbum,0 AS isblogalbum,coverphotodatetime AS defaultphotodatetime,t1.coverphotodatetime,t2.cname as classname,t1.net  
  FROM  
   class_album  t1 inner join BasicData.dbo.class t2 on t1.classid=t2.cid and t2.deletetag=1  
  where  t1.classid=@classid and t1.status = 1  
  --and t1.createdatetime>='2013-09-01 14:00'  
  order by t1.createdatetime desc  
 END  
  
  
  
  
  
  
  
  
  
  
  
  
  
GO
