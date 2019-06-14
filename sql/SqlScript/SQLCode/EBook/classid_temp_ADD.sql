USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[classid_temp_ADD]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[classid_temp_ADD]
@classid int,
@tempid int	
 AS 	
if(not exists(select * from cid_temp where classid=@classid and tempid=@tempid))
begin
    insert into cid_temp(classid,tempid,actiondate)
     values(@classid,@tempid,getdate())
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
