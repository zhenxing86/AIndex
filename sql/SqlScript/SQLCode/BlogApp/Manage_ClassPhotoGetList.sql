USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_ClassPhotoGetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：取班级相片列表
--项目名称：manage
--说明：
--时间：2009-6-12 17:40:19
------------------------------------ 
CREATE PROCEDURE [dbo].[Manage_ClassPhotoGetList]
@count nvarchar(10),
@strwhere nvarchar(300)
AS

SET @strwhere = CommonFun.dbo.FilterSQLInjection(@strwhere)
SET @count = CommonFun.dbo.FilterSQLInjection(@count)

	DECLARE @strSQL NVARCHAR(1000)
	SET @strSQL='select TOP('+@count+') t1.photoid ,t3.kname,t4.cname as classname,t1.filepath,t1.filename,t2.author,t5.account as loginname,t1.uploaddatetime,t2.classid
	 from classapp.dbo.class_photos t1 inner join classapp.dbo.class_album t2 on t1.albumid=t2.albumid and t1.status=1 and t2.status=1
	  inner join basicdata.dbo.kindergarten t3 on t2.kid=t3.kid
inner join basicdata.dbo.class t4 on t2.classid=t4.cid
inner join basicdata.dbo.[user] t5 on t2.userid=t5.userid and t5.deletetag=1 '+@strwhere +' order by t1.uploaddatetime desc'
	exec (@strSQL)

GO
