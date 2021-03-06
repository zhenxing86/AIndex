USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_growthbook_photodetail_video]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[rep_growthbook_photodetail_video]
 @page int
,@size int
,@cid int
,@term varchar(10)
AS



create table #temp
(
tvideoid int
)



declare @pcount int


insert into #temp(tvideoid) 
select MAX(g.videoid) from reportapp..rep_growthbook_class c
inner join GBApp..GrowthBook h on h.hbid=c.gbid
inner join gbapp..gbvideo g on g.gbid=h.gbid
where c.cid=@cid and  h.term=@term
group by [path]
order by MAX(updatetime) desc

set @pcount=@@ROWCOUNT


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
			select tvideoid from #temp c
			


			SET ROWCOUNT @size
			SELECT  distinct
				videoid,gbid,[path],g.sceenshot,net,updatetime,@pcount
 			FROM 
				@tmptable AS tmptable		
			INNER JOIN gbapp..gbvideo g
			ON  tmptable.tmptableid=g.videoid 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size


select videoid,g.gbid,g.sceenshot,[path],net,updatetime,@pcount from #temp c
inner join  gbapp..gbvideo g on g.videoid=c.tvideoid



end

drop table #temp

GO
