USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[remindsms_Read]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[remindsms_Read]
@rid int,
@userid int

 AS
INSERT INTO remindsmsread(rid,userid,readtime)
select @rid,@userid,getdate() 
where   not exists (SELECT 1 FROM remindsmsread c WHERE c.rid=@rid and userid=@userid)

update remindsmscount  set unreadcount=unreadcount-1,readcount=readcount+1 where userid=@userid


IF @@ERROR <> 0 
	BEGIN 
		RETURN(-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END



GO
