USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companycomment_ADD]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：增加一条商家评论记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 14:21:32
------------------------------------
CREATE PROCEDURE [dbo].[companycomment_ADD]
@companyid int,
@author nvarchar(30),
@userid int,
@content ntext,
@parentid int,
@contact nvarchar(100),
@fromip nvarchar(30)

 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION 

	DECLARE @companycommentid INT	

	INSERT INTO [companycomment](
	[companyid],[author],[userid],[content],[parentid],[commentdatetime],[contact],[fromip],[status]
	)VALUES(
	@companyid,@author,@userid,@content,@parentid,getdate(),@contact,@fromip,1
	)
	SET @companycommentid = @@IDENTITY

	UPDATE company SET companycommentcount=companycommentcount+1 WHERE companyid=@companyid

	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN (-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (@companycommentid)
	END

GO
