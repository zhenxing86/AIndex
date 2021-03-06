USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companyappraise_ADD]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：增加一条商家评价记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-8-13 9:40:48
------------------------------------
CREATE PROCEDURE [dbo].[companyappraise_ADD]
@companyid int,
@level int,
@author nvarchar(30),
@userid int,
@parentid int,
@contact nvarchar(100),
@memo nvarchar(200),
@fromip nvarchar(30)

 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @companyappraiseid int
	INSERT INTO [companyappraise](
	[companyid],[level],[author],[userid],[parentid],[contact],[memo],[appraisedatetime],[fromip],[status]
	)VALUES(
	@companyid,@level,@author,@userid,@parentid,@contact,@memo,getdate(),@fromip,1
	)
	SET @companyappraiseid = @@IDENTITY
	UPDATE company SET companyappraisecount=companyappraisecount+1 WHERE companyid=@companyid 

IF(@@ERROR<>0)
BEGIN
	ROLLBACK TRANSACTION
	RETURN (-1)
END
ELSE
BEGIN
	COMMIT TRANSACTION
	RETURN @companyappraiseid
END

GO
