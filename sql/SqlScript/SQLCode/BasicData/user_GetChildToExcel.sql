USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_GetChildToExcel]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-07-16  
-- Description: 得到幼儿列表  
-- Memo:    
EXEC  user_GetChildToExcel 17611,0,46144
EXEC  user_GetChildToExcel 17611,1,46144
*/ 
CREATE PROCEDURE [dbo].[user_GetChildToExcel]
	@kid int,
	@type int,
	@cid int
AS
BEGIN
	SET NOCOUNT ON
	if(@type=1)
	begin
		SELECT	u.account, u.name, c.cname, case u.gender when 2 then '女' when 3 then '男' end,
						u.mobile, convert(varchar(10), u.birthday,120), convert(varchar(10),u.enrollmentdate,120)
			FROM [user] u 
				Inner  JOIN user_class uc on u.userid = uc.userid 
				Inner join class c on uc.cid = c.cid
				Inner join grade g on g.gid=c.grade 	
			WHERE u.kid = @kid  
				and u.deletetag = 1 
			and u.usertype = 0  and
				  c.iscurrent = 1 
				and c.deletetag = 1
			order by g.[order],c.[order]
	end
	else
	begin
		SELECT  u.account, u.name,c.cname,case u.gender when 2 then '女' when 3 then '男' end,
						u.mobile, convert(varchar(10), u.birthday,120), convert(varchar(10),u.enrollmentdate,120)
		FROM [user] u 
			Inner JOIN user_class uc on u.userid = uc.userid 
			inner join class c on uc.cid = c.cid 	
		WHERE u.kid = @kid 
			and c.cid = @cid 
			and u.deletetag = 1 
			and u.usertype = 0 
			and c.iscurrent = 1 
			and c.deletetag = 1
		order by uc.cid DESC
	end
END

GO
