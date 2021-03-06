USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetTeacherToExcelV2]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-01
-- Description:	得到教师列表
-- Memo:		
exec user_GetTeacherToExcelV2 12511
*/ 
CREATE PROCEDURE [dbo].[user_GetTeacherToExcelV2]
	@kid int
 AS
BEGIN
	SET NOCOUNT ON 	
	SELECT	u.name,case u.gender when 2 then '女' when 3 then '男' end, td.country, td.overseas,
					td.cardtype, td.[address], u.birthday, t.politicalface, td.nation, td.householdtype, td.cardno,
					t.title, t.post, u.Enrollmentdate, td.social, td.medical, td.lastyearinfo, td.establishment,
					td.basemoney, td.lastyearmoney, td.pension, td.ishousingreserve, td.isteachercert,
					td.issuingauthority, td.teachercerttype, td.teacherno, td.islostinsurance, td.isbusinessinsurance,
					td.isbirthinsurance, td.otherallowances, t.education, td.achievements, td.isedu		
	FROM [user] u 
		left join TeacherDetails td on td.[uid] = u.userid
		inner join teacher t on u.userid = t.userid
	WHERE	u.kid = @kid 
		and u.deletetag = 1 
		and u.usertype in (1,97)
END

GO
