USE [AppConfig]
GO
/****** Object:  StoredProcedure [dbo].[Get_ISYXTByKid]    Script Date: 2014/11/24 21:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[Get_ISYXTByKid]
@siteid int
 AS 
	
	select count(1) from appconfig..tem_kidapp where opkid=@siteid and appid=29


GO
