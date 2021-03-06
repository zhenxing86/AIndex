USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetTeacherByDid]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-06-20
-- Description:	得到教师列表
-- Memo:		
user_GetTeacherByDid 59
*/ 
CREATE PROCEDURE [dbo].[user_GetTeacherByDid]
	@did int
AS
BEGIN
	SET NOCOUNT ON 	
	SELECT ut.userid, ut.account, ut.name, ut.gender, ut.mobile,max(c.cardno) [card]
		FROM User_Teacher ut 
			left join mcapp..cardinfo c on ut.userid=c.userid and c.usest=1
		WHERE	ut.did in (select did from get_department_subsid(@did)) 
			and ut.usertype <> 98
			and ut.kid>0
		group by ut.userid,ut.account,ut.name,ut.gender,ut.mobile
		order by ut.userid desc
END

GO
