USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_sitebannerList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--获取appbanner
-- =============================================          
CREATE proc [dbo].[cms_sitebannerList]      
@siteid int      
as      
begin      
declare @count int    
select @count=COUNT(1) from Site_Banner where siteid=@siteid    
select @count pcount,id,title,bannerurl,siteid from Site_Banner where siteid=@siteid  order by orderno desc    
end  
GO
