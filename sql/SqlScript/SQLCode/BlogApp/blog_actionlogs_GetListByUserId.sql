USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_actionlogs_GetListByUserId]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-12
-- Description: 取最新动态	
-- Memo:
	exec blog_actionlogs_GetListByUserId 22874 		
*/
CREATE PROCEDURE [dbo].[blog_actionlogs_GetListByUserId]  
	@userid int   
AS
BEGIN 
	SET NOCOUNT ON  	
	DECLARE @kid int, @count int 
	   
	SELECT @kid = u.kid 
		FROM BasicData.dbo.user_bloguser ub 
			inner join BasicData.dbo.[user] u
				on ub.userid = u.userid 
		WHERE bloguserid = @userid  
		
	IF(@kid>0)  
	BEGIN  		
		DECLARE  @activity TABLE  
		(  
			 actionuserid int,  
			 actionusername nvarchar(30),   
			 actiondescription nvarchar(200),  
			 actiondatetime datetime,   
			 headpic nvarchar(200),   
			 headpicupdate datetime   
		)  
		
		 INSERT INTO @activity  
										(actionuserid, actionusername, actiondescription, actiondatetime, headpic, headpicupdate)  
		 	SELECT top(10) actionuserid, actionusername, actiondesc, actiondatetime, u.headpic, u.headpicupdate
				from AppLogs.dbo.blog_new_actionlogs bn 
					inner join BasicData.dbo.user_bloguser ub on bn.actionuserid = ub.bloguserid 
					inner join BasicData.dbo.[user] u on ub.userid = u.userid
				WHERE u.kid = @kid 
					AND DATEADD(hh,-49,GETDATE()) < bn.actiondatetime  	
					and DATEADD(DD,-3,GETDATE()) > u.regdatetime     
			 order by bn.actiondatetime desc  	     
		 
		set @count = @@ROWCOUNT 		 
			SELECT	actionuserid, actionusername, actiondescription, 
							actiondatetime, headpic, headpicupdate 
				FROM @activity   
		union all  
			select	top (20 - @count) actionuserid, actionusername, 
							actiondesc, actiondatetime, headpic,headpicupdate 
				from AppLogs.dbo.blog_tmp_actionlogs   
				order by actiondatetime desc  
 END  
 ELSE  
 BEGIN  
		select	actionuserid, actionusername, actiondesc, 
						actiondatetime, headpic, headpicupdate 
			from AppLogs.dbo.blog_tmp_actionlogs  
				order by actiondatetime desc  
 END
END  

GO
