USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[company_Update]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：商家资料修改 
--项目名称：ServicePlatform
--说明：
--时间：2009-8-7 10:35:28
------------------------------------
CREATE PROCEDURE [dbo].[company_Update]
@companyid int,
@province int,
@city int,
@companyname nvarchar(50),
@companysynopsis ntext,
@tel nvarchar(50),
@linkman nvarchar(30),
@address nvarchar(50),
@qqnumber nvarchar(30),
@email nvarchar(50),
@website nvarchar(200),
@companycategoryid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @curcompanycategoryid int
	DECLARE @companystatus int
	SELECT @curcompanycategoryid=companycategoryid,@companystatus=companystatus FROM company WHERE companyid=@companyid

	DECLARE @shortname nvarchar(20)
	IF(len(@companyname)>20)
	BEGIN
		SET @shortname=substring(@companyname,1,20)
	END
	ELSE
	BEGIN
		SET @shortname=@companyname
	END

	UPDATE [company] SET 
	[province] = @province,[city] = @city,[companyname] = @companyname,[shortname]=@shortname,[companysynopsis] = @companysynopsis,[tel] = @tel,[linkman] = @linkman,[address] = @address,[qqnumber] = @qqnumber,[email] = @email,[website] = @website,[companycategoryid] = @companycategoryid,updatetime=getdate()
	WHERE companyid=@companyid 
	
	IF(@curcompanycategoryid<>@companycategoryid and @companystatus=1)
	BEGIN
		UPDATE companycategory SET companycount=companycount+1 WHERE companycategoryid=@companycategoryid
		UPDATE companycategory SET companycount=companycount-1 WHERE companycategoryid=@curcompanycategoryid
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
