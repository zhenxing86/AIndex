USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[Manage_RestoreChildFromhistory]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[Manage_RestoreChildFromhistory] 206022
CREATE PROCEDURE [dbo].[Manage_RestoreChildFromhistory]
@userid int
AS
declare @kid int
declare @cid int
declare @hasinclass int

select @hasinclass = count(*) from basicdata.dbo.user_class where userid=@userid

if(@hasinclass=0)
begin
	select @cid=cid from basicdata.dbo.user_class_history where userid=@userid
	select @kid=kid from basicdata.dbo.user_kindergarten_history where userid=@userid

	insert into basicdata.dbo.user_class (userid,cid) values(@userid,@cid)

	update basicdata.dbo.[user] set deletetag=1, kid = @kid where userid=@userid

	delete from basicdata.dbo.user_class_history where userid=@userid
	delete from basicdata.dbo.user_kindergarten_history where userid=@userid
end


	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN (-1)
	END
	ELSE
	BEGIN	
	   RETURN (1)
	END

GO
