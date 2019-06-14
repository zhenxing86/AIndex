USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_Trip_ADD]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：增加一条记录 
--项目名称：
--说明：
--时间：2012/3/2 17:38:04
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_Trip_ADD]
@bid int,
@starttime nvarchar(50),
@endtime nvarchar(50),
@route nvarchar(100),
@site nvarchar(100),
@inuserid int,
@intime datetime

 AS 
	INSERT INTO [SchoolBus_Trip](
	[bid],[starttime],[endtime],[route],[site],[inuserid],[intime],[deletetag]
	)VALUES(
	@bid,@starttime,@endtime,@route,@site,@inuserid,@intime,1
	)






GO
