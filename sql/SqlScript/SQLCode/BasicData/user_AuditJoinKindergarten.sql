USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_AuditJoinKindergarten]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[user_AuditJoinKindergarten]
@userid int
 AS 
	declare @kid int
	declare @cid int
	select @kid=kid from tem_user_kindergarten where userid=@userid
	EXEC user_kindergarten_ADD @userid,@kid
	delete tem_user_kindergarten where userid=@userid and kid=@kid
	select @cid=cid from tem_user_class where userid=@userid
	if (@cid>0)
	begin
		EXEC user_class_ADD @cid,@userid
		delete tem_user_class where userid=@userid and cid=@cid
	end
	
	if(@@ERROR<>0)
	begin
		return (-1)
	end
	else
	begin
		return (1)
	end




GO
