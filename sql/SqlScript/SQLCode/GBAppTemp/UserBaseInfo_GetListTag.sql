USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[UserBaseInfo_GetListTag]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到用户的详细信息
--项目名称：ArchivesApply
--说明：下载成长档案
--select * from growthbook where userid=280153
--时间：-1-6 11:50:29
--exec [UserBaseInfo_GetListTag] 295765,'2013-0',0
------------------------------------ 
CREATE  PROCEDURE [dbo].[UserBaseInfo_GetListTag]
@userid int,
@term nvarchar(50),
@flag int =0

 AS 
begin
	if(@flag=0)
	begin
		select  u.userid,u.name,k.kid,k.kname,cls.cid,cls.cname,g.gid,g.gname,isnull(p.re_beancount,0) beancount,
			c.vipstatus,m.gbmodule,@term,gb.gbid
		from BasicData..[user] u 
		inner join BasicData..user_class uc on uc.userid =u.userid
		inner join BasicData..class cls on cls.cid =uc.cid
		inner join BasicData..kindergarten k on k.kid=cls.kid
		inner join GBApp..GrowthBook gb on gb.userid = u.userid and gb.term=@term
		inner join BasicData..grade g on g.gid = cls.grade
		inner join BasicData..child c on c.userid=u.userid
		left join PayApp..user_pay_account p on p.userid=u.userid
		inner join gbapp..moduleset m on m.modulesetid = gb.modulesetid --and m.term=@term
		where u.userid=@userid
	end
	else
	begin
		select  u.userid,u.name,k.kid,k.kname,cls.cid,cls.cname,g.gid,g.gname,isnull(p.re_beancount,0) beancount,
			c.vipstatus,'',@term,gb.gbid
		from BasicData..[user] u 
		inner join BasicData..user_class uc on uc.userid =u.userid
		inner join BasicData..class cls on cls.cid =uc.cid
		inner join BasicData..kindergarten k on k.kid=cls.kid
		inner join NGBApp..GrowthBook gb on gb.userid = u.userid and gb.term=@term
		inner join BasicData..grade g on g.gid = cls.grade
		inner join BasicData..child c on c.userid=u.userid
		left join PayApp..user_pay_account p on p.userid=u.userid
		--inner join gbapp..moduleset m on m.modulesetid = gb.modulesetid --and m.term=@term
		where u.userid=@userid
	end
end	

GO
