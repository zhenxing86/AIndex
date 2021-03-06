USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[and_hb_photo_GetList]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      蔡杰    
-- Create date: 2014-04-15      
-- Description: 手机客户端生活剪影/手工作品数据    
-- Memo:   
and_hb_photo_GetList      
*/       
CREATE Procedure [dbo].[and_hb_photo_GetList]    
@cid Int,    
@term Varchar(50),    
@type Int--1表示生活剪影, 2表示手工作品    
as    
    
Select b.gbid, b.userid, u.name, SUM(Case When c.gbid > 0 Then 1 Else 0 End) photocount, Isnull(k.headpic, '') headpic
  From BasicData.dbo.user_class_all a 
	Inner Join BasicData.dbo.[User] u On a.userid = u.userid and a.deletetag=1 and u.usertype=0   
  Left Join  kmapp.dbo.km_user k On u.userid = k.userid
    Inner Join NGBApp.dbo.growthbook b On a.userid = b.userid  and b.term=a.term  
    Left Join NGBApp.dbo.tea_UpPhoto c On b.gbid = c.gbid and c.deletetag = 1 and pictype = @type    
  Where a.cid = @cid and b.term = @term    
  Group by b.gbid, b.userid, u.name, Isnull(k.headpic, '')
GO
