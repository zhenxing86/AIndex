USE [fmcapp]
GO
/****** Object:  StoredProcedure [dbo].[fmc_microvideo_Add]    Script Date: 06/18/2013 18:06:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：新增微视频信息
--项目名称：家庭教育中心 com.zgyey.fmcapp.cms  
--说明: 
--时间：2013-6-17 15:50:29
--exec fmc_microvideo_Add '幼儿成长','幼儿成长专题','sfsadfdsaf','http://www.hao123.com/',123,'2013-06-17 10:00:00',1
------------------------------------
ALTER PROCEDURE [dbo].[fmc_microvideo_Add]
@title	varchar(100),
@describe	nvarchar(500),
@smallimg	nvarchar(100),
@url	varchar(300),
@uid	int,
@intime	datetime,
@click	int,
@deletetag	int

AS 
INSERT INTO [fmc_microvideo](title,describe,smallimg,url,[uid],intime,click,deletetag)
  VALUES(@title,@describe,@smallimg,@url,@uid,@intime,@click,@deletetag)

declare @ID int
set @ID=@@IDENTITY
RETURN @ID




