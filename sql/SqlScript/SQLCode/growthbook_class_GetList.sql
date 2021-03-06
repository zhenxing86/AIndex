USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[growthbook_class_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[growthbook_class_GetList]
@kid int
,@term varchar(20)
AS

select r.cid,r.cname,SUM(lifecount),SUM(workcount),SUM(videocount),SUM(cbookcount),g.remark 
,h.hbid,g.ID
from ReportApp..rep_growthbook_class r
inner join BasicData..class c on r.cid=c.cid
left join dbo.rep_growthbook_class_checked g on g.kid=r.kid and g.cid=r.cid and g.term=r.term
inner join GBApp..HomeBook h on h.classid=r.cid and h.term=@term
where r.kid=@kid and r.term=@term
group by r.cid,r.cname,c.grade,c.[order],g.remark,h.hbid,g.ID
order by c.grade asc,c.[order] desc



GO
