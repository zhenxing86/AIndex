USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kin_remind_List]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rep_kin_remind_List]
@page int
,@size int
,@uid int
,@cuid int
,@deletetag int
as

declare @usertype int,@roleid int,@bid int,@duty varchar(20)
select @usertype=usertype,@roleid=roleid,@bid=bid,@duty=duty from users u
inner join [role] r on u.roleid=r.ID
 where u.ID=@uid


create table #ulist
(puid int)


insert into #ulist(puid) values (@uid)

insert into #ulist(puid)
select ID from users where seruid=@uid

insert into #ulist(puid)
select cuid from users_belong where puid=@uid  and deletetag=1

if(@usertype=0 and @bid>0)
begin

insert into #ulist(puid)
select ID from users where bid=@bid and deletetag=1 and ID not in (select puid from #ulist)
end



declare @pcount int

select @pcount=count(1) from remindlog r
inner join #ulist u on r.uid=u.puid
inner join users s on u.puid=s.ID
where (r.deletetag=@deletetag or @deletetag=-1) and r.uid=@cuid

IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		if(@pcount<@ignore)
		begin
			set @page=@pcount/@size
			if(@pcount%@size<>0)
			begin
				set @page=@page+1
			end
			SET @prep=@size*@page
			SET @ignore=@prep-@size
		end
		
		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

			SET ROWCOUNT @prep
INSERT INTO @tmptable(tmptableid)
select r.ID from remindlog r
inner join #ulist u on r.uid=u.puid
inner join users s on u.puid=s.ID
where (r.deletetag=@deletetag or @deletetag=-1)  and r.uid=@cuid


			SET ROWCOUNT @size

select @pcount,s.[name],result,info,intime,r.deletetag 
 from 
@tmptable AS tmptable		
 inner join remindlog r
ON  tmptable.tmptableid=r.ID 
inner join #ulist u on r.uid=u.puid
inner join users s on u.puid=s.ID
where  row>@ignore 



end
else
begin
SET ROWCOUNT @size

select @pcount,s.[name],result,info,intime,r.deletetag from remindlog r
inner join #ulist u on r.uid=u.puid
inner join users s on u.puid=s.ID
where (r.deletetag=@deletetag or @deletetag=-1)  and r.uid=@cuid
order by s.[name] desc,result asc,intime desc

end

drop table #ulist




GO
