USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[MsgTeacher_GetList_dj]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[MsgTeacher_GetList_dj]
@gid int
,@aid int--
,@kid int
,@title varchar(100)
,@uname varchar(100)
,@page int
,@size int
as 


create table #temparea
(
lid int,
lsuperior int
)

insert into #temparea
select ID,-1 from Area 
where superior=@gid or ID=@gid




declare @pcount int
declare @str varchar(max)
set @str=''


select @str=@str+','+convert(varchar,userid) from 
dbo.group_user 
inner join #temparea on lid=areaid
where (areaid=@aid or @aid=-1) and username like @uname+'%'


set @pcount=@@ROWCOUNT


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
	select userid from 
dbo.group_user 
inner join #temparea on lid=areaid
where  (areaid=@aid or @aid=-1) and username like @uname+'%'






		


			SET ROWCOUNT @size
			SELECT 
				@pcount,(select title from Area where ID=@gid) areaname
,(select title from Area where ID=areaid) areaname,0 kid,'' [kname],userid,username,tel,
(select dname from dbo.group_department d where d.did=r.did) job,@str
			FROM 
				@tmptable AS tmptable	
inner  join group_user r on r.userid=tmptableid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size



select @pcount,(select title from Area where ID=@gid) areaname
,(select title from Area where ID=areaid) areaname,0 kid,'' [kname],userid,username,tel,
(select dname from dbo.group_department d where d.did=g.did) job,@str
 from   dbo.group_user g
inner join #temparea on lid=areaid
where (areaid=@aid or @aid=-1) and username like @uname+'%'




end

drop table #temparea



GO
