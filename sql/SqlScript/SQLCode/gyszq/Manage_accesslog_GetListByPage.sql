USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_accesslog_GetListByPage]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：访问日志
--项目名称：ServicePlatformManage
--说明：
--时间：2010-05-17 11:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_accesslog_GetListByPage] 
@companyid int,
@account nvarchar(30),
@companyname nvarchar(50),
@begintime nvarchar(30),
@endtime nvarchar(30),
@usertype int,
@returncount int,
@page int,
@size int
 AS 

	DECLARE @sql varchar(2000)
	DECLARE @where varchar(200)
	
	SET @sql='DECLARE @prep int,@ignore int
		
		SET @prep = '+cast(@size * @page as varchar)+'
		SET @ignore=@prep - '+cast(@size as varchar)+'

		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			accesslogid bigint
		)

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(accesslogid)
		SELECT t1.accesslogid FROM accesslog t1 inner join company t2 on t1.companyid=t2.companyid '

	SET @where=' where 1=1 and t2.status=1 '
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

	SET @sql=@sql+@where+' ORDER BY t1.accessdatetime DESC

			SET ROWCOUNT '+cast(@size as varchar)+'
			SELECT t1.accesslogid,t1.companyid,t1.bloguserid,t1.fromip,t1.accesspage,t1.urlreferrer,t1.accessdatetime,t1.productid,t2.companyname,t3.title as producttitle,[dbo].[GetUserName](t1.bloguserid) as username
			FROM 
				@tmptable AS tmptable
			INNER JOIN 
				accesslog t1 ON tmptable.accesslogid=t1.accesslogid
			INNER JOIN 
				company t2 ON t1.companyid=t2.companyid
			LEFT JOIN 
				product t3 ON  t1.productid=t3.productid
			WHERE 
				row >  @ignore ORDER BY t1.accessdatetime DESC'

	IF(@returncount=1)
	BEGIN
		SET @sql='SELECT count(1) as total FROM accesslog t1 inner join company t2 on t1.companyid=t2.companyid'+@where 

	END

	EXEC(@sql)
GO
