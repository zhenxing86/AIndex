USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_user_headpicupdate]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-06
-- Description:	修改头个
-- Memo:
*/ 
CREATE PROCEDURE [dbo].[blog_user_headpicupdate]
	@userid int = 0,
	@headpic nvarchar(200),
	@basic_userid int = 0
 AS  
BEGIN
	SET NOCOUNT ON
	
	IF isnull(@basic_userid,0) <> 0
	SELECT @userid = bloguserid FROM BasicData..user_bloguser WHERE userid = @basic_userid
	
	declare @kmpuserid int
	declare @username varchar(20)
	select @kmpuserid = userid from BasicData.dbo.user_bloguser where bloguserid = @userid
	select @username = name from basicdata..[user] where userid = @kmpuserid	
	Begin tran   
	BEGIN TRY  
		UPDATE BasicData.dbo.user_baseinfo 
			SET headpic = @headpic,
					headpicupdate = getdate()
			WHERE userid = @kmpuserid	
		
		UPDATE BasicData.dbo.[user] 
			SET headpic = @headpic,
					headpicupdate = getdate()
			WHERE userid = @kmpuserid
	     
		update kwebcms..blog_lucidateacher 
			set headpicupdate = getdate(),
					headpic = @headpic,
					name = @username  
			where userid = @userid

		update kwebcms..blog_lucidapapoose 
			set headpicupdate = getdate(),
					headpic = @headpic,
					name = @username
			where userid = @userid
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return -1        
	end Catch    
		Return 1       
    
END

GO
