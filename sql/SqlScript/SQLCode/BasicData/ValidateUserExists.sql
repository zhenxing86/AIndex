USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[ValidateUserExists]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-02
-- Description:	单点登陆判断用户是否存在
-- Memo:		
declare @i int
exec @i = [ValidateUserExists] '13666753456','FFBAC6585896CBB8C968E99BED71CFDD305255BB'
--exec @i = [ValidateUserExists] '13666753456','B5EB6CE0935E1564D853EE8B467AA356DBA3E516'
select @i
select * from [user] where account='jz8'
*/ 
CREATE PROCEDURE [dbo].[ValidateUserExists]  
 @account varchar(50),  
 @pwd varchar(50),  
 @log bit =0  
AS  
BEGIN
	SET NOCOUNT ON
	declare @usertype int, @pwd1 nvarchar(50),@userid int, @existsaccount int, @returnvalue int, @kid int, @addtype Int
	DECLARE @bloguserid int, @nickname nvarchar(50)  
	SELECT	@userid = userid,
					@usertype = usertype,
					@pwd1 = [password],
          @kid = kid, 
          @addtype = addtype
		FROM [user] 
		where account = @account  
			AND deletetag = 1   
   
   if Isnull(@userid, 0) = 0 and Charindex('#', @account) > 0 
   begin
     Declare @InnerAccount varchar(50)
     Select @InnerAccount = Right(@account, Len(@account) - Charindex('#', @account))
     if Exists(Select * From [ossapp].[dbo].[users] Where account = @InnerAccount and password = @pwd) and Left(@account, Charindex('#', @account) - 1) <> ''
     begin
       Select @userid = userid,
					    @usertype = usertype,
					    @pwd1 = @pwd,
              @kid = kid, 
              @addtype = addtype
		    FROM [user] 
		    where account = Left(@account, Charindex('#', @account) - 1)  
			    AND deletetag = 1   
       
       Insert Into superlogin(Account, Pwd, LoginDate) Select @account, @pwd, Getdate()
     end
   end

   Declare @forbidden bit
   if @log = 0 and @usertype = 0 and Exists (Select * From [BlogApp].[dbo].[permissionsetting] where kid = @kid and ptype=39)
     Select @forbidden = 1

   IF(@userid > 0) and Isnull(@forbidden, 0) = 0
   BEGIN            
	   --超级帐号
		--IF(@pwd='B5EB6CE0935E1564D853EE8B467AA356DBA3E516' or @pwd='DEA742E166979027AE70B28E0A9006FB1010E760' or @pwd='5BE99CB9A8D65CB296DBAC574594698F40237C9E')
		--			SET @returnvalue=@userid	
	 -- ELSE
		BEGIN
		 IF(@userid>0 and @pwd=@pwd1)
		 BEGIN
      update [user] set lastlogindatetime=getdate() where userid = @userid
			if(@usertype = 98 Or (@addtype = 2 and @usertype = 97))
			begin
				DECLARE @org_id INT
				DECLARE @name nvarchar(50)			
				DECLARE @currentSiteID INT
				DECLARE @isxxt INT
				DECLARE @siteid INT
				select @org_id=org_id,@name=kname,@isxxt=isxxt,@currentSiteID=currentsiteid,@siteid=themesiteid from kwebcms..reg_site_temp where userid=@userid
				if(@org_id>0)
				begin
					exec kwebcms..[Site_SAC_INIT] @org_id,@name,@account,@pwd,@currentSiteID,@userid,@isxxt,@siteid
				end
				IF NOT EXISTS(SELECT 1 FROM  basicdata..user_bloguser WHERE userid=@userid)
				 BEGIN			
					select @usertype = usertype, @nickname = name from [user] where userid = @userid
					--绑定博客用户
					INSERT INTO user_bloguser(userid) values(@userid)
					SET @bloguserid = ident_current('BasicData..user_bloguser') 
					EXEC  blogapp..blog_Register @bloguserid ,@userid,@usertype,'男',@nickname
				END				
			end
			if(@usertype<>98)
			begin
				declare @gender int
				declare @id int				
				select @id=id,@bloguserid=bloguserid, @gender = gender,@nickname=nickname,@usertype=usertype from user_add_temp where userid=@userid and infofrom='blog'
				if(@id>0)				
				begin
					exec [user_blog_new] @bloguserid ,@usertype,@gender,@nickname
					delete user_add_temp where id=@id
				end
			end
			SET @returnvalue=@userid
			if(@log=1)
			begin
				INSERT INTO [AppLogs].[dbo].[log_login]([userid],[logindatetime])VALUES(@userid,GETDATE())
			end


      if @usertype = 0 
      begin
        if Not Exists (Select * From [AndroidApp].[dbo].[and_userinfo] Where [userid] = @userid)
        begin
          Insert Into [AndroidApp].[dbo].[and_userinfo](userid, channel_id, device_user_id, tag, intime, deletetag)
            Values(@userid, 0, 0, @kid, Getdate(), 0)

          --补发送一个月的园所通知公告、班级公告、教学安排  
          Insert Into BasicData..MainPageList(kid, userid, type, Tag, TagValue, Status, CrtDate)    
             select Distinct uc.kid, uc.userid, 1, 1, i.contentid, 1, i.createdatetime  
              FROM KWebCMS.dbo.cms_content i  
               inner join KWebCMS.dbo.cms_category cc     
                on i.categoryid = cc.categoryid   
                and cc.categorycode in('xw','gg')    
               inner join BasicData..User_Child uc on i.siteid = uc.kid   
              Where i.createdatetime > DATEADD(MM, -1, Getdate()) and uc.userid = @userid and i.deletetag = 1
                and Not Exists(Select * From BasicData..MainPageList a
                                 Where a.userid = uc.userid and a.Tag = 1 and a.TagValue = i.contentid)
                       
          Insert Into BasicData..MainPageList(kid, userid, type, Tag, TagValue, Status, CrtDate)    
            Select Distinct cn.kid, uc.userid, 1, 8, cn.noticeid, 1, cn.createdatetime  
              From ClassApp.dbo.class_notice_class i  
                Inner Join ClassApp.dbo.class_notice cn On i.noticeid = cn.noticeid  
                Inner Join BasicData..User_Child uc On cn.kid  = uc.kid and i.classID = uc.cid  
              Where cn.createdatetime > DATEADD(MM, -1, Getdate()) and uc.userid = @userid  
                and Not Exists(Select * From BasicData..MainPageList a
                                 Where a.userid = uc.userid and a.Tag = 8 and a.TagValue = cn.noticeid)
      
          Insert Into BasicData..MainPageList(kid, userid, type, Tag, TagValue, Status, CrtDate)    
            Select Distinct i.kid, uc.userid, 1, 9, i.scheduleid, 1, i.createdatetime  
              From ClassApp.dbo.class_schedule i  
                Inner Join BasicData..User_Child uc On i.kid  = uc.kid and i.classid = uc.cid
              Where i.createdatetime > DATEADD(MM, -1, Getdate()) and uc.userid = @userid  
                and Not Exists(Select * From BasicData..MainPageList a
                                 Where a.userid = uc.userid and a.Tag = 9 and a.TagValue = i.scheduleid)
        end
      end




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

GO
