USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[GetkindergartenBygidcc]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetkindergartenBygidcc] 
@gid int
as 

select n.kid,n.[kname] from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
where gi.gid=@gid



GO
