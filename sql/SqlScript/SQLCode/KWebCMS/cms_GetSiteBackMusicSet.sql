USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_GetSiteBackMusicSet]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--获取站点背景音乐设置  
CREATE proc [dbo].[cms_GetSiteBackMusicSet]  
@siteid int  
as   
declare @openbackmusic int  
select @openbackmusic=ISNULL(openbackmusic,1) from site_config where siteid=@siteid  
return @openbackmusic
GO
