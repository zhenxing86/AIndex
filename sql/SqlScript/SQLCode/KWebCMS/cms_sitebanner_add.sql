USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_sitebanner_add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  create proc [dbo].[cms_sitebanner_add]  
  @siteid int,  
  @bannerurl varchar(500),  
  @title nvarchar(200)  
  as  
  begin  
  insert into Site_Banner([siteid] ,[bannerurl],[title],[orderno])  
  select @siteid,@bannerurl,@title,isnull(MAX(orderno),0)+1 from Site_Banner where siteid=@siteid  
  end
GO
