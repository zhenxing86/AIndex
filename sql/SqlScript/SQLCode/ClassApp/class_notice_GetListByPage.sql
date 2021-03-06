USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_notice_GetListByPage]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
  
  
  
-----------------------------------  
--用途：分页取公告信息   
--项目名称：ClassHomePage  
--说明：  
--时间：2009-1-6 9:44:05  
--exec class_notice_GetListByPage 24874,1,10,138662  
------------------------------------  
CREATE  PROCEDURE [dbo].[class_notice_GetListByPage]  
@classid int,  
@page int,  
@size int,  
@userid int  
  
 AS   
 declare @user int  
 select @user=@userid  
 DECLARE @classname nvarchar(50)  
 select @classname=cname from basicdata..class where cid=@classid  
 IF(@page>1)  
 BEGIN  
  DECLARE @prep int,@ignore int  
  
  SET @prep=@size*@page  
  SET @ignore=@prep-@size  
  
  DECLARE @tmptable TABLE  
  (  
   row int IDENTITY(1,1),  
   tmptableid bigint  
  )  
   
  SET ROWCOUNT @prep  
  INSERT INTO @tmptable(tmptableid)  
   SELECT   
    noticeid  
   FROM    
    class_notice_class   
   WHERE classid=@classid  
   ORDER BY noticeid DESC  
  
  
  SET ROWCOUNT @size  
  SELECT   
   t1.noticeid,t1.title,t1.userid,t1.author,t1.kid,@classid as classid,t1.content,t1.createdatetime,1 AS isread,@classname as classname  
  FROM   
   @tmptable AS tmptable    
  INNER JOIN  
    class_notice t1  
  ON   
   tmptable.tmptableid=t1.noticeid   
  WHERE  
   row>@ignore  
  ORDER BY   
    noticeid DESC  
 END  
 ELSE  
 BEGIN  
  SET ROWCOUNT @size  
  SELECT   
   t1.noticeid,t1.title,t1.userid,t1.author,t1.kid,@classid as classid,t1.content,t1.createdatetime,1 AS isread,@classname as classname  
  FROM class_notice t1 inner join class_notice_class t2 on t1.noticeid=t2.noticeid WHERE t2.classid=@classid  
  ORDER BY t1.noticeid DESC  
 END  
  
  
  
  
  
  
  
GO
