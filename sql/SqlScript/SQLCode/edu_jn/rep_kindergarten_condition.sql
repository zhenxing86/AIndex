USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_condition]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE  PROCEDURE [dbo].[rep_kindergarten_condition]
@gid int
,@aid int
,@page int
,@size int
AS

create table #tempareaid
(
lareaid int,
lareatitle nvarchar(100)
)






declare @lever int
select @lever=[level] from Area where ID=@gid

insert into #tempareaid(lareaid,lareatitle)
select ID,Title from Area 
where (superior=@gid or ID=@gid)

declare @pcount int


--当市选择全部的时候，表示查询该市的城区园
if(@lever=1 and @aid=-1 or @gid=@aid)
begin
set @aid=@gid
end



select @pcount=count(l.kid)
from  #tempareaid
inner join gartenlist l on lareaid=areaid and (lareaid=@aid or @aid=-1)
and (lareaid=@aid or @aid=-1)



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
select l.kid from  #tempareaid
inner join gartenlist l on lareaid=areaid and (lareaid=@aid or @aid=-1)
left join kininfoapp..kindergarten_condition k on k.kid=l.kid

			SET ROWCOUNT @size
			SELECT 
			 @pcount,g.kid,g.[kname],area1,area2,area3,area4,book,econtent	FROM 
				@tmptable AS tmptable		
			inner join gartenlist g
			ON  tmptable.tmptableid=g.kid 
			left join kininfoapp..kindergarten_condition k on k.kid=g.kid	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

	select @pcount,l.kid,l.[kname],area1,area2,area3,area4,book,econtent
from  #tempareaid
inner join gartenlist l on lareaid=areaid and (lareaid=@aid or @aid=-1)
left join kininfoapp..kindergarten_condition k on k.kid=l.kid

end





drop table #tempareaid



GO
