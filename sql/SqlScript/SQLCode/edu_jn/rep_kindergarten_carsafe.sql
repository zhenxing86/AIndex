USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_carsafe]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[rep_kindergarten_carsafe]
@id int
,@aid int
,@page int
,@size int
AS

declare @gkid int
select @gkid=kid from group_baseinfo where gid=@id


declare @pcount int

if(@gkid=0)
begin

select @pcount=count(n.kid)
 from dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
where gi.gid=@id and (a.ID=@aid or @aid=-1)

end

else if(@aid=-2)
begin

select @pcount=count(1) from  BasicData..kindergarten n
left join SchoolBus_Base b on b.kid=n.kid 
where n.kid=@id  and b.deletetag=1


end
else
begin

select @pcount=count(n.kid)
 from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
where gi.gid=@id 

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
			
if(@gkid=0)
begin

INSERT INTO @tmptable(tmptableid)
			select n.kid  from dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
where gi.gid=@id and (a.ID=@aid or @aid=-1)

end


else if(@aid=-2)
begin
INSERT INTO @tmptable(tmptableid)
select b.id from  BasicData..kindergarten n
left join SchoolBus_Base b on b.kid=n.kid  and b.deletetag=1
where n.kid=@id 



end
else
begin

INSERT INTO @tmptable(tmptableid)
			select n.kid  from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
where gi.gid=@id 


end 




			SET ROWCOUNT @size
if(@aid=-2)
begin
			SELECT 
				@pcount,n.kid,b.id,kname
,number 校车车牌号
,transferman 每日接送总人数
,allowman 核载人数
,transfer 每日接送趟数
,transfertimes 每次最大接送幼儿人数
,transferneedtime 每趟接送时长
,transferalltime 接送总时长
,100*transfertimes/(case when allowman=0 then 1 else allowman end) 实载比例
			FROM 
				@tmptable AS tmptable	
			inner join SchoolBus_Base b on b.ID=tmptableid and b.deletetag=1
			inner join BasicData..kindergarten n on b.kid=n.kid
			
			WHERE
				row>@ignore 

end
else
begin
	SELECT 
				@pcount,n.kid,b.id,kname
,number 校车车牌号
,transferman 每日接送总人数
,allowman 核载人数
,transfer 每日接送趟数
,transfertimes 每次最大接送幼儿人数
,transferneedtime 每趟接送时长
,transferalltime 接送总时长
,100*transfertimes/(case when allowman=0 then 1 else allowman end) 实载比例
			FROM 
				@tmptable AS tmptable	
			inner join BasicData..kindergarten n on n.kid=tmptableid
			left join SchoolBus_Base b on b.kid=n.kid and b.deletetag=1
			WHERE
				row>@ignore 

end



end
else
begin
SET ROWCOUNT @size

if(@gkid=0)
begin

select @pcount,n.kid,b.id,n.kname
,number 校车车牌号
,transferman 每日接送总人数
,allowman 核载人数
,transfer 每日接送趟数
,transfertimes 每次最大接送幼儿人数
,transferneedtime 每趟接送时长
,transferalltime 接送总时长
,100*transfertimes/(case when allowman=0 then 1 else allowman end) 实载比例
 from dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
left join SchoolBus_Base b on b.kid=n.kid and b.deletetag=1
where gi.gid=@id and (a.ID=@aid or @aid=-1)

end

else if(@aid=-2)
begin
select @pcount,n.kid,b.id,n.kname
,number 校车车牌号
,transferman 每日接送总人数
,allowman 核载人数
,transfer 每日接送趟数
,transfertimes 每次最大接送幼儿人数
,transferneedtime 每趟接送时长
,transferalltime 接送总时长
,100*transfertimes/(case when allowman=0 then 1 else allowman end) 实载比例
 from  BasicData..kindergarten n 
left join SchoolBus_Base b on b.kid=n.kid and b.deletetag=1
where n.kid=@id 

end

else
begin


select @pcount,n.kid,b.id,n.kname
,number 校车车牌号
,transferman 每日接送总人数
,allowman 核载人数
,transfer 每日接送趟数
,transfertimes 每次最大接送幼儿人数
,transferneedtime 每趟接送时长
,transferalltime 接送总时长
,100*transfertimes/(case when allowman=0 then 1 else allowman end) 实载比例
 from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
left join SchoolBus_Base b on b.kid=n.kid and b.deletetag=1
where gi.gid=@id 

end 



end










GO
