USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[confirmdownloadapply]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[confirmdownloadapply]
@gbid int,
@userid int,
@recmobile nvarchar(20)
 AS 	
update [EBook].[dbo].[GBDownloadList] set recmobile=@recmobile,status=1
 where userid=@userid and growthbookid=@gbid
and status=-1
	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN (-1)
	END
	ELSE
	BEGIN	
	   RETURN (1)
	END







GO
