


select * from mcapp..stu_mc_day_raw where kid =4246
select * from mcapp..stu_mc_day where kid =4246
select * from mcapp..stu_mc_day_raw_history where kid =4246
select * from cardapp..attendance_everymonth  where kid =4246 and  userid in(1537911,1537915,1537999,1538044) 
select * from  mcapp..rep_mc_class_checked_sum where kid =4246
select * from  mcapp..record_mc_kid_day where kid =4246  
select * from  mcapp..rep_mc_class_checked_sum where kid =4246

update cardapp..attendance_everymonth set day_10='[1507003920]08:03'
where userid =1537911 and year=2015 and month =9 

update cardapp..attendance_everymonth set day_10=' [1507003929]08:03'
where userid =1537915 and year=2015 and month =9 

update cardapp..attendance_everymonth set day_10=' [1507003925]10:55'
where userid =1537999 and year=2015 and month =9 

update cardapp..attendance_everymonth set day_10=' [1506033117]10:54'
where userid =1538044 and year=2015 and month =9 


--删除晨检记录
--delete mcapp..stu_mc_day_raw where kid =4246
--delete mcapp..stu_mc_day where kid =4246
--delete mcapp..stu_mc_day_raw_history where kid =4246
--delete cardapp..attendance_everymonth  where kid =4246
--delete  mcapp..rep_mc_class_checked_sum where kid =4246
--delete  mcapp..record_mc_kid_day where kid =4246  
--delete  mcapp..rep_mc_class_checked_sum where kid =4246

客户ID：4246 设备编号00424616 时间段：10:55-11:00 该客户在这个时间段测卡，他要求该时间段内测卡的8张刷卡记录删掉。卡的尾数是“398 396 117 397 925 926 226 225”

select  * from mcapp..stu_mc_day_raw where kid=4246 and devid='000424616'
 and cdate>='2015-09-10 10:55' and cdate<'2015-09-10 11:00'
 
select  * delete from mcapp..stu_mc_day_raw where kid=4246 and devid='000424616'
 and cdate>='2015-09-10 10:55' and cdate<'2015-09-10 11:00' and card in(
 '1507055398','1507055396','1506033117','1507055397','1507003925','1507003926','1507000225','1507000226'
 )
 
 select  * from mcapp..stu_mc_day_raw where kid=4246 and devid='000424616'
 and cdate>='2015-09-10 10:55' and cdate<'2015-09-10 11:00'
 
 select distinct userid from mcapp..cardinfo where kid=4246 and card in(
 '1507055398','1507055396','1506033117','1507055397','1507003925','1507003926','1507000225','1507000226'
 )
 
 1537911,1537915,1537999,1538044