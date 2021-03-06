USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[InitAttendanceSynData]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,取博客最新动态>
-- select * from syninterface_cardbinding where kid=9018
-- select * From syninterface_userinfo where kid=9018 and userid=58642
--select * from cardlist where kid=9018
--select * from syninterface_cardbinding where cardno=2171761
--[InitAttendanceSynData] 9018
--select * from cardlist where cardno=15338272
--select * from usercard where cardno=15338272
--delete usercard where cardno=15338272 and kid in (9803,10871)
--select * from basicdata..[user] where userid=57844
-- =============================================
CREATE PROCEDURE [dbo].[InitAttendanceSynData] 
@kid int
AS
BEGIN

delete SynInterface_CardBinding where kid=@kid
delete SynInterface_UserInfo where kid=@kid
--
update CardList set issyn=0 ,enrolsource=1 where kid=@kid
	--userinfo_interface
insert into SynInterface_UserInfo (kid,subno,userid,usertype,showname,sayname,classname,pwd,actiontype,actiondatetime,synstatus)
select t4.kid as kid,0 as subno,t1.userid,0,T1.name,T1.name,t4.cname as classname,'' as pwd,0 as actiontype,getdate() as actiondate,0 as synstatus
from basicdata..[user] t1,
basicdata..[user_class] t3,
basicdata..[class] t4
where t3.userid=t1.userid 
and t3.cid=t4.cid
and t1.usertype=0 
and t1.deletetag=1 
and t4.kid=@kid

--teacher userinfo_interface
insert into SynInterface_UserInfo (kid,subno,userid,usertype,showname,sayname,classname,pwd,actiontype,actiondatetime,synstatus)
select t1.kid as kid,0 as subno,t1.userid,1,t1.name,t1.name,'' as classname,'' as pwd,0 as actiontype,getdate() as actiondate,0 as synstatus
from basicdata..[user] t1
where t1.usertype in (1,97) 
and t1.deletetag=1 
and t1.kid=@kid


--user_bind
insert into syninterface_cardbinding(kid,subno,userid,cardno,enrolnum,actiontype,actiondatetime,synstatus)
select t1.kid as kid,0 as subno,t1.userid,t1.cardno,t2.enrolnum as enrolnum,
0 as actiontype,getdate(),0 as synstatus 
from usercard t1,
cardlist t2
where t1.cardno=t2.cardno 
and t1.kid=t2.kid 
and t1.kid=@kid

END

GO
