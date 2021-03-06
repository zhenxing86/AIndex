USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[UserBaseInfo_GetList_By_KName]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：得到用户的详细信息 
--项目名称：ArchivesApply
--说明：下载成长档案
--时间：2013-1-6 11:50:29
--exec [UserBaseInfo_GetList_By_KName] 18579
------------------------------------ 
CREATE  PROCEDURE [dbo].[UserBaseInfo_GetList_By_KName]
@kName nvarchar(150)
 AS 
begin
	select  u.userid,u.name,k.kid,k.kname,cls.cid,cls.cname,g.gid,g.gname,isnull(p.re_beancount,0) beancount,c.vipstatus,m.gbmodule,m.term,gb.gbid
	from BasicData..[user] u 
	inner join BasicData..user_class uc on uc.userid =u.userid
	inner join BasicData..class cls on cls.cid =uc.cid
	inner join BasicData..kindergarten k on k.kid=cls.kid
	inner join GBApp..HomeBook hb on hb.kid =k.kid and hb.classid=cls.cid 
	inner join GBApp..GrowthBook gb on gb.hbid = hb.hbid and gb.userid = u.userid 
	inner join BasicData..grade g on g.gid = cls.grade
	inner join BasicData..child c on c.userid=u.userid
	left join PayApp..user_pay_account p on p.userid=u.userid
	inner join gbapp..moduleset m on m.kid = k.kid and m.term=gb.term 
	where k.kname=@kName
end

GO
