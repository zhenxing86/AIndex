USE BasicData 
GO
ALTER VIEW User_Teacher_v WITH SCHEMABINDING
AS
	SELECT	u.userid, u.account, u.usertype ,u.kid, u.name, u.birthday, u.updatetime, u.gender,
					CASE u.gender WHEN 2 THEN 'Å®' ELSE 'ÄÐ' END sex, u.mobile, t.title, t.did,t.orderno,u.tts
		FROM dbo.[user] u
			inner join dbo.teacher t
				on u.userid = t.userid
		where u.deletetag = 1
			and u.usertype in(1,97,98)
			 
GO
CREATE UNIQUE CLUSTERED INDEX idx_userid ON dbo.User_Teacher_v(userid);
CREATE index idx_kid on User_Teacher_v(kid) 
CREATE index idx_account on User_Teacher_v(account) 
CREATE INDEX idx_did on User_Teacher_v(did)
GO
ALTER view User_Teacher 
as
select * from User_Teacher_v with(noexpand)
GO