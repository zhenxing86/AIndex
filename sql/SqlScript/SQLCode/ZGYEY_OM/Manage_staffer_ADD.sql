USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[Manage_staffer_ADD]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Manage_staffer_ADD]
@Kid int,
@loginname nvarchar(30),
@username nvarchar(30),
@gender int,
@birthday nvarchar(25),	
@mobile nvarchar(20),
@departmentid int,
@usertype int,
@gw nvarchar(30),
@edu nvarchar(30),
@title nvarchar(30),
@poli nvarchar(30),
@kinschooltag nvarchar(30)
 AS 
 	declare @password nvarchar(40)
	set @password = '7C4A8D09CA3762AF61E59520943DC26494F8941B'
	INSERT INTO BasicData.dbo.[user](
	[account],[password],[usertype],[deletetag],[regdatetime],[name],[nickname],[birthday],[gender],[nation],[mobile],[email],[address],[enrollmentdate],headpic
	)VALUES(
	@Loginname,@password,@usertype,1,getdate(),@Username,@Username,@Birthday,@Gender,0,@Mobile,'','',getdate(),'AttachsFiles/default/headpic/default.jpg'
	)
    DECLARE @userid int
	SET @userid = ident_current('BasicData..user') 
	INSERT INTO BasicData.dbo.[user_baseinfo]([userid],[name],[nickname],[birthday],[gender],[nation],[mobile],[email],[address],[enrollmentdate],headpic)
    VALUES(@userid,@Username,@Username,@Birthday,@Gender,0,@Mobile,'','',getdate(),'AttachsFiles/default/headpic/default.jpg')

	INSERT INTO BasicData.dbo.[teacher]([userid],[did],[title],[post],[education],[employmentform],[politicalface],[kinschooltag])
	VALUES(@userid,@departmentid,@gw,@title,@edu,'',@poli,@kinschooltag)

	declare @genderstr nvarchar(5)
	if(@Gender=3)
	begin
		set @genderstr='男'
	end
	else
	begin
		set @genderstr='女'
	end
	
	EXEC BasicData.dbo.[user_kindergarten_ADD] @userid,@Kid

	update basicdata.dbo.[user] 
		set kid = @kid 
			where userid = @userid 

	DECLARE @right_userid INT
	DECLARE @site_instance_id int
	DECLARE @role_id int
	EXEC @right_userid=BasicData.[dbo].[user_kwebcms_right_add] @Loginname,@password,@Username,@Kid,@userid
	select @site_instance_id=t2.site_instance_id from kwebcms.dbo.[site] t1 inner join kwebcms_right.dbo.sac_site_instance t2 on t1.org_id=t2.org_id and site_id=1 where t1.siteid=@Kid
	if(@usertype=98)
	begin
		select @role_id=role_id from kwebcms_right.dbo.sac_role where site_instance_id=@site_instance_id and role_name='管理员'
	end
	else if(@usertype=97)
	begin
		select @role_id=role_id from kwebcms_right.dbo.sac_role where site_instance_id=@site_instance_id and role_name='园长'
	end
	else
	begin
		select @role_id=role_id from kwebcms_right.dbo.sac_role where site_instance_id=@site_instance_id and role_name='老师'
	end
	insert into kwebcms_right.dbo.sac_user_role(user_id,role_id) values(@right_userid,@role_id)

	IF @@ERROR <> 0 
	BEGIN			
		RETURN(-1)
	END
	ELSE
	BEGIN	
	     DECLARE @bloguserid int
		--绑定博客用户
	     INSERT INTO BasicData.dbo.user_bloguser values(@userid)
		 SET @bloguserid = ident_current('BasicData..user_bloguser') 
	     EXEC  blogapp..blog_Register @bloguserid,@userid,@usertype,@genderstr,@Username
	     RETURN @userid
	END

GO
