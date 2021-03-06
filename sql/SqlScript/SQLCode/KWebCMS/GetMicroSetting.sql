USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[GetMicroSetting]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
  -- 获取微网站设置，如果是个性化的网站，并且ismicrosite=1，则可以进入微网站
  --如果不是个性化的网站都可以进入微网站
  CREATE proc [dbo].[GetMicroSetting]
  @siteid int
  as 
  begin
	  declare @ismicrosite int ,@ispersonalize int
	  select @ismicrosite=isnull(ismicrosite,0) from site_config where siteid=@siteid
	  if exists(select (1) from site_themelist where siteid=@siteid and title like 'k%' and status=1 )--如果是个性化的网站
	  begin
		if(@ismicrosite=1)
	  begin
		return 1
	  end 
	  else
	  begin
		return 0
	  end
	  end
	  return 1
  end
  
  
 
 
GO
