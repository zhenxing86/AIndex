USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_growthbook_user_checked_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[rep_growthbook_user_checked_Update]
 @kid int,
 @cid int,
 @uid int,
 @term varchar(20),
 @remark varchar(max)
 
 AS 
 
 declare @pcount int
 select @pcount=COUNT(1) from [rep_growthbook_user_checked]  WHERE [kid] = @kid and [cid] = @cid and [uid] = @uid and [term] = @term
 
 if(@pcount>0)
 begin 
	UPDATE [rep_growthbook_user_checked] SET [remark] = @remark
	WHERE [kid] = @kid and [cid] = @cid and [uid] = @uid and [term] = @term 
end
 else
 begin
	INSERT INTO [rep_growthbook_user_checked]([kid],[cid],[uid],[term],[remark])
 	VALUES(@kid,@cid,@uid,@term,@remark)
 end
 


GO
