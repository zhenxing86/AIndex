USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[GetkindergartenBygid]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetkindergartenBygid] 
@gid int
as 

select n.kid,n.[kname] from GroupApp..group_baseinfo g 
inner join GroupApp..group_partinfo p on p.gid=g.gid
left join BasicData..kindergarten n on n.kid=p.p_kid
where g.gid=@gid

GO
