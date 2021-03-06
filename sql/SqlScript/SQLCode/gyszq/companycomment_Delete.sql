USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companycomment_Delete]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除商家评论记录 
--项目名称：
--说明：
--时间：2009-7-11 14:48:59
------------------------------------
CREATE PROCEDURE [dbo].[companycomment_Delete]
@companycommentid int,
@companyid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	
	DECLARE @temp INT
	SELECT @temp=companyid FROM companycomment WHERE companycommentid=@companycommentid

	IF(@companyid=@temp)
	BEGIN
--		DELETE [companycomment]
--		 WHERE companycommentid=@companycommentid 
		UPDATE companycomment SET status=-1 WHERE companycommentid=@companycommentid
		UPDATE company SET companycommentcount=companycommentcount-1 WHERE companyid=@companyid
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (-2)
	END

	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN (-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (1)
	END
GO
