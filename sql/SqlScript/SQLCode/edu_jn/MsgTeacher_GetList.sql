USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[MsgTeacher_GetList]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO













CREATE PROCEDURE [dbo].[MsgTeacher_GetList] 
@gid int
,@aid int--
,@kid int
,@title varchar(100)
,@uname varchar(100)
,@page int
,@size int
as 

if(@kid=-100)
begin
exec [MsgTeacher_GetList_dj] @gid,@aid,@kid,@title,@uname,@page,@size

end
else
begin





declare @pcount int
declare @str varchar(max)
set @str=''

select @str=@str+','+convert(varchar,[uid]) from rep_kininfo r 
where   (kid=@kid or @kid=-1) and r.areaid=@aid and t_title like @title+'%' and uname like @uname+'%'

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
	select [uid] from rep_kininfo r 
where   (kid=@kid or @kid=-1) and r.areaid=@aid  and t_title like @title+'%' and uname like @uname+'%'






		


			SET ROWCOUNT @size
			SELECT 
				@pcount,(select title from Area where ID=u_privince) areaname
,areaname,kid,[kname],[uid],uname,u_mobile,t_title job,@str
			FROM 
				@tmptable AS tmptable	
inner  join rep_kininfo r on r.uid=tmptableid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size



select @pcount,(select title from Area where ID=u_privince) areaname
,areaname,kid,[kname],[uid],uname,u_mobile,t_title job,@str
 from  rep_kininfo r 
where  (kid=@kid or @kid=-1) and r.areaid=@aid  and t_title like @title+'%' and uname like @uname+'%'


end
end



GO
