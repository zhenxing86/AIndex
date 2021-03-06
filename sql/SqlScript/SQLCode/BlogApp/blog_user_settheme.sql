USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_user_settheme]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
------------------------------------  
--用途：设置个人模板   
--项目名称：ZGYEYBLOG  
--说明：  
--时间：2008-11-19 09:17:07  
------------------------------------  
CREATE PROCEDURE [dbo].[blog_user_settheme]  
@userid int,  
@themeid int  
 AS   
  
  if exists (select 1 from blog_baseconfig where userid=@userid )
  begin
	 UPDATE blog_baseconfig 
	  SET [themes]=@themeid  
	 WHERE userid=@userid  
  end
  else
  begin
     declare @username nvarchar(50),@lastposttitle nvarchar(200)='我的我的成长档案开通啦开通了',
      @blogurl nvarchar(50)='http://blog.zgyey.com/'+cast(@userid as varchar)+'/index.html'
      
      select @username=u.name
       from BasicData..[user] u
        left join BasicData..user_bloguser ub 
         on u.userid=ub.userid
       where ub.bloguserid=@userid
       
     insert into blog_baseconfig(userid,blogtitle,description,themes,lastposttitle,blogurl)
      select @userid,@username,@username+'个人描述',@themeid,@lastposttitle,@blogurl
  end
  
 IF @@ERROR <> 0   
 BEGIN     
    RETURN(-1)  
 END  
 ELSE  
 BEGIN    
    RETURN (1)  
 END  
  

GO
