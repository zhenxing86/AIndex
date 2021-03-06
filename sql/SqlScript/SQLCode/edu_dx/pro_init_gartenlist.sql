USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[pro_init_gartenlist]    Script Date: 08/10/2013 10:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_init_gartenlist]
@areaid int
as

----初始化幼儿园
--delete gartenlist

insert into gartenlist(kid,kname,sitedns,mingyuan,orderby,areaid,regdatetime,actiondate,telephone,qq,opentype,citytype,kintype,mastername,[address])
select k.kid,k.kname,s.sitedns,'',0,[dbo].[GetKinArea](k.privince,k.city,k.area,k.residence)
,k.actiondate,k.actiondate,k.telephone,k.qq,k.opentype,k.citytype,k.kintype,k.mastername,k.[address] from BasicData..kindergarten k
left join kwebcms..site s on s.siteid=kid 
left join gartenlist x on x.kid=k.kid
where (k.privince=@areaid or k.city=@areaid or k.area=@areaid )
and x.kid is null

----初始化幼儿园
--select * from gartenlist


--初始化部门department
delete department

insert into department(did,dname,superior,[order],deletetag,kid,actiondatetime)
select did,dname,superior,[order],deletetag,d.kid,actiondatetime
from basicdata..department d
inner join gartenlist g on d.kid=g.kid
GO
