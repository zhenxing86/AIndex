

select * from mcapp..mc_file_record where kid =21666 and crtdate>='2016-03-04'
select * from mcapp..stu_mc_day_raw_temp where kid =21666
select * from mcapp..stu_mc_day_raw_error where kid =21666 and adate>='2016-03-04'
select * from mcapp..stu_mc_day_raw where kid =21666 and adate>='2016-03-04'
select * from mcapp..stu_mc_day where kid =21666 and adate>='2016-03-04'

select u.name,u.usertype,c.* from mcapp..cardinfo c
 inner join basicdata..[user] u
  on c.userid= u.userid where card in(
'1401004181',
'1303001621',
'1303001631'

)

1303001619
1303001621
1303001631

select * from mcapp..cardinfo where kid=21666 and usest=1

{"cmdid":"UploadStuAllData","serno":"201208240001","vcode":"91642d447d401974a6f09b7a5d804f80","date":"2012-08-24 08:00:00","devid":"002166601","dmcob":[{"stuid":295705,"card":"1401004181","cdate":"2016-03-04 08:05:00","tw":"38.2","zz":"1,2,3","ta":"25.1","toe":"35.6","gunid":"00216660101"},{"stuid":295706,"card":"1303001621","cdate":"2016-03-04 08:00:00","tw":"37.2","zz":"2,3","ta":"25.1","toe":"35.6","gunid":"00216660101"},{"stuid":295707,"card":"1303001631","cdate":"2016-03-04 08:08:00","tw":"37.2","zz":"5","ta":"25.1","toe":"35.6","gunid":"00216660101"}]}