USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_teachertrainByTime_List]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_kindergarten_teachertrainByTime_List]
@gid int
,@aid int
,@timetype int
,@level int
,@page int
,@size int
AS

declare @pcount int
Create table #klist
(
kids int
)


if(@aid=-1)--集团查询@gid就是kid
begin

insert into #klist
select @gid

end
else
begin

insert into #klist
select n.kid from dbo.group_baseinfo g 
inner join BasicData..Area a on a.superior=g.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
where g.gid=@gid and a.ID=@aid

end


select @pcount=count(1) from group_teachertrain g
inner join #klist on kid=kids
inner join BasicData..[user] u on u.userid=g.userid  
inner join BasicData..teacher t on t.userid=g.userid 
where g.kid=@gid and g.deletetag=1 and  (timetype=@timetype or @timetype=-1) and ([level]=@level or @level=-1)

IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

		SET ROWCOUNT @prep

		INSERT INTO @tmptable(tmptableid)
select ID from group_teachertrain g
inner join #klist on kid=kids
inner join BasicData..[user] u on u.userid=g.userid  
inner join BasicData..teacher t on t.userid=g.userid 
where g.kid=@gid and g.deletetag=1 and  (timetype=@timetype or @timetype=-1) and ([level]=@level or @level=-1)

			SET ROWCOUNT @size
			SELECT 
				@pcount,g.userid,u.[name],
dbo.GetDictByid(timetype),
dbo.GetDictByid([level]),
title,post,education,employmentform,politicalface
			FROM 
				@tmptable AS tmptable	
			inner join group_teachertrain g on g.ID=tmptableid
inner join #klist on kid=kids
inner join BasicData..[user] u on u.userid=g.userid  
inner join BasicData..teacher t on t.userid=g.userid 
			 	
			WHERE
				row>@ignore   

end
else
begin
SET ROWCOUNT @size


select @pcount,g.userid,u.[name],
dbo.GetDictByid(timetype),
dbo.GetDictByid([level]),
title,post,education,employmentform,politicalface
  from group_teachertrain g
inner join #klist on kid=kids
inner join BasicData..[user] u on u.userid=g.userid  
inner join BasicData..teacher t on t.userid=g.userid 
where g.kid=@gid and g.deletetag=1 and  (timetype=@timetype or @timetype=-1) and ([level]=@level or @level=-1)

end
drop  table #klist

GO
