USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_accesslog_GetUserCount]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取访问用户数
--项目名称：ServicePlatformManage
--说明：
--时间：2010-05-19 11:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_accesslog_GetUserCount] 
@companyid int,
@account nvarchar(30),
@companyname nvarchar(50),
@begintime nvarchar(30),
@endtime nvarchar(30),
@usertype int,
@selecttype int
AS 
	DECLARE @sql varchar(2500)
	DECLARE @where varchar(700)	

	IF(@selecttype=0)
	BEGIN
		SET @where=' where 1=1 and t2.status=1 '
	END
	ELSE
	BEGIN
		SET @where=' where 1=1 and t1.accesspage like ''%contactredirect%'' and t2.status=1 '
	END

	IF(@usertype=1)
	BEGIN
		SET @where=@where+' AND t1.bloguserid>0 '
	END

	IF(@companyid<>0)
	BEGIN
		SET @where=@where+' AND t2.companyid='+cast(@companyid as varchar)
	END

	IF(@account<>'')
	BEGIN
		SET @where=@where+' AND t2.account like ''%'+@account+'%'''
	END

	IF(@companyname<>'')
	BEGIN
		SET @where=@where+' AND t2.companyname like ''%'+@companyname+'%'''
	END


--	IF(@companyid=0 and @account='' and @companyname='')
--	BEGIN
		SET @where=@where+' AND t1.accessdatetime between '''+@begintime+''' and '''+@endtime+''''
--	END
	IF(@usertype=1)
	BEGIN
		SET @sql='SELECT COUNT(DISTINCT(t1.bloguserid)) as total FROM accesslog t1 inner join company t2 on t1.companyid=t2.companyid'+@where 
	END
	ELSE
	BEGIN
		SET @sql='SELECT COUNT(DISTINCT(t1.fromip)) as total FROM accesslog t1 inner join company t2 on t1.companyid=t2.companyid'+@where 
	END
	EXEC(@sql)
GO
