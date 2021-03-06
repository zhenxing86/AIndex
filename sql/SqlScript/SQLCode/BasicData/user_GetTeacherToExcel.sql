USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetTeacherToExcel]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-06-20
-- Description:	得到教师列表
-- Memo:		
exec user_GetTeacherToExcel 12511
*/ 
CREATE PROCEDURE [dbo].[user_GetTeacherToExcel]
	@kid int
AS
BEGIN
	SET NOCOUNT ON 	
	SELECT	u.account, u.name, case u.gender when 2 then '女' when 3 then '男' end gender,
					u.mobile, convert(varchar(10),u.birthday,120) birthday, convert(varchar(10),u.enrollmentdate,120) enrollmentdate,
					t.politicalface, t.title, t.post, t.education, Cast('' as Varchar(2000)) cname, u.userid
  Into #u
  FROM [user] u 
		inner join teacher t on u.userid = t.userid
	WHERE	u.kid = @kid 
		and u.deletetag = 1 
		and u.usertype in (1,97)

  Update #u Set cname = b.cname
    From #u a, (Select a.userid, [CommonFun].[dbo].[sp_GetSumStr](b.cname + ',') cname From user_class a, class b Where a.cid = b.cid Group by a.userid) b
    Where a.userid = b.userid
  
  Select account, name, gender, mobile, birthday, enrollmentdate, politicalface, title, post, education, cname From #u
END

GO
