USE BasicData 
GO
ALTER VIEW User_Child_v WITH SCHEMABINDING
AS
	SELECT	u.userid, u.account, u.kid, u.name, u.birthday, u.updatetime,u.gender, 
					CASE u.gender WHEN 2 THEN 'Å®' ELSE 'ÄÐ' END sex, u.mobile, c.cid, 
					c.cname,c.[order] corder, c.grade, u.tts, u.nickname, u.headpicupdate, u.headpic
		FROM dbo.[user] u
			inner join dbo.user_class uc
				on u.userid = uc.userid
			inner join dbo.class c
				on uc.cid = c.cid
				and c.deletetag = 1
		where u.deletetag = 1
			and u.usertype = 0
			 
GO
CREATE UNIQUE CLUSTERED INDEX idx_userid ON dbo.User_Child_v(userid);
CREATE index idx_kid on User_Child_v(kid) 
CREATE index idx_cid on User_Child_v(cid)INCLUDE(cname) 
CREATE index idx_account on User_Child_v(account) 
CREATE NONCLUSTERED INDEX idx_kid_grade ON [dbo].[User_Child_v] ([kid],grade)
GO
alter view user_Child 
as
select * from User_Child_v with(noexpand)
GO
