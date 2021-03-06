USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[homebookrefreshByClassID]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO













--[homebookrefreshByClassID] 58314
CREATE PROCEDURE [dbo].[homebookrefreshByClassID] --59437
@classid int
 AS


--return 1
--declare @classid int
--set @classid=59437
declare @childcount int
declare @gbcount int
declare @returnvalue int

select @childcount=count(1) from basicdata..user_class t1 inner join basicdata..[user] t2
on t1.userid=t2.userid
where t2.usertype=0 and t2.deletetag=1 and t1.cid=@classid

select @gbcount=count(1) from growthbook t1 left join basicdata..[user] t2 on t1.userid=t2.userid
 left join basicdata..user_class t3
on t2.userid=t3.userid
left join homebook hb on t1.hbid=hb.hbid
where t2.usertype=0 and t2.deletetag=1 and t1.term='2014-0' and t3.cid=@classid 
and hb.classid=@classid and  hb.term='2014-0'

--print @childcount
--print @gbcount
if(@childcount>0)
begin
	if(@childcount<>@gbcount)
	begin
		declare @ohbid int
		declare @nhbid int

		create table #childList
		(
		id INT IDENTITY(1, 1),
		userid int
		)
		declare @i int,@uncount int,@userid int

		set @uncount=1
		insert into #childList(userid)
		select userid from basicdata..user_class where cid=@classid
		select @uncount = count(1) from #childList

		set @i=1 
		while (@i<=@uncount)
		begin
			select @userid=userid from #childList where id=@i
			select @ohbid=t1.hbid,@nhbid=t3.hbid
			from growthbook t1 inner join #childList t2 on t1.userid=t2.userid
			inner join homebook t3 on t3.classid=@classid
			where t1.userid=@userid and t3.term='2014-0'  and t1.term='2014-0'

			update t2 set t2.class_name=t3.cname from #childList t1 
			inner join gbapp..childreninfo t2 on t1.userid=t2.userid
			inner join gbapp..GrowthBook gb on t2.gbid=gb.gbid
						inner join basicdata..class t3 on t3.cid=@classid where t1.userid=@userid
						and gb.term='2014-0'
						

			if(@ohbid<>@nhbid)
			begin

			update growthbook set hbid=@nhbid where hbid=@ohbid	 and userid=@userid	  and term='2014-0'	
			update section set hbid=@nhbid where  hbid=@ohbid and userid=@userid			
			update summary set hbid=@nhbid where  hbid=@ohbid and userid=@userid
			update advsummary set hbid=@nhbid where  hbid=@ohbid and userid=@userid
			update celllist set hbid=@nhbid where  hbid=@ohbid and userid=@userid
			update advcelllist set hbid=@nhbid where  hbid=@ohbid and userid=@userid

			end
			set @i=@i+1
		end
			
		drop table #childList
		
	end
	set @returnvalue = 1
end
else
begin	 
	set @returnvalue = 0
end
	
	RETURN @returnvalue	













GO
