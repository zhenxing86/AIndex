USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_mx]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[rep_kindergarten_mx]
@id int
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
select @lever=[level] from Area where ID=@id

insert into #tempareaid(lareaid,lareatitle)
select ID,Title from Area 
where (superior=@id or ID=@id)

declare @pcount int




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
			tmptableid bigint,
			lareatitle varchar(100)
		)

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid,lareatitle)
			select l.kid,lareatitle from  #tempareaid
			inner join gartenlist l on lareaid=areaid and (lareaid=@aid or @aid=-1)

			
		

			SET ROWCOUNT @size
			SELECT 
			@pcount,g.kid,g.kname,lareatitle,[address],mastername,telephone 	FROM 
				@tmptable AS tmptable		
			inner join gartenlist g
			ON  tmptable.tmptableid=g.kid 
			left join BasicData..kindergarten k on k.kid=g.kid	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

	select @pcount,l.kid,l.kname,lareatitle,[address],mastername,telephone 
from  #tempareaid
inner join gartenlist l on lareaid=areaid and (lareaid=@aid or @aid=-1)
left join BasicData..kindergarten k on k.kid=l.kid

end





drop table #tempareaid


GO
