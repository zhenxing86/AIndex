USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_growthbook_photodetail_work]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--0生活剪影图片gbapp.gblifephoto，1手工作品：gbapp..gbworkphoto,2精彩视频gbapp..gbvideo
CREATE  PROCEDURE [dbo].[rep_growthbook_photodetail_work]
 @page int
,@size int
,@cid int
,@term varchar(10)
AS


create table #temp
(
tphotoid int
)

declare @pcount int


insert into #temp(tphotoid) 
select MAX(photoid) from reportapp..rep_growthbook_class c
inner join GBApp..GrowthBook h on h.hbid=c.gbid
inner join gbapp..gbworkphoto g on g.gbid=h.gbid
where c.cid=@cid and deletetag=1 and h.term=@term
group by m_path
order by MAX(updatetime) desc

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
			select tphotoid from #temp c

			SET ROWCOUNT @size
			SELECT 
				photoid,g.gbid,photo_desc,m_path,net,updatetime,@pcount
 			FROM 
				@tmptable AS tmptable		
			INNER JOIN gbapp..gbworkphoto g
			ON  tmptable.tmptableid=g.photoid 	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size


select photoid,g.gbid,'' photo_desc,m_path,net,updatetime,@pcount from #temp c
inner join  gbapp..gbworkphoto g on g.photoid=c.tphotoid


end


drop table #temp


GO
