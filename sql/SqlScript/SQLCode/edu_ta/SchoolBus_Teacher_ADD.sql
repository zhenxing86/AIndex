USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_Teacher_ADD]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：增加一条记录 
--项目名称：
--说明：
--时间：2012/2/16 11:47:00
------------------------------------
CREATE PROCEDURE [dbo].[SchoolBus_Teacher_ADD]
@bid int,
@uid int,
@uname varchar(50),
@sex varchar(50),
@age int,
@tel varchar(500),
@inuserid int,
@intime datetime

 AS 
	INSERT INTO [SchoolBus_Teacher](
	[bid],[uid],[uname],[sex],[age],[tel],[inuserid],[intime],deletetag
	)VALUES(
	@bid,@uid,@uname,@sex,@age,@tel,@inuserid,getdate(),1
	)
return  @@IDENTITY









GO
