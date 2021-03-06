USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_notice_GetListByKid]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
  
  
-----------------------------------  
--用途：分页取公告信息   
--项目名称：ClassHomePage  
--说明：  
--时间：2011-6-30 18:00  
--  exec class_notice_GetListByKid 12511,1,10
------------------------------------  
CREATE PROCEDURE [dbo].[class_notice_GetListByKid]  
@kid int,  
@page int,  
@size int  
 AS   
  
 IF(@page>1)  
 BEGIN  
  DECLARE @prep int,@ignore int  
  
  SET @prep=@size*@page  
  SET @ignore=@prep-@size  
  
  DECLARE @tmptable TABLE  
  (  
   row int IDENTITY(1,1),  
   tmptableid bigint,  
   tmpclassname nvarchar(50),  
   tmpclassid int  
  )  
   
  SET ROWCOUNT @prep  
  INSERT INTO @tmptable(tmptableid,tmpclassname,tmpclassid)  
   SELECT   
    t1.noticeid,t2.cname,t1.classid  
   FROM    
    class_notice_class t1 inner join basicdata..class t2 on t1.classid=t2.cid   
   WHERE t2.deletetag=1 and  t2.kid=@kid   
            ORDER BY   
    t1.noticeid DESC  
  
  SET ROWCOUNT @size  
  SELECT   
   t1.noticeid,t1.title,t1.userid,t1.author,t1.kid,tmptable.tmpclassid as classid,t1.content,t1.createdatetime,tmptable.tmpclassname as classname  
  FROM   
   @tmptable AS tmptable    
  INNER JOIN  
    class_notice t1  
  ON   
   tmptable.tmptableid=t1.noticeid   
  WHERE  
   row>@ignore  
  ORDER BY   
   t1.noticeid DESC   
 END  
 ELSE  
 BEGIN  
  SET ROWCOUNT @size  
  SELECT   
   t1.noticeid,t1.title,t1.userid,t1.author,t1.kid,t3.classid,t1.content,t1.createdatetime,t2.cname as classname  
  FROM class_notice t1 INNER JOIN class_notice_class t3 on t1.noticeid=t3.noticeid INNER JOIN basicdata..class t2 ON t3.classid=t2.cid   
  WHERE t2.kid=@kid and t2.deletetag=1  
  ORDER BY t1.noticeid desc  
 END  
  
  
  
  
  
  
GO
