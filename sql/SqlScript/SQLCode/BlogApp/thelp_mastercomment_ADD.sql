USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_mastercomment_ADD]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：增加园长点评 
--项目名称：zgyeyblog
--说明：
--时间：2009-2-3 10:20:28
------------------------------------
CREATE PROCEDURE [dbo].[thelp_mastercomment_ADD]
@docid int,
@content nvarchar(500),
@userid int,
@author nvarchar(30),
@parentid int

 AS 
	INSERT INTO thelp_mastercomment(
	[docid],[content],[userid],[author],[commentdatetime],[parentid]
	)VALUES(
	@docid,@content,@userid,@author,getdate(),@parentid
	)

	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
		RETURN @@IDENTITY
	END






GO
