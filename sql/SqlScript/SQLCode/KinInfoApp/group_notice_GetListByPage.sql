USE [KinInfoApp]
GO
/****** Object:  StoredProcedure [dbo].[group_notice_GetListByPage]    Script Date: 2014/11/24 23:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[group_notice_GetListByPage]
@g_kid int
,@p_kid int
,@istype int
,@page int
,@size int
,@firsttime datetime
,@lasttime datetime
,@title varchar(100)
,@areaid int
 AS

if(@firsttime = '')
BEGIN
set @firsttime=convert(datetime,'1900-01-01')
End


if(@lasttime = '')
BEGIN
set @lasttime=convert(datetime,'2090-01-01')
End

set @lasttime=dateadd(day,1,@lasttime)

declare @pcount int,@p int

if(@g_kid<0)--教育局的进来(@p_kid=教育局的用户名，可以查看自己发出去的)
begin

select @pcount=count(nid) from [group_notice] 
where deletetag=1 and (istype=@istype or istype=0)
and inuserid=@p_kid
and intime >@firsttime and intime <= @lasttime	and title like '%'+@title+'%'
and g_kid=0 and areaid=@areaid

end
else
begin

select @pcount=count(nid) from [group_notice] 
where deletetag=1 and (istype=@istype or istype=0)
and ','+p_kid+',' like '%,'+convert(varchar,@p_kid)+',%'  
and intime >@firsttime and intime <= @lasttime	and title like '%'+@title+'%'
and g_kid=0
end



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
if(@g_kid<0)--教育局的进来(@p_kid=教育局的用户名，可以查看自己发出去的)
begin
INSERT INTO @tmptable(tmptableid)
select nid from [group_notice] 
where deletetag=1 and (istype=@istype or istype=0)
and inuserid=@p_kid
and intime >@firsttime and intime <= @lasttime	and title like '%'+@title+'%'
and g_kid=0  and areaid=@areaid order by intime desc
end
else
begin
INSERT INTO @tmptable(tmptableid)
select nid from [group_notice] 
where deletetag=1 and (istype=@istype or istype=0)
and ','+p_kid+',' like '%,'+convert(varchar,@p_kid)+',%'  
and intime >@firsttime and intime <= @lasttime	and title like '%'+@title+'%'
and g_kid=0 order by intime desc
end
	


			SET ROWCOUNT @size

			SELECT 
				@pcount,t1.nid,t1.title,t1.content,istype,inuserid,intime,t1.g_kid,t1.p_kid,(select count(1) from group_noticeattachs a where a.nid=t1.nid),p_kname
			,case when isread is null then 0 else isread end as isread
FROM 
				@tmptable AS tmptable		
			INNER JOIN [group_notice] t1
			ON  tmptable.tmptableid=t1.nid 	
left join group_notice_state a on a.nid = t1.nid  and  a.p_kid = @p_kid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size


if(@g_kid<0)--教育局的进来(@p_kid=教育局的用户名，可以查看自己发出去的)
begin

select 
@pcount,n.nid,n.title,n.content,n.istype,inuserid,n.intime,n.g_kid,convert(varchar,n.p_kid),(select count(1) from group_noticeattachs a where a.nid=n.nid),p_kname
 ,case when isread is null then 0 else isread end as isread
from [group_notice] n
left join group_notice_state a on a.nid = n.nid  and  a.p_kid = @p_kid
where deletetag=1 and (istype=@istype or istype=0)
and inuserid=@p_kid
and n.intime >@firsttime and intime <= @lasttime	and title like '%'+@title+'%'
and g_kid=0  and areaid=@areaid order by intime desc

end
else
begin

select 
@pcount,n.nid,n.title,n.content,n.istype,n.inuserid,n.intime,n.g_kid,convert(varchar,n.p_kid),(select count(1) from group_noticeattachs a where a.nid=n.nid),n.p_kname
 ,case when isread is null then 0 else isread end as isread
from [group_notice] n
left join group_notice_state a on a.nid = n.nid  and  a.p_kid = @p_kid
where n.deletetag=1 and (n.istype=@istype or n.istype=0)
and ','+n.p_kid+',' like '%,'+convert(varchar,@p_kid)+',%' 
and n.intime >@firsttime and n.intime <= @lasttime	and n.title like '%'+@title+'%'
and n.g_kid=0 order by n.intime desc
end





end






GO
