USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[initattendancesyndata]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









-- =============================================
-- Author:		<Author,,along>
-- Create date: <Create Date,,2007-07-06>
-- Description:	<Description,,取博客最新动态>
-- select * from attendanceversion
--select * From attendance where kid=4037
--select * from t_kindergarten where id in(5312,5313,5314,5315,5316)
--exec [initattendancesyndata] 4037
--select * From userinfo_interface where kid=1897 and status=0
--select * From patriarch_interface where kid=58 and usertype=1
--select * From bind_interface where kid=58 and issyn=0
--select * from card where kid=58
--select * From userinfo_interface where kid=58
--select * From userinfo_interface where kid= 5315
--[initattendancesyndata] 58
-- =============================================
CREATE PROCEDURE [dbo].[initattendancesyndata] 
@kid int
AS
BEGIN

delete patriarch_interface where kid=@kid
delete userinfo_interface where kid=@kid
delete bind_interface where kid=@kid

--select *  from card where kid=5316
--
update card set issyn=0 ,enrolsource=1 where kid=@kid
	--userinfo_interface
insert into userinfo_interface (kid,userid,name,classname,teachername,gender,enrolldate,
actiontype,actiondate,status,subno)
select t1.kindergartenid as kid,t1.userid,t1.name,t2.name as classname,'' as teachername,
dbo.dictionarycaptionfromid(gender) as gender,getdate() as enrolldate,0 as actiontype,getdate() as actiondate,
0 as status,0 as subno from t_child t1,t_class t2 where t1.kindergartenid=@kid 
and t1.status=1 
and t1.classid=t2.id

--teacher patriarch_interface
insert into patriarch_interface (kid,pid,userid,name,fphone,phone,address,ssn,releation,actiontype,actiontime,status,usertype,subno)
select @kid as kid,pid,userid,name,fphone,phone,address,ssn,releation,0 as actiontype, getdate() as actiontime,0 as status,1 as usertype,0 as subno
 from patriarch 
where userid in (select userid from t_staffer where kindergartenid=@kid and status=1)

--userinfo patriarch_interface
insert into patriarch_interface (kid,pid,userid,name,fphone,phone,address,ssn,releation,actiontype,actiontime,status,usertype,subno)
select @kid as kid,pid,userid,name,fphone,phone,address,ssn,releation,0 as actiontype, getdate() as actiontime,0 as status,0 as usertype,0 as subno 
from patriarch 
where userid in (select userid from t_child where kindergartenid=@kid and status=1)

--child_bind
insert into bind_interface(kid,subno,userid,pid,cardno,enrolnum,actiontype,issyn)
select @kid as kid,0 as subno,t2.userid,t1.pid,t1.cardno,0 as enrolnum,
0 as actiontype,0 as issyn from patriarchcard t1, 
patriarch t2 where t1.pid=t2.pid and t2.userid 
in (select userid from t_child where kindergartenid=@kid and status=1)

--teacher_bind
insert into bind_interface(kid,subno,userid,pid,cardno,enrolnum,actiontype,issyn)
select @kid as kid,0 as subno,t2.userid,t1.pid,t1.cardno,0 as enrolnum,
0 as actiontype,0 as issyn from patriarchcard t1, 
patriarch t2 where t1.pid=t2.pid and t2.userid 
in (select userid from t_staffer where kindergartenid=@kid and status=1)

END











GO
