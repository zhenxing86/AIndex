USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_attendance_everymonth_GetListByUserId]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询接送记录月表 
--项目名称：classhomepage
--说明：
--时间：2010-11-05 15:50:10
------------------------------------
CREATE PROCEDURE [dbo].[class_attendance_everymonth_GetListByUserId]
@userid int,
@year int,
@month int
 AS 
	SELECT 
	t1.kid,t1.cardno,t1.userid,t1.deptid,t1.classid,t1.usertype,t1.year,t1.month,t1.days,t1.day_1,t1.day_2,t1.day_3,t1.day_4,t1.day_5,t1.day_6,t1.day_7,t1.day_8,t1.day_9,t1.day_10,t1.day_11,t1.day_12,t1.day_13,t1.day_14,t1.day_15,t1.day_16,t1.day_17,t1.day_18,t1.day_19,t1.day_20,t1.day_21,t1.day_22,t1.day_23,t1.day_24,t1.day_25,t1.day_26,t1.day_27,t1.day_28,t1.day_29,t1.day_30,t1.day_31
	 FROM  [attendance_everymonth] t1 
	WHERE t1.userid=@userid and t1.[year]=@year and t1.[month]=@month




GO
