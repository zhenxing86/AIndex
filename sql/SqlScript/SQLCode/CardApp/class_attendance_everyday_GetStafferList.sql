USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[class_attendance_everyday_GetStafferList]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-06
-- Description:	查询所有老师打卡记录日表
-- Memo:
[class_attendance_everyday_GetStafferList]  13730,2013,3,11
*/
CREATE PROCEDURE [dbo].[class_attendance_everyday_GetStafferList] 
	@kid int,
	@year int,
	@month int,
	@day int
 AS 
BEGIN
	SET NOCOUNT ON
	SELECT	ae.kid,ae.cardno,u.userid,t.did,ae.classid,
					1,ae.[year],ae.[month],u.name,
					CASE @day 
					WHEN 1 THEN ae.day_1
					WHEN 2 THEN ae.day_2
					WHEN 3 THEN ae.day_3
					WHEN 4 THEN ae.day_4
					WHEN 5 THEN ae.day_5
					WHEN 6 THEN ae.day_6
					WHEN 7 THEN ae.day_7
					WHEN 8 THEN ae.day_8
					WHEN 9 THEN ae.day_9
					WHEN 10 THEN ae.day_10
					WHEN 11 THEN ae.day_11
					WHEN 12 THEN ae.day_12
					WHEN 13 THEN ae.day_13
					WHEN 14 THEN ae.day_14
					WHEN 15 THEN ae.day_15
					WHEN 16 THEN ae.day_16
					WHEN 17 THEN ae.day_17
					WHEN 18 THEN ae.day_18
					WHEN 19 THEN ae.day_19
					WHEN 20 THEN ae.day_20
					WHEN 21 THEN ae.day_21
					WHEN 22 THEN ae.day_22
					WHEN 23 THEN ae.day_23
					WHEN 24 THEN ae.day_24
					WHEN 25 THEN ae.day_25
					WHEN 26 THEN ae.day_26
					WHEN 27 THEN ae.day_27
					WHEN 28 THEN ae.day_28
					WHEN 29 THEN ae.day_29
					WHEN 30 THEN ae.day_30
					WHEN 31 THEN ae.day_31
					end as day_N,	u.gender
		FROM basicdata.dbo.[user] u 
			inner join basicdata.dbo.teacher t 
				on u.userid = t.userid
			LEFT JOIN attendance_everymonth ae 
				on ae.userid = u.userid 
				and ae.[year] = @year 
				and ae.[month] = @month
		WHERE u.kid = @kid 
			and u.deletetag = 1
		ORDER BY u.userid
END
	

GO
