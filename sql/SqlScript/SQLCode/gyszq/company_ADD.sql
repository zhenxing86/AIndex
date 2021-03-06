USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[company_ADD]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：商家注册 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 9:09:49
------------------------------------
CREATE PROCEDURE [dbo].[company_ADD]
@account nvarchar(30),
@password nvarchar(100),
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
@companycategoryid int,
@isinterior int

 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION 

	DECLARE @temp INT
	EXEC @temp=[company_account_Exists] @account

	IF(@temp>0)
	BEGIN
		COMMIT TRANSACTION
		return -2	--帐号重复
	END


	DECLARE @imagepath NVARCHAR(200)	
	DECLARE @imagename NVARCHAR(100)
	DECLARE @companyid INT
	SET @imagepath='AttachsFiles/default/headpic/'
	SET @imagename='default.jpg'

	DECLARE @companystatus int
	IF(@isinterior=1)
	BEGIN
		SET @companystatus=1
	END
	ELSE
	BEGIN
		SET @companystatus=0
	END

	DECLARE @shortname nvarchar(20)
	IF(len(@companyname)>20)
	BEGIN
		SET @shortname=substring(@companyname,1,20)
	END
	ELSE
	BEGIN
		SET @shortname=@companyname
	END

	INSERT INTO [company](
	[account],[password],[province],[city],[companyname],[shortname],[companysynopsis],[tel],[linkman],[address],[qqnumber],[email],[imagepath],[imagename],[regdatetime],[activitycount],[productscount],[companycommentcount],[companystatus],[website],[companycategoryid],[updatetime],[orderno],[companyappraisecount],[viewcount],[isinterior],[status],[themeid]
	)VALUES(
	@account,@password,@province,@city,@companyname,@shortname,@companysynopsis,@tel,@linkman,@address,@qqnumber,@email,@imagepath,@imagename,getdate(),0,0,0,@companystatus,@website,@companycategoryid,getdate(),0,0,0,@isinterior,1,cast(ceiling(rand()*9) as int)
	)
	SET @companyid = @@IDENTITY

	IF(@qqnumber<>'')
	BEGIN
		DECLARE @count int
		SELECT @count=count(1) FROM companycontact WHERE companyid=@companyid and contacttype=0
		INSERT INTO [companycontact]([companyid],[contacttype],[contactaccount],[orderno],[status])VALUES(
		@companyid,0,@qqnumber,@count+1,1)
	END

	IF(@isinterior=1)
	BEGIN
		UPDATE companycategory SET companycount=companycount+1 WHERE companycategoryid=@companycategoryid
	END

	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN	
		COMMIT TRANSACTION 
	   RETURN @companyid
	END
GO
