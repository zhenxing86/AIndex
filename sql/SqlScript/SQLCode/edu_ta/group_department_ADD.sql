USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[group_department_ADD]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：增加一条记录 
--项目名称：
--说明：
--时间：2012/2/24 9:37:30
------------------------------------
CREATE PROCEDURE [dbo].[group_department_ADD]
@dname varchar(50),
@superiorid int,
@gid int,
@deletetag int

 AS 
	INSERT INTO [group_department](
	[dname],[superiorid],[gid],[deletetag]
	)VALUES(
	@dname,@superiorid,@gid,@deletetag
	)








GO
