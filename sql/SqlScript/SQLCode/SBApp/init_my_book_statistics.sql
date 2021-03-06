USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[init_my_book_statistics]    Script Date: 2014/11/24 23:27:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from sbapplog..sbviewcount

CREATE procedure [dbo].[init_my_book_statistics]
as
begin

	
	create table #viewtemp
	(
		sbid nvarchar(50)
		,viewcount int
		,salemoney float
	)
	
    declare @syncstart datetime,@syncend datetime
    select @syncstart = syncdate from sbapplog..my_book_sync
	set @syncend = getdate()
	update sbapplog..my_book_sync set syncdate=@syncend
	
	insert into #viewtemp(sbid,viewcount)
	select sbid,COUNT(sbid) from SBAppLog..ViewLogs vl
	where viewdatetime>@syncstart and viewdatetime<=@syncend
	group by sbid
	
	update SBAppLog..sbviewcount set viewcount= SBAppLog..sbviewcount.viewcount+isnull(v.viewcount,0)
	from #viewtemp v 
	where SBAppLog..sbviewcount.sbid=v.sbid 
	
	insert into SBAppLog..sbviewcount(sbid,viewcount,salecount,salemoney)
	select sbid,isnull(viewcount,0),0,0
	from #viewtemp v 
	where not exists
	(select 1 from SBAppLog..sbviewcount vc where v.sbid=vc.sbid)
	
	delete from #viewtemp 
	
    insert into #viewtemp(sbid,viewcount,salemoney)
	select sbid,COUNT(sbid) saleCount ,SUM(redu_bean)/5.0
	from PayApp..consum_record
	where actiondatetime>@syncstart and actiondatetime<=@syncend
	group by sbid
	
    update SBAppLog..sbviewcount set saleCount= saleCount+isnull(v.viewcount,0),salemoney=SBAppLog..sbviewcount.salemoney+isnull(v.salemoney,0)
	from #viewtemp v 
	where SBAppLog..sbviewcount.sbid=v.sbid 
	
	insert into SBAppLog..sbviewcount(sbid,viewcount,salecount,salemoney)
	select sbid,0,isnull(viewcount,0),isnull(salemoney,0)
	from #viewtemp v 
	where not exists
	(select 1 from SBAppLog..sbviewcount vc where v.sbid=vc.sbid)
	
	drop table #viewtemp
	IF @@ERROR <> 0 
	BEGIN 
	   
	   RETURN(-1)
	END
	ELSE
	BEGIN
	    	  
		RETURN (1)
	END
end



GO
