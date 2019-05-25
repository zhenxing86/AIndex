USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[BasicDataArea_GetListByAid]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BasicDataArea_GetListByAid]
@gid int
,@aid int
,@level int
as

if(@aid=0)
begin
select @aid=areaid from group_baseinfo where gid=@gid
end

select ID,Title,Superior,[level],Code,gid from BasicData..Area 
left join group_baseinfo on areaid=ID
where (superior=@aid or ID=@aid) and [level]=@level




GO
