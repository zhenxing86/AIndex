USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_kwebcms_right_add]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-01
-- Description:	修改一条用户详细信息记录
-- Memo:		
*/ 
CREATE Procedure [dbo].[user_kwebcms_right_add]
	@loginname nvarchar(50),
	@password nvarchar(50),
	@username nvarchar(20),
	@kid int,
	@userid int
AS
BEGIN
	DECLARE @right_userid int,@org_id int,@cmsuserid int
	IF NOT EXISTS(SELECT 1 FROM kwebcms..site_user WHERE appuserid=@userid and [UID]>0)
	BEGIN
		SELECT	@loginname = account,
						@password = [password],
						@username = name,
						@kid = kid 
			from [user] 
			where userid = @userid
		SELECT @org_id = org_id 
			FROM kwebcms..[site] 
			WHERE siteid = @Kid		
		Begin tran   
		BEGIN TRY  
			INSERT INTO KWebCMS_Right..sac_user
						(account, password, username, createdatetime, org_id, status)
			VALUES(@loginname, @password, @username, getdate(), @org_id, 1)		
			SELECT @right_userid = @@IDENTITY	
			
			INSERT INTO kwebcms..site_user(siteid, createdatetime, appuserid, [UID]) 
				VALUES(@Kid, GETDATE(), @userid, @right_userid)
			SET @cmsuserid = @@IDENTITY		

			Commit tran                              
		End Try      
		Begin Catch      
			Rollback tran   
			Return -1       
		end Catch  
	END
	else
	begin
		SELECT @right_userid = [UID] 
			FROM kwebcms..site_user 
			WHERE appuserid = @userid
	end

	return @right_userid
END

GO
