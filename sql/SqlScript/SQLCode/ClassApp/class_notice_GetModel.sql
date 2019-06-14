USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_notice_GetModel]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
  
  
  
------------------------------------  
--用途：得到公告的详细信息   
--项目名称：ClassHomePage  
--说明：  
--时间：2009-1-6 9:44:05  
--exec class_notice_GetModel -110,9
------------------------------------  
CREATE  PROCEDURE [dbo].[class_notice_GetModel]  
@noticeid int,  
@userid int  
 AS  
 
 SELECT   
 noticeid,title,userid,author,kid,classid,content,createdatetime  
  FROM class_notice  
  WHERE noticeid=@noticeid   
   
 --DECLARE @readcount INT  
 --SELECT @readcount=count(1) FROM class_readlogs   
 --WHERE userid=@userid AND objectid=@noticeid AND objecttype=1  
 --IF(@readcount=0 and @userid<>0)  
 --BEGIN  
  --EXEC class_readlogs_ADD @userid,@noticeid,1  
 --END  
  
  
  
  
  
  
  
  
  
  
GO
