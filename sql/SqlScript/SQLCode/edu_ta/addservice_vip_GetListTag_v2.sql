USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[addservice_vip_GetListTag_v2]    Script Date: 08/10/2013 10:11:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  PROCEDURE [dbo].[addservice_vip_GetListTag_v2] 
 @page int
,@size int
,@kid int
,@txtcid int
,@txtname varchar(200)
,@txtaccount varchar(200)
,@txttel varchar(200)
,@txtispay varchar(200)
,@txtisopen varchar(200)
,@txtftime varchar(200)
,@txtltime varchar(200)
,@txtiskin varchar(200)
 AS 




declare @ispay int 
select @ispay=dbo.addservice_proxysettlement(@kid)



declare @pcount int
declare @sqlwhere varchar(300)--拼接条件的时候使用
set @sqlwhere=''

create table #rep_kin_temp
(
	lcid int,
	lcname nvarchar(100),
	luid int,
	luname nvarchar(100),
	lmobile varchar(30),
	lisfree int,
	lnormalprice int,
	StartDate datetime,
	EndDate datetime,
	lvipstatus int,
	ludeletetag int
)

create table #rep_class_temp
(
	lcid int,
	lcname nvarchar(100),
	luid int,
	ldeletetag int
)




if(@txtaccount<>'')--登录帐号不为空，精确查询
begin


insert into #rep_class_temp(lcid,lcname,luid,ldeletetag)
select uc.cid,c.cname,u.userid,u.deletetag from basicdata..user_class uc
inner join basicdata..class c on c.cid=uc.cid
inner join basicdata..[user] u on u.userid=uc.userid
where c.kid=@kid and u.account=@txtaccount and u.usertype=0


insert into #rep_kin_temp(lcid,lcname,luid,luname,lmobile,lisfree,lnormalprice,StartDate,EndDate,lvipstatus,ludeletetag)
select lcid,lcname,luid,b.[name],b.mobile,a.isfree,a.normalprice,z.StartDate,z.EndDate,d.vipstatus,r.ldeletetag from #rep_class_temp r
inner join basicdata..user_baseinfo b on b.userid=r.luid
inner join basicdata..child d on d.userid=r.luid
left join addservice a on a.uid=r.luid and a.deletetag=1
left join zgyey_om..vipdetails z on (z.UserID=r.luid and z.IsCurrent=1)

set @pcount=@@RowCount


end
else if(@txttel<>'')--手机号码不为空，精确查询
begin



insert into #rep_class_temp(lcid,lcname,luid,ldeletetag)
select uc.cid,c.cname,u.userid,u.deletetag from basicdata..user_class uc
inner join basicdata..class c on c.cid=uc.cid
inner join basicdata..[user] u on u.userid=uc.userid
inner join basicdata..user_baseinfo b on b.userid=uc.userid
where c.kid=@kid and b.mobile = @txttel and u.usertype=0


insert into #rep_kin_temp(lcid,lcname,luid,luname,lmobile,lisfree,lnormalprice,StartDate,EndDate,lvipstatus,ludeletetag)
select lcid,lcname,luid,b.[name],b.mobile,a.isfree,a.normalprice,z.StartDate,z.EndDate,d.vipstatus,r.ldeletetag from #rep_class_temp r
inner join basicdata..user_baseinfo b on b.userid=r.luid
inner join basicdata..child d on d.userid=r.luid
left join addservice a on a.uid=r.luid and a.deletetag=1
left join zgyey_om..vipdetails z on (z.UserID=r.luid and z.IsCurrent=1)

set @pcount=@@RowCount


end
else--其他情况，条件拼接
begin

declare @cwhere int
set @cwhere=0
if(@txtcid<>-1)--班级不为空
begin
set @cwhere = 1
end

if(@txtispay<>-1)--缴费状态不为空
begin
set @sqlwhere=' and a.vippaystate= '+convert(varchar,@txtispay)
end

if(@txtisopen<>-1)--开通状态不为空
begin
set @sqlwhere=' and d.vipstatus= '+convert(varchar,@txtisopen)
end

if(@txtname<>'')--姓名不为空
begin
set @sqlwhere=' and b.[name] like '''+@txtname+'%'''
end


if(@cwhere=1)
begin

insert into #rep_class_temp(lcid,lcname,luid,ldeletetag)
select uc.cid,c.cname,u.userid,u.deletetag from basicdata..user_class uc
inner join basicdata..class c on c.cid=uc.cid
inner join basicdata..[user] u on u.userid=uc.userid
where c.kid=@kid and u.usertype=0 and uc.cid=@txtcid

