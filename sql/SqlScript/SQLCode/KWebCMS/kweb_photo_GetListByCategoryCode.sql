USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_photo_GetListByCategoryCode]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-07-20  
-- Description: 获得首页图片  
-- Memo:   KWebCMS_Temp..[kweb_photo_GetIndex] 'yezp',14499,1,10     
select 1 from tryend_kid where kid=23724
kweb_photo_GetListByCategoryCode 'yezp',23724,1,10    
*/  
CREATE PROCEDURE [dbo].[kweb_photo_GetListByCategoryCode]  
 @categorycode nvarchar(10),  
 @siteid int,  
 @page int,  
 @size int  
AS  
BEGIN    
 if(      exists(select 1 from theme_kids where kid=@siteid)     
  or not exists(select 1 from cms_album where siteid=@siteid)    
  or     exists(select 1 from tryend_kid where kid=@siteid)    
  )    
 begin    
  exec KWebCMS_Temp..[kweb_photo_GetIndex] @categorycode,14499,@page,@size    
 end    
 else if(    
 not exists(    
       SELECT photoid     
        FROM cms_photo cp   
         left join cms_album a on cp.albumid=a.albumid   and a.deletetag=1  
         join cms_category cc     
          on cp.categoryid = cc.categoryid    
        WHERE categorycode = @categorycode    
         and (cp.siteid = @siteid or a.siteid=@siteid )   
         and cp.indexshow = 1    
      )    
    )    
 begin    
  exec KWebCMS_Temp..[kweb_photo_GetIndex] @categorycode,14499,@page,@size    
 end    
 else    
 begin    
  SET ROWCOUNT @size    
   SELECT photoid,cp.categoryid,cp.albumid,cp.title,[filename],filepath,filesize,commentcount,indexshow,flashshow,cp.createdatetime,cp.net,newid()     
   FROM cms_photo cp  
   left join cms_album a on cp.albumid=a.albumid   and a.deletetag=1
    join cms_category cc     
     on cp.categoryid=cc.categoryid    
   WHERE categorycode = @categorycode    
     and (cp.siteid = @siteid or a.siteid=@siteid)   
     and cp.indexshow = 1    
     and cp.deletetag = 1  
   ORDER BY newid()     
 end    
END   
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_photo_GetListByCategoryCode', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_photo_GetListByCategoryCode', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_photo_GetListByCategoryCode', @level2type=N'PARAMETER',@level2name=N'@page'
GO
