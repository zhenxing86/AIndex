USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_attendancetime_Init]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途:幼儿园教师考勤时间初始化
--项目名称：classhomepage
--说明：
--时间：2009-7-18 14:54:31
------------------------------------
CREATE PROCEDURE [dbo].[class_attendancetime_Init]
@kid int
AS 
	DELETE attendancetimeset WHERE kid=@kid
	insert into attendancetimeset(kid,usertype,departmentid,time1,time2,time3,time4,time5,time6)
	 select @kid,1,did,'08:00', '12:00','14:00','17:30','20:00','22:00' from basicdata.dbo.department where deletetag=1 and kid=@kid --and superior >0

	
	
	IF(@@ERROR<>0)
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END







GO
