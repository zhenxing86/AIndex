USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_novip_Excel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec addservice_novip_Excel 20126
--2014-9-4获取未开通VIP幼儿，不包括毕业班的
CREATE proc [dbo].[addservice_novip_Excel]
@kid int
as
begin

select u.name,u.account,c.cname, case  when a.id is null then '未开通' else describe end,u.regdatetime from basicdata..[user]  u
left join basicdata..user_class uc on u.userid=uc.userid
left join basicdata..class c on uc.cid=c.cid
left join ossapp..addservice a on u.userid=a.uid where u.kid=@kid and u.usertype=0 and u.deletetag=1  
and (a.describe!='开通' or a.ID is null)
  and c.grade!=38
end


GO
