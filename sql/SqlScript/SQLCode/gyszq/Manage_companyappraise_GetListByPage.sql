USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_companyappraise_GetListByPage]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：商家评价检查
--项目名称：ServicePlatformManage
--说明：
--时间：2009-12-31 11:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_companyappraise_GetListByPage]
@companyid int,
@account nvarchar(30),
@companyname nvarchar(50),
@begintime nvarchar(30),
@endtime nvarchar(30),
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
			companyappraiseid bigint
		)

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(companyappraiseid)
		SELECT t1.companyappraiseid FROM companyappraise t1 inner join company t2 on t1.companyid=t2.companyid '

	SET @where=' where 1=1 and t1.status=1 and t2.status=1'
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
		SET @where=@where+' AND t1.appraisedatetime between '''+@begintime+''' and '''+@endtime+''''
--	END

--	IF(@order='')
--	BEGIN
--		SET @order='t1.createdatetime'
--	END

	SET @sql=@sql+@where+' ORDER BY t1.appraisedatetime DESC

			SET ROWCOUNT '+cast(@size as varchar)+'
			SELECT t1.companyappraiseid,t1.companyid,t1.level,t1.author,t1.userid,t1.parentid,t1.contact,t1.memo,t1.appraisedatetime,t1.fromip,t2.account,t2.companyname
			FROM 
				@tmptable AS tmptable
			INNER JOIN 
				companyappraise t1 ON tmptable.companyappraiseid=t1.companyappraiseid
			INNER JOIN 
				company t2 ON t1.companyid=t2.companyid
			WHERE 
				row >  @ignore ORDER BY t1.appraisedatetime DESC'

	IF(@returncount=1)
	BEGIN
		SET @sql='SELECT count(1) as total FROM companyappraise t1 inner join company t2 on t1.companyid=t2.companyid'+@where 
	END

	EXEC(@sql)
GO
