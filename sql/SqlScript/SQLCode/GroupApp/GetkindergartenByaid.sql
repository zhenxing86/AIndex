USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[GetkindergartenByaid]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetkindergartenByaid]
@gid int
,@aid int
as 
--select -1 kid,'请选择' kname
--union all
select n.kid,n.[kname] from dbo.group_baseinfo g 
inner join BasicData..Area a on a.superior=g.areaid
inner join BasicData..kindergarten n on n.residence=a.ID 
where g.gid=@gid and (a.ID=@aid or @aid=-1)


GO
