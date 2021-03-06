USE BasicData
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE user_ADD
	@account nvarchar(50),
	@password nvarchar(50),
	@usertype int
AS 
	INSERT INTO [user](
	[account],[password],[usertype],[deletetag],[regdatetime]
	)VALUES(
	@account,@password,@usertype,1,getdate()
	)
    DECLARE @userid int
	SET @userid = @@IDENTITY
	INSERT INTO [user_baseinfo]([userid],[name],[nickname],[birthday],[gender],[nation],[mobile],[email],[address],[enrollmentdate],headpic)
    VALUES(@userid,'管理员','管理员',GETDATE(),3,0,'','','',GETDATE(),'AttachsFiles/default/headpic/default.jpg')
	IF(@usertype>0)
	begin
		INSERT INTO [teacher]([userid],[did],[title],[post],[education],[employmentform],[politicalface])
		VALUES(@userid,null,'','','','','')
	end
	else
	begin
		INSERT INTO [child]([userid],[fathername],[mothername],[favouritething],[fearthing],[favouritefoot],[footdrugallergic])
		VALUES(@userid,'','','','','','')
	end
	
	IF @@ERROR <> 0 
	BEGIN			
		RETURN(-1)
	END
	ELSE
	BEGIN	
	     DECLARE @bloguserid int	
		--绑定博客用户
	     INSERT INTO user_bloguser values(@userid)
		 SET @bloguserid = @@IDENTITY

	     EXEC  blogapp..blog_Register @bloguserid,@userid,@usertype,'男',''

		 
	     RETURN @userid
	END
GO
