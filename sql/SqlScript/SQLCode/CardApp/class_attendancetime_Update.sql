USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_attendancetime_Update]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途:修改幼儿园教师考勤时间
--项目名称：classhomepage
--说明：
--时间：2009-7-18 14:54:31
------------------------------------
CREATE PROCEDURE [dbo].[class_attendancetime_Update]
@atsid int,
@departmentid int,
@time1 nvarchar(10),
@time2 nvarchar(10),
@time3 nvarchar(10),
@time4 nvarchar(10),
@time5 nvarchar(10),
@time6 nvarchar(10)
AS
	Update attendancetimeset set time1=@time1,time2=@time2,time3=@time3,time4=@time4,time5=@time5,time6=@time6
	WHERE id=@atsid and departmentid=@departmentid	
	
	IF(@@ERROR<>0)
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END





GO
