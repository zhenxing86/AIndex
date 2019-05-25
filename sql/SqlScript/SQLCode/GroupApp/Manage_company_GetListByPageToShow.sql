USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_company_GetListByPageToShow]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询显示品牌商家信息 
--项目名称：ServicePlatformManage
--说明：
--时间：2009-12-31 11:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_company_GetListByPageToShow] 
@companyid int,
@account nvarchar(30),
@companyname nvarchar(50),
@province int,
@city int,
@begintime nvarchar(30),
@endtime nvarchar(30),
@order nvarchar(30),
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
			companyid bigint
		)

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(companyid)
		SELECT companyid FROM company '

	SET @where=' where 1=1 AND status=1 AND companystatus=1 '
	IF(@companyid<>0)
	BEGIN
		SET @where=@where+' AND companyid='+cast(@companyid as varchar)
	END

	IF(@account<>'')
	BEGIN
		SET @where=@where+' AND account like ''%'+@account+'%'''
	END

	IF(@companyname<>'')
	BEGIN
		SET @where=@where+' AND companyname like ''%'+@companyname+'%'''
	END

	IF(@province<>0)
	BEGIN
		SET @where=@where+' AND province='+cast(@province as varchar)
	END

	IF(@city<>0)
	BEGIN
		SET @where=@where+' AND city='+cast(@city as varchar)
	END

	IF(@companyid=0 and @account='' and @companyname='')
	BEGIN
		SET @where=@where+' AND regdatetime between '''+@begintime+''' and '''+@endtime+''''
	END

	IF(@order='')
	BEGIN
		SET @order='regdatetime'
	END

	SET @sql=@sql+@where+' order by '+@order+' DESC

			SET ROWCOUNT '+cast(@size as varchar)+'
			SELECT t1.companyid,t1.account,t1.password,t1.province,t1.city,t1.companyname,t1.companysynopsis,t1.tel,t1.linkman,t1.address,t1.qqnumber,t1.email,t1.imagepath,t1.imagename,t1.regdatetime,t1.activitycount,t1.productscount,t1.companycommentcount,t1.companystatus,t1.website,t1.companycategoryid,t1.updatetime,t1.orderno,t1.companyappraisecount,t1.viewcount,t2.commonproductcategoryid,t2.commoncompanyid
			FROM 
				@tmptable AS tmptable
			INNER JOIN 
				company t1 ON tmptable.companyid=t1.companyid
			LEFT JOIN
				commoncompany t2 ON (t1.companyid=t2.companyid AND t2.status=1)
			WHERE 
				row >  @ignore ORDER BY '+@order+' DESC'

	IF(@returncount=1)
	BEGIN
		SET @sql='select count(1) as total from company'+@where
	END

	EXEC(@sql)

GO
