USE [GBApp]
GO
/****** Object:  StoredProcedure [dbo].[homebookrefresh]    Script Date: 2014/11/24 23:07:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[homebookrefresh] --63530
@userid int
 AS

--declare @userid int
--set @userid=63530
declare @ohbid int
declare @nhbid int


select @ohbid=t1.hbid,@nhbid=t3.hbid
from growthbook t1 left join basicdata..user_class t2 on t1.userid=t2.userid
inner join homebook t3 on t3.classid=t2.cid
where t1.userid=@userid and t3.term='2014-0' and t1.term='2014-0'

update t2 set t2.class_name=t3.cname from basicdata..user_class t1 
inner join gbapp..childreninfo t2 on t1.userid=t2.userid
inner join gbapp..GrowthBook gb on t2.gbid=gb.gbid and gb.term='2014-0'
            left join basicdata..class t3 on t1.cid=t3.cid where t1.userid=@userid

--print @ohbid
--print @nhbid

if(@ohbid<>@nhbid)
begin

update growthbook set hbid=@nhbid where hbid=@ohbid	 and userid=@userid and term='2014-0'

--update lifephoto set hbid=@nhbid where  hbid=@ohbid and userid=@userid
--update pworkphoto set hbid=@nhbid where  hbid=@ohbid and userid=@userid
--update tworkphoto set hbid=@nhbid where  hbid=@ohbid and userid=@userid
update section set hbid=@nhbid where  hbid=@ohbid and userid=@userid
--update video set hbid=@nhbid where  hbid=@ohbid and userid=@userid
update summary set hbid=@nhbid where  hbid=@ohbid and userid=@userid
update advsummary set hbid=@nhbid where  hbid=@ohbid and userid=@userid
update celllist set hbid=@nhbid where  hbid=@ohbid and userid=@userid
update advcelllist set hbid=@nhbid where  hbid=@ohbid and userid=@userid


end
	
	IF @@ERROR <> 0 
	BEGIN 		
	   RETURN (-1)
	END
	ELSE
	BEGIN	
	   RETURN (1)
	END












GO
