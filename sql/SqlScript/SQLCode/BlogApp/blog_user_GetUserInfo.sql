USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_user_GetUserInfo]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-08-06  
-- Description: 取当前登录用户信息  
-- Memo:  
exec [blog_user_GetUserInfo] 191117  
exec [blog_user_GetUserInfo] 761569  
*/   
CREATE PROCEDURE [dbo].[blog_user_GetUserInfo]  
@userid int  
 AS  
BEGIN    
 SET NOCOUNT ON    
 SELECT  ub.bloguserid,u.account,u.nickname,u.email, u.gender,u.birthday,ub1.blogtitle,ub1.description,    
     ub1.defaultdispmode,ub1.postdispcount,ub1.themes,ub1.messagepref,ub1.postscount, ub1.albumcount,    
     ub1.photocount,ub1.visitscount,ub1.createdatetime,ub1.updatedatetime,ub1.lastposttitle,ub1.lastpostid,    
     u.headpic, u.usertype as blogtype,ub1.blogurl,ub1.integral,1,u.privince,u.city,u.[name] as truename,    
     ub1.kininfohide,u.headpicupdate as headpicupdatetime, ub1.messagepermission,u.mobile,ub1.photowatermark,isnull(k.area,0)    
  FROM BasicData.dbo.[user] u     
   INNER JOIN BasicData.dbo.user_bloguser ub on u.userid = ub.userid     
   LEFT JOIN blog_baseconfig ub1 ON ub.bloguserid = ub1.userid     
   left join BasicData..kindergarten k on k.kid=u.kid    
  WHERE ub.bloguserid = @userid    
END    

GO
