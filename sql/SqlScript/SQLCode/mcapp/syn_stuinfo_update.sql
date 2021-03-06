USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[syn_stuinfo_update]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[syn_stuinfo_update]

@kid int
as

create table #stuidlist
(
oid int
)

insert into #stuidlist(oid)
select t1.stuid from stuinfo t1 left join basicdata..[user] t2 on t1.stuid=t2.userid
where (t1.name<>t2.name or t1.birth<>convert(varchar(10),t2.birthday,23)) 
and t1.kid=@kid



update t1 set t1.name=t2.name,t1.birth=convert(varchar(10),t2.birthday,23) from #stuidlist t0 left join  stuinfo t1 on t0.oid=t1.stuid
 left join basicdata..[user] t2 on t1.stuid=t2.userid


delete from stuid_tmp where oid in (select oid from #stuidlist)

--if(exists(select oid from #stuidlist))
--begin
	INSERT INTO [mcapp].[dbo].[querycmd]
			   ([kid]
			   ,[devid]
			   ,[querytag]
			   ,[adatetime]
			   ,[syndatetime]
			   ,[status])
	select kid,devid,1,getdate(),getdate()+0.01,1 from driveinfo
	where kid=@kid
--end


GO
