二代新版接送软件下载地址： 
 
mcapp..TransferCardListTocardinfo @kid = 17814

select *from mcapp..LogInfo
where logtype=22 and devid='002067530'


select  * from mcapp..cardinfo where kid=1550 and cardno = '2044149'
select  * from mcapp..cardinfo where kid=1550 and cardno = '4786587'

select * from CardApp..usercard where kid =1550 and Cardno in ('2044149','4786587')
select * from CardApp..cardlist where kid =1550 and Cardno in ('2044149','4786587')


;with cet as(
select distinct kid from cardapp..cardlist 
)
select * from cet 
where not exists (select * from mcapp..driveinfo d
where cet.kid=d.kid)

select * from  mcapp..driveinfo where 
select d.kid,k.kname,d.* from mcapp..driveinfo d
left join BasicData..kindergarten k 
 on d.kid=k.kid
 where devicetype=2

deviceinfo_update


--二代接送出现开ID卡变成开IC卡， 并且机器码为null的问题，导致开的卡不同同步到机器里。

select * from mcapp..cardinfo where kid=18699

select * from CardApp..cardlist where kid=18699
select * from CardApp..usercard where kid=18699

InitAttendanceSynData



class_attendance_GetListByClassid
class_attendance_GetListByDepartmentid
[init_attendance_everymonth]

init_attendance_everymonth
[init_attendance_everymonth_forkid] 12511
init_attendance_everymonth_fordate


BasicData.dbo.teacher where kid=2954  

