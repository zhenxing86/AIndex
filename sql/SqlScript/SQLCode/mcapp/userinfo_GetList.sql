USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[userinfo_GetList]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[userinfo_GetList]
 AS 

select c.kid,uc.cid,u.mobile,u.userid,u.name,c.cname,'',
	case when a.ftime<=GETDATE() And a.ltime>=GETDATE() then a.a7 else 0 end 
 from BasicData..user_class uc
  inner join BasicData..class c on uc.cid=c.cid
  inner join BasicData..[user]u 
   on u.userid=uc.userid and u.usertype =0
  inner join BlogApp..permissionsetting p 
  on p.kid =c.kid and p.ptype=90
   left join ossapp..addservice a
	on a.deletetag=1 and u.userid=a.[uid] and a.describe='开通'



--select * from BasicData..[user]u where u.usertype=0 and u.deletetag=1


--select uc.kid,uc.cid,uc.mobile,uc.userid,uc.name,uc.cname,--k.kname,
--	case when a.ftime<=GETDATE() And a.ltime>=GETDATE() then a.a7 else 0 end 
-- from BasicData..User_Child uc
--   left join ossapp..addservice a
--	on a.deletetag=1 and uc.userid=a.[uid] and a.describe='开通'


GO
