USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[submitdownloadapply]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[submitdownloadapply]
@gbid int,
@userid int,
@kid int,
@reapply int
 AS 	
if(not exists(select * from GBDownloadList where userid=@userid and growthbookid=@gbid and status=-1))
begin

INSERT INTO [EBook].[dbo].[GBDownloadList]
           ([userid]
           ,[gendate]
           ,[growthbookid]
           ,[isdownload]
           ,[downloadpath]
           ,[applydate]
           ,[downloaddate]
           ,[status]
           ,[recmobile]
           ,[kid],[reapply])
     VALUES
           (@userid,
           null
           ,@gbid
           ,0
           ,''
           ,getdate()
           ,null
           ,-1
           ,''
           ,@kid,@reapply)
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
