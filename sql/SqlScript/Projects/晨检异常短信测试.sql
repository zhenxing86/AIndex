[stu_mc_day_highTw_GetListV2] 20345,1,10,'2016-05-24 00:00:00','2016-05-24 23:59:59','',-1              
go                
stu_mc_day_highTw_GetList 12511,1,10,'2014-12-15 00:00:00','2014-12-15 23:59:59','',-1                
stu_mc_day_highTw_GetList 11061,1,10,'2014-12-16 00:00:00','2014-12-16 23:59:59','',-1                
                
select *
--update d set status=0,ftype=0, cdate = '2016-05-24 08:59:59',CheckDate='2016-05-24',tw='37.8',zz='3,10',sms_tw='37.8',sms_zz='3,10' 
From  stu_mc_day d where kid=20345 and id =7160738   

update d set status=0,ftype=0, cdate = '2016-05-24 08:59:59',CheckDate='2016-05-24',tw='36.80',zz='7,2,8',sms_tw='36.80',sms_zz='7,2,8' 
From  stu_mc_day d where kid=20345 and id =4541761 
    
update d set status=0,ftype=0, cdate = '2016-05-24 08:59:59',CheckDate='2016-05-24',tw='36.80',zz='8,5,10',sms_tw='36.80',sms_zz='8,5,10' 
From  stu_mc_day d where kid=20345 and id =7160737
           
select * from mcapp..cardinfo where card='1307009427'    


select * from mcapp..sms_mc where kid=20345  and writetime>='2016-05-24'
select * from mcapp..push_mc where kid=20345  and writetime>='2016-05-24'

select * from mcapp..sms_mc_test where kid=20345  and writetime>='2016-05-24'
select * from mcapp..push_mc_test where kid=20345  and writetime>='2016-05-24'
select * from AppLogs..mc_log where kid=20345  and crtdate>='2016-05-24'