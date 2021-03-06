USE [fmcapp]
GO
/****** Object:  StoredProcedure [dbo].[fmc_microvideo_Add]    Script Date: 2014/11/24 23:06:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
--用途：新增微视频信息  
--项目名称：家庭教育中心 com.zgyey.fmcapp.cms    
--说明:   
--时间：2013-6-17 15:50:29  
--exec fmc_microvideo_Add '幼儿成长','幼儿成长专题','sfsadfdsaf','http://www.hao123.com/',123,'2013-06-17 10:00:00',1,0  
------------------------------------  
CREATE PROCEDURE [dbo].[fmc_microvideo_Add]  
@title varchar(100),  
@describe nvarchar(500),  
@smallimg nvarchar(100),  
@url varchar(300),  
@uid int,  
@intime datetime,  
@click int,  
@deletetag int,  
@freetag int,  
@mp4url varchar(500),  
@ownmp4url varchar(500),  
@ownurl varchar(500),
@mobilepicurl varchar(500)  
  
AS   
INSERT INTO [fmc_microvideo](title,describe,smallimg,url,[uid],intime,click,deletetag,freetag,mp4url,ownurl,ownmp4url,mobilepicurl)  
  VALUES(@title,@describe,@smallimg,@url,@uid,@intime,@click,@deletetag,@freetag,@mp4url,@ownurl,@ownmp4url,@mobilepicurl)  
  
declare @ID int  
set @ID=@@IDENTITY  
RETURN @ID  
GO
