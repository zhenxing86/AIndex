USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_getclassinfobyclassid]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：得到班级的详细信息 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 11:50:29
--exec [class_getclassinfobyclassid] 18579
------------------------------------s 
CREATE  PROCEDURE [dbo].[class_getclassinfobyclassid]
@classid int
 AS 


	select  t2.cid,t1.kid,t2.cname,'t3',t3.gname as classgradetitle,t2.grade,t1.kname,t2.subno,t4.code,t5.bbzxaccount,t5.bbzxpassword 
	from BasicData..kindergarten t1 inner join BasicData..class t2 on t1.kid=t2.kid 
	inner join basicdata..grade t3 on t2.grade=t3.gid
	left join kwebcms.dbo.site_config t5 on t1.kid=t5.siteid
	left join basicdata..personalize_class t4 on t2.cid=t4.cid
    where t2.cid=@classid






GO
