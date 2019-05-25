USE BasicData
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-07-03  
-- Description: 函数用于返回好友列表  
-- Paradef:   
-- Memo: 
SELECT * FROM Basicdata.[dbo].GetFriendList(295765)  
*/   
ALTER function [dbo].GetFriendList(@userid int)   
returns @t table(usertype int, name varchar(50), utype varchar(10), userid int, headpic nvarchar(200), headpicupdate datetime)     
as  
BEGIN  
	declare @kid int, @cid int
	select @kid = kid, @cid = cid 
		from BasicData..[User_Child] 
		where userid = @userid 
	insert into @t(utype, usertype, name , userid, headpic, headpicupdate) 
		SELECT	case usertype when 1 then '老师' WHEN 97 THEN '园长' END utype, 
						usertype, name, userid, headpic, headpicupdate 
			FROM BasicData..[User] u
			where kid = @kid 
				and usertype in(1,97)
				and exists(select * from BasicData..user_class uc where u.userid = uc.userid and uc.cid = @cid)
	insert into @t(utype, usertype, name , userid, headpic, headpicupdate) 
		SELECT '好友', 0, uc.name, uc.userid, u.headpic, u.headpicupdate 
			FROM BasicData..[User_Child] uc 
				inner join BasicData..[User] u
					on uc.userid = u.userid
			where uc.kid = @kid 
				and uc.cid = @cid
				and uc.userid <> @userid
	return
END
GO