USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[Teacher_Baseinfo_GetModel]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-01
-- Description:	获取教师基本资料信息
-- Memo:		
Teacher_Baseinfo_GetModel 296418
*/
CREATE PROCEDURE [dbo].[Teacher_Baseinfo_GetModel]
	@userid int
AS
BEGIN
	SET NOCOUNT ON
	
	
declare @cid int,@usertype int
set @usertype=[CommonFun].[dbo].[fn_KWebCMS_Right_max](@userid)

if(@usertype>=97)
begin
	select @cid=MIN(uc.cid) 
		from user_class uc
			inner join class c 
				on uc.cid=c.cid
			inner join [user] u
				on u.kid=c.kid
		where u.userid=@userid
end
else
begin
	select @cid=MIN(uc.cid) 
		from user_class uc
			inner join class c 
				on uc.cid=c.cid
		where uc.userid=@userid
end		
		
	if @cid is null
		set @cid=0
		

	SELECT	u.name, u.nickname, u.gender, u.birthday, u.mobile, u.exigencetelphone,
					u.email, u.[address], t.did, t.title, t.post, t.education, t.employmentform,
					t.politicalface, u.headpic, u.headpicupdate, u.privince, u.city, 
					s.sitedns as domain, ub.bloguserid, u.istip, t.kinschooltag, u.tiprule, u.network,@cid 
		FROM [user] u 
			left join teacher t 
				on u.userid = t.userid 
			left join user_bloguser ub 
				on u.userid = ub.userid 
			left join kwebcms..[site] s 
				on s.siteid = u.kid  
		Where u.userid = @userid 
END

GO
