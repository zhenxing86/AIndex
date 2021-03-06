USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[syn_userinfo_delete]    Script Date: 05/14/2013 14:54:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[syn_userinfo_delete]

@kid int
as

create table #stuidlist
(
oid int
)

insert into #stuidlist(oid)
select t1.stuid from stuinfo t1 left join basicdata..[user] t2 on t1.stuid=t2.userid
where (t2.deletetag=0 or t2.userid is null) --and t2.usertype=0
and t1.kid=@kid

INSERT INTO [mcapp].[dbo].[card_delete_tmp]
           ([oid]           
           ,[usertype]
           ,[kid]
           ,[adate])
select t1.oid,0,@kid,getdate() from  #stuidlist t1 left join
[card_delete_tmp] t2 on t1.oid=t2.oid
where (t2.usertype=0 or t2.oid is null)

create table #teaidlist
(
oid int
)

insert into #teaidlist(oid)
select t1.teaid from teainfo t1 left join basicdata..[user] t2 on t1.teaid=t2.userid
where (t2.deletetag=0 or t2.userid is null) --and t2.usertype<>0
and t1.kid=@kid

INSERT INTO [mcapp].[dbo].[card_delete_tmp]
           ([oid]           
           ,[usertype]
           ,[kid]
           ,[adate])
select t1.oid,1,12511,getdate() from  #teaidlist  t1 left join
[card_delete_tmp] t2 on t1.oid=t2.oid
where (t2.usertype=1 or t2.oid is null)

if(exists(select oid from #stuidlist) or exists(select oid from #teaidlist))
begin
	INSERT INTO [mcapp].[dbo].[querycmd]
			   ([kid]
			   ,[devid]
			   ,[querytag]
			   ,[adatetime]
			   ,[syndatetime]
			   ,[status])
	select kid,devid,3,getdate(),getdate()+0.01,1 from driveinfo
	where kid=@kid
end
GO
