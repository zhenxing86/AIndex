USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[class_accesslogs_ADD]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[class_accesslogs_ADD]
@classid int,
@fromuserid int
 AS 

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	
	DECLARE @tmp int
	DECLARE @lastaccessdatetime datetime
	SELECT top 1 @tmp = classid,@lastaccessdatetime=accessdatetime FROM class_accesslogs
	WHERE classid=@classid and fromeuserid=@fromuserid
	order by accessdatetime desc		

	IF (@tmp>0)
	BEGIN
		IF(DATEDIFF(S,@lastaccessdatetime,getdate()) > 30)
		BEGIN
			UPDATE class_accesslogs SET accessdatetime=getdate()
			WHERE classid=@classid and fromeuserid=@fromuserid
		END
	END
	ELSE
	BEGIN
		INSERT INTO class_accesslogs(
		[classid],[fromeuserid],[accessdatetime]
		)VALUES(
		@classid,@fromuserid,getdate()
		)
	--	SET @lastaccessdatetime=getdate()-1
	END

	--IF(DATEDIFF(S,@lastaccessdatetime,getdate()) > 30)
	--BEGIN	
		--更新博客访问数
		--UPDATE blog_baseconfig SET visitscount=visitscount+1 
		--WHERE userid=@userid
	--END
	
	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN (1)
	END

GO
