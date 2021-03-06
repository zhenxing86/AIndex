USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_site_menu_GetSubMenuList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
-- =============================================          
-- Author:          
-- Create date: 2014-08-05          
-- Description: 获取二级菜单列表           
-- =============================================          
create PROCEDURE  [dbo].[kweb_site_menu_GetSubMenuList]        
@siteid int        
AS          
BEGIN          
 declare @userid  int,@user_id int        
 select @userid= userid from BasicData..[user] where kid=@siteid and  deletetag=1 and usertype=98        
 select @user_id= [UID] from site_user where appuserid=@userid        
         
 SELECT [menuid],m.[title],[url],[target],m.[parentid],m.[categoryid],[imgpath],m.[orderno],c.categorycode FROM site_menu m    
 left join cms_category c on m.categoryid=c.categoryid           
 WHERE(m.siteid=@siteid or m.siteid=0 )        
 and m.parentid in(select menuid from site_menu where parentid in( select menuid from site_menu where (siteid=@siteid or siteid=0)))        
  and right_id in (        
 SELECT DISTINCT sac_right.right_id         
FROM KWebCMS_Right..sac_user_role           
INNER JOIN KWebCMS_Right..sac_role_right ON sac_user_role.role_id=sac_role_right.role_id          
INNER JOIN KWebCMS_Right..sac_right ON sac_role_right.right_id=sac_right.right_id          
WHERE [user_id]=@user_id          
 )          
 ORDER BY parentid,orderno asc          
END   
GO
