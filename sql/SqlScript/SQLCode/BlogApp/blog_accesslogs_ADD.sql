USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_accesslogs_ADD]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE PROCEDURE [dbo].[blog_accesslogs_ADD] 
@userid int,
@fromeuserid int
 AS 	
	DECLARE @tmp int
	DECLARE @lastaccessdatetime datetime

	if( @userid>0 and @fromeuserid>0)
	begin
		SELECT top 1 @tmp = userid,@lastaccessdatetime=accessdatetime FROM AppAccessLogs.dbo.blog_accesslogs
		WHERE userid=@userid and fromeuserid=@fromeuserid
		

		IF (@tmp>0)
		BEGIN
			UPDATE AppAccessLogs.dbo.blog_accesslogs SET accessdatetime=getdate() WHERE userid=@userid and fromeuserid=@fromeuserid
		END
		ELSE
		BEGIN
		
			if( @userid>0 and @fromeuserid>0)
				begin
			INSERT INTO AppAccessLogs.dbo.blog_accesslogs(
			[userid],[fromeuserid],[accessdatetime]
			)VALUES(
			@userid,@fromeuserid,getdate()
			)
			SET @lastaccessdatetime=getdate()-1
				end
		END
	end

	IF(DATEDIFF(S,@lastaccessdatetime,getdate()) > 30)
	BEGIN	
		--更新博客访问数
		UPDATE blog_baseconfig SET visitscount=visitscount+1 
		WHERE userid=@userid		
	END



	IF @@ERROR <> 0 
	BEGIN 
		
	   RETURN(-1)
	END
	ELSE
	BEGIN
		
	   RETURN (1)
	END








--select * FROM AppAccessLogs.dbo.blog_accesslogs where userid=248707


delete FROM AppAccessLogs.dbo.blog_accesslogs where [fromeuserid]=0


GO
