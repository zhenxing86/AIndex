USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[classid_temp_ADD]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[classid_temp_ADD]
@classid int,
@tempid int	
 AS 	
if(not exists(select * from ebook..cid_temp where classid=@classid and tempid=@tempid))
begin
    insert into ebook..cid_temp(classid,tempid,actiondate)
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
