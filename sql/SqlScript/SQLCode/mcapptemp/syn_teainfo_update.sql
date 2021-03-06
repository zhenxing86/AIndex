USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[syn_teainfo_update]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[syn_teainfo_update] 

@kid int
as

create table #teaidlist
(
oid int
)

	insert into #teaidlist(oid)
		select t1.teaid from teainfo t1 left join basicdata..[user] t2 on t1.teaid=t2.userid
			where t1.name<>t2.name and t1.kid=@kid


	update t1 set t1.name=t2.name from #teaidlist t0 left join  teainfo t1 on t0.oid=t1.teaid
		left join basicdata..[user] t2 on t1.teaid=t2.userid


	delete from teaid_tmp where oid in (select oid from #teaidlist)


INSERT INTO [mcapp].[dbo].[querycmd]([kid],[devid],[querytag],[adatetime],[syndatetime],[status])
	select kid,devid,2,getdate(),getdate()+0.01,1 from driveinfo
		where kid=@kid


GO
