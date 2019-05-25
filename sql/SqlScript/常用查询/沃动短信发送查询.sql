

select * from kmapp..phonecode where phone='18627955721' and adddate>='2018-10-29'
--发送失败记录
select * from gateway_log where actionname='main/checkPhoneBase' and crtdate>='2018-10-29'
--沃动返回日志 
select * from mt_log where mobile='18627955721' and crtdate>='2018-10-29'