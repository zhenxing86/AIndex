USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_zgyey_messagebox_GetModel]    Script Date: 05/14/2013 14:54:50 ******/
SET ANSI_NULLS On
GO
SET QUOTED_IDENTIFIER On
GO
alter PROCEDURE [dbo].[blog_zgyey_messagebox_GetModel]
@messageboxid int,
@userid int
 AS
SET NOCOUNT ON

BEGIN TRANSACTION
	

update [BasicData].[dbo].[FriendSMS] set [IsRead] = 1
		where [ID]=@messageboxid
			and [touserid] = @userid
			and [IsRead] = 0
	

	

	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
		select -1
		RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		select @messageboxid
		RETURN (1)
	END
GO

[blog_zgyey_messagebox_GetModel] 4470,755137
