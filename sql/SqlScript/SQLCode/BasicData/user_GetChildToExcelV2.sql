USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetChildToExcelV2]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-07-16  
-- Description: 得到幼儿列表  
-- Memo:    
EXEC  user_GetChildToExcelV2 12511,0,46144
EXEC  user_GetChildToExcelV2 12511,1,46144
*/
CREATE PROCEDURE [dbo].[user_GetChildToExcelV2] 
	@kid int,
	@type int,
	@cid int
AS
BEGIN
	SET NOCOUNT ON
	if(@type=1)
	begin
		SELECT	u.name, c.cname, case u.gender when 2 then '女' when 3 then '男' end,
						u.birthday, cd.cardtype, cd.cardno, cd.nation, cd.hometown, cd.householdtype,
						cd.householdaddress, cd.[address],u.enrollmentdate, cd.isone, cd.isstay,
						cd.iscity, cd.isdis, cd.distype, cd.isboarding, cd.isonly, cd.isdown,
						cd.isaccept, cd.parentname1, cd.parentcardno1, cd.country, cd.overseas, cd.cardtype1
			FROM [user] u 
				Inner JOIN user_class uc on u.userid = uc.userid 
				Inner join class c on uc.cid = c.cid				
				left join ChildDetails cd on cd.[uid] = u.userid 	
			WHERE u.kid = @kid  
				and u.deletetag = 1 
				and u.usertype = 0 
				and c.iscurrent = 1 
				and c.deletetag = 1
			order by c.grade DESC
	end
	else
	begin
		SELECT  u.name, c.cname, case u.gender when 2 then '女' when 3 then '男' end,
						u.birthday, cd.cardtype, cd.cardno, cd.nation, cd.hometown, cd.householdtype,
						cd.householdaddress, cd.[address],u.enrollmentdate, cd.isone, cd.isstay,
						cd.iscity, cd.isdis, cd.distype, cd.isboarding, cd.isonly, cd.isdown,
						cd.isaccept, cd.parentname1, cd.parentcardno1, cd.country, cd.overseas, cd.cardtype1
		FROM [user] u 
			Inner JOIN user_class uc on u.userid = uc.userid 
			inner join class c on uc.cid = c.cid			
			left join ChildDetails cd on cd.[uid] = u.userid 	
		WHERE u.kid = @kid 
			and c.cid = @cid 
			and u.deletetag = 1 
			and u.usertype = 0 
			and c.iscurrent = 1 
			and c.deletetag = 1
		order by u.userid DESC
	end
END

GO
