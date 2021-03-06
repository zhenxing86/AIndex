USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[and_hb_photo_term]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      蔡杰    
-- Create date: 2014-04-15      
-- Description: 手机客户端生活剪影/手工作品数据    
-- Memo:   
and_hb_photo_term      
*/       
Alter Procedure [and_hb_photo_term]    
@uid Int,    
@type Int--1表示生活剪影, 2表示手工作品    
as    

Declare @cid int, @term varchar(6)  
Select @cid = cid From basicdata.dbo.user_class Where userid = @uid
Select @term = CommonFun.dbo.fn_getCurrentTerm(kid, GETDATE(), 1)   
  From BasicData.dbo.[user] u  
  Where u.userid = @uid and kid>0 and deletetag=1 and usertype>0   

 SELECT ca.cid,ca.cname,hb.term, hb.hbid    
  FROM HomeBook hb      
   inner join BasicData..class ca       
    on hb.cid = ca.cid and ca.deletetag=1
  Where hb.term = @term and ca.cid = @cid
   order by term DESC,cname   

Select b.gbid, b.userid, u.name, SUM(Case When c.gbid > 0 Then 1 Else 0 End) photocount, Isnull(k.headpic, '') headpic, b.term, @cid cid
  From BasicData.dbo.user_class a 
	Inner Join BasicData.dbo.[User] u On a.userid = u.userid and u.usertype=0   
  Left Join  kmapp.dbo.km_user k On u.userid = k.userid
    Inner Join NGBApp.dbo.growthbook b On a.userid = b.userid 
    Left Join NGBApp.dbo.tea_UpPhoto c On b.gbid = c.gbid and c.deletetag = 1 and pictype = @type    
  Where a.cid = @cid and b.term = @term
  Group by b.gbid, b.userid, u.name, Isnull(k.headpic, ''), b.term
GO
