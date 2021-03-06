USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_attendance_everymonth_GetChildList]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询学生接送记录月表 
--项目名称：classhomepage
--说明：
--时间：2010-5-10 15:50:10
--[class_attendance_everymonth_GetChildList] 33376,2011,10
------------------------------------
CREATE PROCEDURE [dbo].[class_attendance_everymonth_GetChildList]
@classid int,
@year int,
@month int
 AS 
	SELECT 
	t1.kid,t1.cardno,t1.userid,t1.deptid,t1.classid,t1.usertype,t1.year,t1.month,t1.days,
	t1.day_1,t1.day_2,t1.day_3,t1.day_4,t1.day_5,t1.day_6,t1.day_7,t1.day_8,
	t1.day_9,t1.day_10,t1.day_11,t1.day_12,t1.day_13,t1.day_14,t1.day_15,t1.day_16,
	t1.day_17,t1.day_18,t1.day_19,t1.day_20,t1.day_21,t1.day_22,t1.day_23,t1.day_24,
	t1.day_25,t1.day_26,t1.day_27,t1.day_28,t1.day_29,t1.day_30,t1.day_31,t3.name
	 FROM  basicdata.dbo.[user] t3 
	 INNER JOIN basicdata.dbo.user_class t4 on t3.userid=t4.userid
	 inner JOIN [attendance_everymonth] t1 on t1.userid=t3.userid
	WHERE t4.cid=@classid 
	and t3.deletetag=1 
	and t3.usertype=0 
	and t1.[year]=@year 
	and t1.[month]=@month	
	union
	select 0,'' as cardno,t1.userid,0,t1.cid,0,@year,@month,0,
	'' as day_1,'' as day_2,'' as day_3,'' as day_4,'' as day_5,'' as day_6,'' as day_7,'' as day_8,
	'' as day_9,'' as day_10,'' as day_11,'' as day_12,'' as day_13,'' as day_14,'' as day_15,'' as day_16,
	'' as day_17,'' as day_18,'' as day_19,'' as day_20,'' as day_21,'' as day_22,'' as day_23,'' as day_24,
	'' as day_25,'' as day_26,'' as day_27,'' as day_28,'' as day_29,'' as day_30,'' as day_31, t1.name 
	from basicdata..User_Child t1 
	where t1.cid=@classid 
	and	t1.userid not in 
	(select distinct userid from [attendance_everymonth] where
	 [year]=@year and [month]=@month)
	ORDER BY days

GO
