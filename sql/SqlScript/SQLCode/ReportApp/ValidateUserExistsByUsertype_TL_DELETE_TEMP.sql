USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[ValidateUserExistsByUsertype_TL_DELETE_TEMP]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
  
create PROCEDURE [dbo].[ValidateUserExistsByUsertype_TL_DELETE_TEMP]  
@account varchar(50),  
@pwd varchar(50),  
@utype int  
AS  
BEGIN  
   DECLARE @userid int,@existsaccount int,@returnvalue int  
   SELECT @existsaccount=COUNT(1) FROM [user] where account=@account and usertype=@utype and deletetag=1  
     
   IF(@existsaccount>0)  
   BEGIN  
   declare @usertype int  
            DECLARE @bloguserid int  
            declare @nickname nvarchar(50)  
   --超级帐号  
 IF(@pwd='B5EB6CE0935E1564D853EE8B467AA356DBA3E516')  
     BEGIN  
     SELECT @userid=userid FROM [user] where account=@account  AND  deletetag=1  
     IF(@userid>0)  
     BEGIN  
   SET @returnvalue=@userid     
  
   IF NOT EXISTS(SELECT * FROM  basicdata..user_bloguser WHERE userid=@userid)  
            BEGIN   
  
            select @usertype=t1.usertype,@nickname=t2.name from [user] t1 inner join user_baseinfo t2 on t1.userid=t2.userid where t1.userid=@userid  
  
             --绑定博客用户  
          INSERT INTO user_bloguser(userid) values(@userid)  
          set @bloguserid=@@identity  
              EXEC  blogapp..blog_Register @bloguserid ,@usertype,'男',@nickname  
   END  
     END  
     END  
   ELSE  
    BEGIN  
     SELECT @userid=userid From [user] WHERE account=@account and [password]=@pwd AND deletetag=1  
  
     IF(@userid>0)  
     BEGIN  
   SET @returnvalue=@userid  
  
            update [user] set lastlogindatetime=getdate() where userid=@userid  
   IF NOT EXISTS(SELECT * FROM  basicdata..user_bloguser WHERE userid=@userid)  
            BEGIN   
     
            select @usertype=t1.usertype,@nickname=t2.name from [user] t1 inner join user_baseinfo t2 on t1.userid=t2.userid where t1.userid=@userid  
  
             --绑定博客用户  
          INSERT INTO user_bloguser(userid) values(@userid)  
          set @bloguserid=@@identity  
              EXEC  blogapp..blog_Register @bloguserid ,@usertype,'男',@nickname  
   END  
     END  
     ELSE  
     --密码错误  
     BEGIN  
     set @returnvalue=-1  
     END  
      
    END  
   END  
     
   ELSE  
   --用户名不存在  
   BEGIN  
    set @returnvalue=-2  
   END  
     
   RETURN @returnvalue  
  
  
END  
  
  
  
  
  
  
  
  
  
GO
