USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_GetUnReadCount]    Script Date: 05/14/2013 14:54:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------------------------------------------------------

alter PROCEDURE [dbo].[blog_messagebox_GetUnReadCount]
@userid int=0
 AS

declare @messageboxcount int


SELECT	@messageboxcount=COUNT(1)			
		FROM BasicData..FriendSMS fs
		where fs.touserid = @userid
			and fs.IsRead = 0 and deletetag=1

	select @messageboxcount
	
	RETURN @messageboxcount
GO

[blog_messagebox_GetUnReadCount] 705830

