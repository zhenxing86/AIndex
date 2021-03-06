USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[pro_init_rep_classinfo]    Script Date: 2014/11/24 23:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_init_rep_classinfo]
as

delete rep_classinfo

insert into rep_classinfo(kid,kname,gradeid,gradename,cid,cname,areaid)
select n.kid,n.kname,g.gid,g.gname,c.cid,c.cname,m.areaid from gartenlist m
left join BasicData..kindergarten n on n.kid=m.kid
left join BasicData..[class] c on c.kid=n.kid and c.deletetag=1
left join BasicData..grade g on g.gid=c.grade 

GO
