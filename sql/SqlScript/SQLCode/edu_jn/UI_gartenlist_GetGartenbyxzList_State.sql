USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetGartenbyxzList_State]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询记录信息 
--项目名称：gartenlist
------------------------------------
CREATE PROCEDURE [dbo].[UI_gartenlist_GetGartenbyxzList_State]
	@page int,
	@size int,
	@ishow int,
	@areaid int,
	@kname varchar(100),
	@byxz nvarchar(100),
	@bylx nvarchar(100)
	 AS
	 


create table #tempareaid
(
lareaid int,
lareatitle nvarchar(100)
)

insert into #tempareaid(lareaid,lareatitle)
select ID,Title from Area 
where (superior=@areaid or ID=@areaid)

 declare @pcount int


select @pcount=count(1) from [gartenlist] 
inner join #tempareaid on lareaid=areaid where 
kname like @kname+'%'  
and (byxz=@byxz or @byxz='')
and (bylx=@bylx or @bylx='')

	
	IF(@page>1)
		BEGIN
			DECLARE @prep int,@ignore int
			SET @prep=@size*@page
			SET @ignore =@prep-@size
			DECLARE @tmptable TABLE
			(
				row int IDENTITY(1,1),
				tmptableid bigint
			)
			 SET ROWCOUNT @prep
			 INSERT INTO @tmptable (tmptableid)
			 select kid
 from [gartenlist] 
inner join #tempareaid on lareaid=areaid
 where kname like @kname+'%' 
 and (byxz=@byxz or @byxz='')
 and (bylx=@bylx or @bylx='')

order by kid



			 SET ROWCOUNT @size
				SELECT   @pcount,kid,kname,regdatetime,kname,sitedns,byxz,orderby,bylx 
				  	FROM  @tmptable a
					INNER JOIN  [gartenlist] t1 on a.tmptableid = t1.kid
				WHERE row>@ignore 
	end
	else
	begin
	SET ROWCOUNT @size


select @pcount,kid,kname,regdatetime,kname,sitedns,byxz,orderby,bylx 
 from [gartenlist] 
inner join #tempareaid on lareaid=areaid
 where kname like @kname+'%' 
 and (byxz=@byxz or @byxz='')
 and (bylx=@bylx or @bylx='')
order by kid

drop table #tempareaid
end




GO
