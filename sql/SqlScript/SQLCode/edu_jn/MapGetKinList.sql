USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[MapGetKinList]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[MapGetKinList] 
@gid int,
@kname varchar(100),
@page int,
@size int
as 

create table #temp
(
aid int
,a1 varchar(100)
,a2 varchar(100)
,a3 varchar(100)
,a4 varchar(100)
,a5 varchar(100)
)

insert into #temp
exec BasicDataArea_GetListByAid @gid,0,2

if(@@rowcount>0)
begin

insert into #temp(aid,a2)
select gid,-1 from #temp
inner join group_baseinfo gi on aid=gi.areaid 


delete #temp where a2>0


end


declare @pcount int

select @pcount=count(n.kid) from  dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid 
left join BasicData..kindergarten n on n.residence=a.ID 
left join kindergarten_condition c on n.kid=c.kid
inner join #temp on gid=aid
 where n.kname like '%'+@kname+'%' 


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
			select n.kid from  dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid 
left join BasicData..kindergarten n on n.residence=a.ID 
left join kindergarten_condition c on n.kid=c.kid
inner join #temp on gid=aid
 where n.kname like '%'+@kname+'%' 


			SET ROWCOUNT @size
			SELECT 
				@pcount,n.kid,n.kname,kurl,telephone,address,mappoint,mapdesc fROM 
				@tmptable AS tmptable		
left join BasicData..kindergarten n on tmptable.tmptableid=n.kid
left join kindergarten_condition c on n.kid=c.kid
			
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT  @pcount,n.kid,n.kname,kurl,telephone,address,mappoint,mapdesc from  dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
left join kindergarten_condition c on n.kid=c.kid
inner join #temp on gid=aid
 where n.kname like '%'+@kname+'%' 

end



drop table #temp












GO
