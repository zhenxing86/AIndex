USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[Manage_child_ADD]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Manage_child_ADD]
@Kid int,
@ClassId int,
@Loginname nvarchar(50),
@Username nvarchar(30),
@Gender int,
@Birthday datetime,
@Mobile	nvarchar(20),
@Enrollmentdate datetime
 AS 
 	declare @password nvarchar(40)
	set @password = '7C4A8D09CA3762AF61E59520943DC26494F8941B'
	INSERT INTO BasicData.dbo.[user]([account],[password],[usertype],[deletetag],[regdatetime],[name],[nickname],[birthday],[gender],[nation],[mobile],[email],[address],[enrollmentdate],headpic)
	VALUES(@Loginname,@password,0,1,getdate(),@Username,@Username,@Birthday,@Gender,0,@Mobile,'','',@Enrollmentdate,'AttachsFiles/default/headpic/default.jpg'	)
    DECLARE @userid int
	SET @userid = ident_current('BasicData..user') 
	INSERT INTO BasicData.dbo.[user_baseinfo]([userid],[name],[nickname],[birthday],[gender],[nation],[mobile],[email],[address],[enrollmentdate],headpic)
    VALUES(@userid,@Username,@Username,@Birthday,@Gender,0,@Mobile,'','',@Enrollmentdate,'AttachsFiles/default/headpic/default.jpg')

		INSERT INTO BasicData.dbo.[child]([userid],[fathername],[mothername],[favouritething],[fearthing],[favouritefoot],[footdrugallergic])
		VALUES(@userid,'','','','','','')		
	declare @genderstr nvarchar(5)
	if(@Gender=3)
	begin
		set @genderstr='男'
	end
	else
	begin
		set @genderstr='女'
	end
	
update basicdata.dbo.[user] 
		set kid = @kid 
			where userid = @userid 

INSERT INTO basicdata..[user_class]([cid],[userid])values(@ClassId,@userid)
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

insert into basicdata..user_add_temp(userid,usertype,gender,nickname,infofrom,bloguserid)
values(@userid,0,@Gender,@Username,'blog',@bloguserid)

	    -- EXEC  blogapp..blog_Register @bloguserid,@userid,0,@genderstr,@Username
	     RETURN @userid
	END

GO
