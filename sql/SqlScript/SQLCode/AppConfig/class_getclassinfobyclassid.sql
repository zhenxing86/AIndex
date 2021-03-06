USE [AppConfig]
GO
/****** Object:  StoredProcedure [dbo].[class_getclassinfobyclassid]    Script Date: 2014/11/24 21:11:51 ******/
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
------------------------------------
CREATE  PROCEDURE [dbo].[class_getclassinfobyclassid]
@classid int
 AS 

	declare @Kname nvarchar(50),@gradename nvarchar(50)
	select @Kname=t1.kname,@gradename=t3.gname  from BasicData..kindergarten t1, BasicData..class t2, basicdata..grade t3
    where t1.kid=t2.kid and t2.grade=t3.gid
	 
	SELECT
     t1.cid  as classid,t1.kid as kid, t1.cname, 
	't3', @gradename as classgradetitle, t1.grade,
	 @Kname as kname,t1.subno
	 FROM BasicData..class t1
	 WHERE t1.cid=@classid
	 

GO
