USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetChildInfo]    Script Date: 06/15/2013 15:17:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：幼儿信息
--项目名称：zgyeyblog
--说明：
--时间：2008-12-24 15:40:19AND t1.ClassID=4799 t1.userid t1.name like'%%'
------------------------------------ 
ALTER PROCEDURE [dbo].[Manage_GetChildInfo] 
@strWhere varchar(1000) = ''
AS


SET @strWhere = CommonFun.dbo.FilterSQLInjection(@strWhere)

DECLARE @strSQL varchar(1000)
	SET @strSQL=
'SELECT 
t3.userid ,'''',t3.[Name],'''',
t3.Gender,t1.VIPStatus,
(SELECT max(StartDate) FROM ZGYEY_OM.dbo.[VIPDetails] WHERE userid=t3.userid) as StartDate,
(SELECT max(EndDate) FROM ZGYEY_OM.dbo.[VIPDetails] WHERE userid=t3.userid) as EndDate,
(SELECT COUNT(*) FROM ZGYEY_OM.dbo.[VIPDetails] WHERE userid=t3.userid) as VIPcount
FROM basicdata.dbo.child t1 
INNER JOIN basicdata.dbo.user_baseinfo t3 on t1.userid=t3.userid
INNER JOIN basicdata.dbo.user_class t4 on t1.userid=t4.userid
inner join basicdata.dbo.[user] t5 on t1.userid=t5.userid
INNER JOIN ZGYEY_OM.dbo.[VIPDetails] t2 ON t1.userid=t2.userid
WHERE t5.deletetag=1 '+@strWhere+' GROUP BY t3.userid ,t3.[Name],t3.gender,t1.VIPStatus'
	exec (@strSQL)
GO
