USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_Trip_Update]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改一条记录 
--项目名称：
--说明：
--时间：2012/3/2 17:38:04
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_Trip_Update]
@id int,
@bid int,
@starttime nvarchar(50),
@endtime nvarchar(50),
@route nvarchar(100),
@site nvarchar(100),
@inuserid int,
@intime datetime
 AS 
	UPDATE [SchoolBus_Trip] SET 
	[bid] = @bid,[starttime] = @starttime,[endtime] = @endtime,[route] = @route,[site] = @site,[inuserid] = @inuserid,[intime] = @intime
	WHERE id=@id

GO
