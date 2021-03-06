USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[userinfo_GetList]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[userinfo_GetList]
 AS 

select c.kid,uc.cid,u.mobile,u.userid,u.name,c.cname,k.kname,a.a7
 from BasicData..user_class uc
  inner join BasicData..class c on uc.cid=c.cid
  inner join BasicData..[user]u 
   on u.userid=uc.userid and u.usertype =0
  inner join mcapp..kindergarten k 
   on k.kid =c.kid
   left join ossapp..addservice a
	on a.deletetag=1 and u.userid=a.[uid] and a.describe='开通'
where u.mobile is not null 



GO