end
else
begin

insert into #rep_class_temp(lcid,lcname,luid,ldeletetag)
select uc.cid,c.cname,u.userid,u.deletetag from basicdata..user_class uc
inner join basicdata..class c on c.cid=uc.cid
inner join basicdata..[user] u on u.userid=uc.userid
where c.kid=@kid and u.usertype=0

end



if(@sqlwhere<>'')
begin


insert into #rep_kin_temp(lcid,lcname,luid,luname,lmobile,lisfree,lnormalprice,StartDate,EndDate,lvipstatus,ludeletetag)
exec('
select lcid,lcname,luid,b.[name],b.mobile,a.isfree,a.normalprice,z.StartDate,z.EndDate,d.vipstatus,r.ldeletetag from #rep_class_temp r
inner join basicdata..user_baseinfo b on b.userid=r.luid
inner join basicdata..child d on d.userid=r.luid
left join addservice a on a.uid=r.luid and a.deletetag=1
left join zgyey_om..vipdetails z on (z.UserID=r.luid and z.IsCurrent=1)
 where 1=1 '+@sqlwhere)

set @pcount=@@RowCount



end
else
begin

insert into #rep_kin_temp(lcid,lcname,luid,luname,lmobile,lisfree,lnormalprice,StartDate,EndDate,lvipstatus,ludeletetag)
select lcid,lcname,luid,b.[name],b.mobile,a.isfree,a.normalprice,z.StartDate,z.EndDate,d.vipstatus,r.ldeletetag from #rep_class_temp r
inner join basicdata..user_baseinfo b on b.userid=r.luid
inner join basicdata..child d on d.userid=r.luid
left join addservice a on a.uid=r.luid and a.deletetag=1
left join zgyey_om..vipdetails z on (z.UserID=r.luid and z.IsCurrent=1)


set @pcount=@@RowCount


end


end--其他情况，条件拼接




/**************分页开始********************/
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
select luid from #rep_kin_temp
order by lvipstatus desc

			
			
			SELECT 
	@pcount,lcid,lcname,luid,luname,lmobile
,[a1],[a2],[a3],[a4],[a5],[a6],[a7],[a8] 
,(select top 1 info from dbo.dict where ID=a1)
,(select top 1 info from dbo.dict where ID=a2)
,(select top 1 info from dbo.dict where ID=a3)
,(select top 1 info from dbo.dict where ID=a4)
,(select top 1 info from dbo.dict where ID=a5)
,(select top 1 info from dbo.dict where ID=a6)
,(select top 1 info from dbo.dict where ID=a7)
,(select top 1 info from dbo.dict where ID=a8)
,lisfree,lnormalprice,StartDate,EndDate,lvipstatus,a.vippaystate,@ispay,ludeletetag

FROM 
				@tmptable AS tmptable		
			INNER JOIN #rep_kin_temp r
			ON  tmptable.tmptableid=r.luid
			left join addservice a on a.uid=r.luid
			WHERE
				row>@ignore





end
else--第一页
begin
SET ROWCOUNT @size


select @pcount,lcid,lcname,luid,luname,lmobile
,[a1],[a2],[a3],[a4],[a5],[a6],[a7],[a8] 
,(select top 1 info from dbo.dict where ID=a1)
,(select top 1 info from dbo.dict where ID=a2)
,(select top 1 info from dbo.dict where ID=a3)
,(select top 1 info from dbo.dict where ID=a4)
,(select top 1 info from dbo.dict where ID=a5)
,(select top 1 info from dbo.dict where ID=a6)
,(select top 1 info from dbo.dict where ID=a7)
,(select top 1 info from dbo.dict where ID=a8)
,lisfree,lnormalprice,StartDate,EndDate,lvipstatus,a.vippaystate,@ispay,ludeletetag
 from  #rep_kin_temp r
 left join addservice a on a.uid=r.luid
order by lvipstatus desc
--if(@txtaccount<>'')--登录帐号不为空，精确查询
--begin
--
--select @pcount,c.cid,c.cname,k.userid,b.[name],b.mobile
--,[a1],[a2],[a3],[a4],[a5],[a6],[a7],[a8] 
--,(select top 1 info from dbo.dict where ID=a1)
--,(select top 1 info from dbo.dict where ID=a2)
--,(select top 1 info from dbo.dict where ID=a3)
--,(select top 1 info from dbo.dict where ID=a4)
--,(select top 1 info from dbo.dict where ID=a5)
--,(select top 1 info from dbo.dict where ID=a6)
--,(select top 1 info from dbo.dict where ID=a7)
--,(select top 1 info from dbo.dict where ID=a8)
--,isfree,normalprice,StartDate,EndDate,d.vipstatus,a.vippaystate,@ispay,u.deletetag
-- from basicdata..user_kindergarten k
--left join basicdata..child d on d.userid=k.userid
--left join basicdata..user_class uc on uc.userid=k.userid
--inner join basicdata..class c on c.cid=uc.cid
--inner join basicdata..[user] u on u.userid=k.userid
--inner join basicdata..user_baseinfo b on b.userid=k.userid
--left join addservice a on a.uid=k.userid and a.deletetag=1
--left join zgyey_om..vipdetails z on (z.UserID=k.userid and z.IsCurrent=1)
--where k.kid=@kid  and u.usertype=0 and account=@txtaccount and u.deletetag=1
-- order by d.vipstatus desc
--
--end
--else if(@txttel<>'')--手机号码不为空，精确查询
--begin
--
--select @pcount,c.cid,c.cname,k.userid,b.[name],b.mobile
--,[a1],[a2],[a3],[a4],[a5],[a6],[a7],[a8] 
--,(select top 1 info from dbo.dict where ID=a1)
--,(select top 1 info from dbo.dict where ID=a2)
--,(select top 1 info from dbo.dict where ID=a3)
--,(select top 1 info from dbo.dict where ID=a4)
--,(select top 1 info from dbo.dict where ID=a5)
--,(select top 1 info from dbo.dict where ID=a6)
--,(select top 1 info from dbo.dict where ID=a7)
--,(select top 1 info from dbo.dict where ID=a8)
--,isfree,normalprice,StartDate,EndDate,d.vipstatus,a.vippaystate,@ispay,u.deletetag
-- from basicdata..user_kindergarten k
--left join basicdata..child d on d.userid=k.userid
--left join basicdata..user_class uc on uc.userid=k.userid
--inner join basicdata..class c on c.cid=uc.cid
--inner join basicdata..[user] u on u.userid=k.userid
--inner join basicdata..user_baseinfo b on b.userid=k.userid
--left join addservice a on a.uid=k.userid and a.deletetag=1
--left join zgyey_om..vipdetails z on (z.UserID=k.userid and z.IsCurrent=1)
--where k.kid=@kid  and u.usertype=0 and b.mobile = @txttel and u.deletetag=1
-- order by d.vipstatus desc
-- 
--end
--else--其他情况，条件拼接
--begin
--
--
--set @sql=
--'select @pcount,c.cid,c.cname,k.userid,b.[name],b.mobile
--,[a1],[a2],[a3],[a4],[a5],[a6],[a7],[a8] 
--,(select top 1 info from dbo.dict where ID=a1)
--,(select top 1 info from dbo.dict where ID=a2)
--,(select top 1 info from dbo.dict where ID=a3)
--,(select top 1 info from dbo.dict where ID=a4)
--,(select top 1 info from dbo.dict where ID=a5)
--,(select top 1 info from dbo.dict where ID=a6)
--,(select top 1 info from dbo.dict where ID=a7)
--,(select top 1 info from dbo.dict where ID=a8)
--,isfree,normalprice,StartDate,EndDate,d.vipstatus,a.vippaystate,@ispay,u.deletetag
-- from basicdata..user_kindergarten k
--left join basicdata..child d on d.userid=k.userid
--left join basicdata..user_class uc on uc.userid=k.userid
--inner join basicdata..class c on c.cid=uc.cid
--inner join basicdata..[user] u on u.userid=k.userid
--inner join basicdata..user_baseinfo b on b.userid=k.userid
--left join addservice a on a.uid=k.userid and a.deletetag=1
--left join zgyey_om..vipdetails z on (z.UserID=k.userid and z.IsCurrent=1)
--where k.kid=@kid  and u.usertype=0 and u.deletetag=1 '+@sqlwhere+'
-- order by d.vipstatus desc'
--
--exec sp_executesql @sql, N'@count int out,@kid varchar(20),@pcount int,@ispay int', @pcount out,@kid,@pcount,@ispay
--
--end


end
drop table #rep_class_temp
drop table #rep_kin_temp


/**************分页结束********************/
GO
