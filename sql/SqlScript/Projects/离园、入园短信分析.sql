   --找出要发送的        
 select 100 id ,760007 stuid,1 InSend,1 OutSend, '2014-05-07 10:10:00' adate, '2014-05-07 15:10:00' cdate        
 into #cet             
        
 --取入园离园        
Select * From sms..sms_message_yx_temp 
Where recuserid IN (Select userid From basicdata.dbo.[user] Where kid = 23391 and name='周盛扬') 
and convert(varchar(10), sendtime, 120) = '2014-07-16'
 
 Select * From basicdata.dbo.[user] Where kid = 23391 and name='周盛扬'
 select * from mcapp..cardinfo where userid=849271
select * from mcapp..stu_mc_day_raw where kid=23391 and Card='1308021696' and  cdate >= '2014-07-16' 
select * from mcapp..stu_mc_day where kid=23391 and stuid= 849271 and  cdate >= '2014-07-16'  
sms..sms_message_yx kid not In (20361, 11061) --悦信 
sms..sms_message_yx_mc kid In (20361, 11061) and cdate <= '2014-06-24'   --这是不发送的 
sms..sms_message  kid In (20361, 11061) and cdate >= '2014-06-24'  --玄武
  
  
  --select * from BasicData..User_Child where userid=760007
  
  --update BasicData..[User] set mobile='13632432093' where userid=760007
  
  
select * from BasicData..kindergarten where kid = 22052
  sms..sms_message_yx where kid = 22052
  
  select top 10 * from mcapp..sms_mc where kid =22052 and sendtime>='2014-05-08' order by smsid desc
  select * FROM MCAPP..stu_mc_day_raw where kid =22052 and aDATE>='2014-05-08' 
  
   select top 10 * from sms..sms_message_yx_temp where kid =21469
  and content like '%已经由家长接离幼儿园!' order by smsid desc
  
  select * from mcapp..kindergarten where sendset >0
  
  select * from AppLogs..EditLog where DbName='mcapp' and TbName='kindergarten' and  KeyCol=12512
  
