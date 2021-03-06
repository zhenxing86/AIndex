USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[class_getclassinfobyclassid]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到班级的详细信息 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-6 11:50:29
------------------------------------
create  PROCEDURE [dbo].[class_getclassinfobyclassid]
@classid int
 AS 

	declare @Kname nvarchar(50)
	select @Kname=t1.kname from BasicData..kindergarten t1  where  t1.kid=(select kid from BasicData..class where cid=@classid )
	 
	SELECT
     t1.cid  as classid,t1.kid as kid, t1.cname, 
	't3', dbo.dictcaptionfromid(t1.grade) as classgradetitle, t1.grade,
	 @Kname as kname,t1.subno,t2.bbzxaccount,t2.bbzxpassword
	 FROM BasicData..class t1 left join kwebcms..site_config t2
  	on t1.kid=t2.siteid
	 WHERE t1.cid=@classid

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'class_getclassinfobyclassid', @level2type=N'PARAMETER',@level2name=N'@classid'
GO
