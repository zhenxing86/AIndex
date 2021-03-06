USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_GetVIPChildInfo]    Script Date: 06/15/2013 15:17:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：幼儿VIP详细信息
--项目名称：ZGYEYManage
--说明：select * from basicdata.dbo.grade
--时间：2010-03-15 15:40:19
------------------------------------ 
alter PROCEDURE [dbo].[Manage_GetVIPChildInfo]
@strWhere varchar(1000) = ''
AS

SET @strWhere = CommonFun.dbo.FilterSQLInjection(@strWhere)
	DECLARE @strSQL varchar(2000)
	SET @strSQL='SELECT t6.userid,t3.cname as classname,t6.name,t6.mobile,
(select top 1 startdate from zgyey_om.dbo.vipdetails where iscurrent=1 and userid=t1.userid order by enddate desc)as startdate,
(select top 1 enddate from zgyey_om.dbo.vipdetails where iscurrent=1 and userid=t1.userid order by enddate desc)as enddate,
t1.vipstatus
				FROM basicdata.dbo.child t1 
					 inner join basicdata.dbo.user_class t4 on t1.userid=t4.userid
					 INNER JOIN basicdata.dbo.class t3 ON t3.cid=t4.cid 					 
					 inner join basicdata.dbo.[user] t5 on t5.userid=t1.userid
					 inner join basicdata.dbo.user_baseinfo t6 on t6.userid=t1.userid	
					INNER JOIN ZGYEY_OM.dbo.vipdetails t2 ON t1.userid=t2.userid									
				WHERE t5.deletetag=1 AND t1.VIPStatus=1 and t2.iscurrent=1 AND t3.deletetag=1 and t3.grade<>38 '+@strWhere +' order by t3.cid'
	exec (@strSQL)


--
--
/*
SELECT t6.userid,t3.cname as classname,t6.name,t6.mobile,
(select top 1 startdate from zgyey_om.dbo.vipdetails where iscurrent=1 and userid=t1.userid order by enddate desc)as startdate,
(select top 1 enddate from zgyey_om.dbo.vipdetails where iscurrent=1 and userid=t1.userid order by enddate desc)as enddate,
t1.vipstatus
				FROM basicdata.dbo.child t1 
					 inner join basicdata.dbo.user_class t4 on t1.userid=t4.userid
					 INNER JOIN basicdata.dbo.class t3 ON t3.cid=t4.cid 					 
					 inner join basicdata.dbo.[user] t5 on t5.userid=t1.userid
					 inner join basicdata.dbo.user_baseinfo t6 on t6.userid=t1.userid
					--INNER JOIN ZGYEY_OM.dbo.vipdetails t2 ON t1.userid=t2.userid					
WHERE t5.deletetag=1 AND t1.VIPStatus=1 AND t3.deletetag=1 and t3.grade<>38 
and t3.kid=5544 
order by t3.grade desc

*/
GO
