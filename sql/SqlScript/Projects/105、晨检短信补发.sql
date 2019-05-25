

select top 10* from mcapp..sms_mc  where writetime>='2016-03-01' and smstype=12
 
select * from mcapp..sms_mc where kid= 22052 and writetime>='2016-03-01'
select * from mcapp..sms_mc where kid= 22052 and sendtime>='2016-02-01'
select * from AppLogs..mc_log where kid= 22052 and crtdate>='2016-03-01'

 
'logcnt:4noupstucnt:0hxnotsend:0createtime2015-09-22 17:34:35ver#v_000039611_1.7.4#2000-08-26&stucnt#444#2015-09-22 17:31:33&teacnt#41#2015-09-22 17:31:33'
 
 declare @content nvarchar(2000)=
 '“潘伊一”小朋友没有开通VIP服务，不发送晨检短信！【userid=1418149,content=尊敬的潘伊一小朋友家长：您的孩子今天晨检情况正常，正在愉快地参与活动，如有异常我们会及时与您联系。】'         


select substring(@content,CHARINDEX( 'content=',@content)+8,LEN(@content)-CHARINDEX( 'content=',@content)-8)   

--Left(@status, Charindex('noupstucnt:', @status) + len('noupstucnt:') -1), '')   


select substring(content,CHARINDEX( 'content=',content)+8,LEN(content)-CHARINDEX( 'content=',content)-8) ,*
 from AppLogs..mc_log where kid= 22052 and crtdate>='2016-03-01' and ID not in(2709128,2710384,2716200)
 

insert into mcapp..sms_mc(guid,smstype,recuserid,recmobile,sender,content,status,sendtime,writetime,kid,cid,code)
select '',12,u.userid,u.mobile,0,
'尊敬的'+u.name+'小朋友家长：您的孩子今天晨检情况正常，正在愉快地参与活动，如有异常我们会及时与您联系。',
0,GETDATE(),GETDATE(),22052,u.cid,0
 from AppLogs..mc_log m
  inner join basicdata..[USER_child] u
   on m.userid=u.userid
    where m.kid= 22052 and m.crtdate>='2016-03-01'
 
 
 
