USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_theme_category_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[site_theme_category_GetList]    Script Date: 05/14/2013 14:43:18 ******/
CREATE PROCEDURE [dbo].[site_theme_category_GetList]  
 @siteid int  
AS  
BEGIN   
    
 declare @count int,@rcount int  
    select @count=COUNT(1) from site_themelist where siteid=@siteid   
  

  
 select @rcount=COUNT(1) from KWebCMS..[site] s  
 inner join KWebCMS_Right..sac_site_instance si   
   on si.org_id=s.org_id  
 inner join KWebCMS_Right..sac_site_right sr  
   on sr.site_instance_id=si.site_instance_id  
 where s.siteid=@siteid and sr.right_code='YEYWZHT_MBQH'  
 

  
 if(@count=0)  
 begin  
  if(@rcount=0)  
  begin  
   select * from  site_themeCategory ORDER BY id DESC  
  end  
  else
	 begin
	  select * from  site_themeCategory where id=1 ORDER BY id DESC  
	 end 
 end
 else
 begin
  select * from  site_themeCategory where id=1 ORDER BY id DESC  
 end 


  
END  

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_theme_category_GetList', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
