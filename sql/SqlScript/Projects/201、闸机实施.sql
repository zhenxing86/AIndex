
--删除闸机

 select * 
 --delete
 from mcapp..gate_device where sn='3013163300090'
 select * 
 --delete
 from mcapp..gate_timezones_device where sn='3013163300090'
 
 
 



--28277两台闸机删掉。DDG7040087021700198	与DDG7020087012100462
select * 
--delete p
from  mcapp..gate_device p where kid=34819 and sn in('DDG7040087021700198','DDG7020087012100462')
select * 
--delete p
from  mcapp..gate_timezones_device p where kid=34819 and sn in('DDG7040087021700198','DDG7020087012100462')


--麻烦帮我把这个闸机DDG7020087012100462转到29096去
select * 
--update p set kid =20345
from  mcapp..gate_device p where sn in('DDG7020087012100411')
select * 
--update p set kid =20345
from  mcapp..gate_timezones_device p where sn in('DDG7020087012100411') 

-----------------不是从33789切换到别的闸机时-----------------
declare @oldkid int, @kid int,@sn nvarchar(50)
Begin
  select @oldkid =kid from mcapp..gate_device where sn=@sn and deletetag=1  
  update mcapp..gate_device set kid=@kid where sn=@sn and deletetag=1  
  update mcapp..gate_timezones_device set kid=@kid where sn=@sn  
 
  insert into mcapp..init_gate_device_log(sn ,oldkid,newkid, deletedOldData,douserid,dotime,ipaddr)  
   values(@sn,@oldkid,@kid,0,1,GETDATE(),'33.7.8.9')  
  
  exec ossapp..[permissionsetting_Update]  @ptype =1000, @kid =@kid      
End
---------------------------------------------------------------------
select * from  mcapp..kin_perminssion_gate p where kid=33690
select * from  mcapp..gate_device p where kid=20345
select * from  mcapp..gate_timezones_device p where kid=33690
 
init_ZKAccess @kid=33690,@sn='3013161600016',@priority=0,@deletedOldData=0
3013161600053

select *
-- delete c
--update c set status=0
from mcapp..gate_command c 
where 
kid=31338 -- and crtdate>='2016-08-29' and sn='3013161600016' and crtdate<='2016-08-31 12:10'  and status<2
--and cmdcontent like '%2761188954%'
and cmdcontent like '%104672%'


cardno=1186992666 pin=101839

select * from mcapp..cardinfo where card='3255166949'
select * from mcapp..cardinfo where gate_card='3255166949'
select * from mcapp..cardinfo where card in('1187106778','1186880090')

select * from mcapp..cardinfo_log where card in ('1187106778','1186880090') order by id
select * from basicdata..[user] where userid= 2108153

select sn,COUNT(*) 
from mcapp..gate_command c where kid=32833 and crtdate>='2016-08-29' and crtdate<='2016-08-29 12:10'  and status<2
group by sn
----------------------------------------------------------------------------------

--删除用户
insert into gate_command(kid,sn,cmdtype,cmdcontent,priority)
values(20345,'3013163300031','DATA DELETE','DATA DELETE user cardno=1186880090',0)
insert into gate_command(kid,sn,cmdtype,cmdcontent,priority)
values(20345,'3013163300031','DATA DELETE','DATA DELETE user pin=3021',0)
insert into gate_command(kid,sn,cmdtype,cmdcontent,priority)
values(20345,'3013163300031','DATA DELETE','DATA DELETE userauthorize pin=3022',0)
--更新用户
insert into gate_command(kid,sn,cmdtype,cmdcontent,priority)
values(20345,'3013163300031','DATA UPDATE','DATA UPDATE user cardno=1187106778	pin=101	password=	group=0	starttime=0	endtime=0	name=	superauthorize=0	disable=0',0)
insert into gate_command(kid,sn,cmdtype,cmdcontent,priority)
values(20345,'3013163300031','DATA UPDATE','DATA UPDATE userauthorize pin=101	authorizetimezoneid=1	authorizedoorid=3',0)

----------------------------------------------------
--新增用户
--insert into mcapp..gate_command(kid,sn,cmdtype,cmdcontent,priority)
 select c.kid,d.sn,'DATA UPDATE','DATA UPDATE user cardno='+c.gate_card+CHAR(9) + 'pin='+ cast(c.gate_pin as varchar) +CHAR(9)
 +'password='+CHAR(9)+'group=0'+CHAR(9) + 'starttime=0'+ CHAR(9)+ 'endtime=0'+ CHAR(9)+ 'name='+ CHAR(9)
 + 'superauthorize=0'+ CHAR(9)+ 'disable=0',1
 from mcapp..cardinfo c
 inner join mcapp..gate_device d on c.kid=d.kid and d.deletetag=1
 where isnull(c.gate_pin,'0')<>'0' and c.card in('1186331194','1187425914','1549252420','1186604506','2760240090')  
go

select * from mcapp..cardinfo where card in('1186331194','1187425914','1549252420','1186604506','2760240090')

--新增权限
--insert into mcapp..gate_command(kid,sn,cmdtype,cmdcontent,priority)
select c.kid,g.sn,'DATA UPDATE','DATA UPDATE userauthorize pin='+cast(c.gate_pin as varchar)+CHAR(9)
 +'authorizetimezoneid='+cast(g.TimeZoneID as varchar)+CHAR(9)+'authorizedoorid='+cast(g.authorizedoorid as varchar),1
 from mcapp..cardinfo c
  inner join mcapp..gate_timezones_device g on c.kid=g.kid 
 where isnull(c.gate_pin,'0')<>'0' and c.card in('1186331194','1187425914','1549252420','1186604506','2760240090') 
 go
 
insert into gate_command(kid,sn,cmdtype,cmdcontent,priority)
values(20345,'3013163300031','DATA UPDATE','DATA UPDATE user cardno=1187106778	pin=102	password=	group=0	starttime=0	endtime=0	name=	superauthorize=0	disable=0',0)
insert into gate_command(kid,sn,cmdtype,cmdcontent,priority)
values(20345,'3013163300031','DATA UPDATE','DATA UPDATE userauthorize pin=102	authorizetimezoneid=1	authorizedoorid=3',0)

1186880090  101  3021 
1187106778  102  3022

select * from mcapp..cardinfo where card in ('1186992666','2760508970')

select * from mcapp..gate_device where kid=20345
 -------------------------指令查询-----------------------------------------------
--http://121.9.242.118:8031/_logdata/gate-Log-2016-09-01.log

select * from mcapp..cardinfo where kid=34114 and card in ('2761535562','1186320090','2759933754','2760799114')
select * from mcapp..cardinfo where card in ('1186880090','1187106778')
select * from  mcapp..gate_device p where kid=34114  --2761234346

update mcapp..cardinfo set gate_card='2760093322' where kid=34114 and card='2760093322'

3013161600022
3013161600076

select * from mcapp..gate_command_data d
 inner join mcapp..gate_command c
  on d.cmdid = c.id
  where sn='3013161600022' and c.crtdate>='2016-09-08'

--insert into mcapp..gate_command(kid,sn,cmdtype,cmdcontent,priority)
--values(33681,'3013161600065','GET OPTIONS','GET OPTIONS Door1DelayOpenTime,Door2DelayOpenTime,Door1Drivertime,Door2Drivertime,Door1Intertime,Door2Intertime',0)


 insert into gate_command_data(cmdid,cmd_return_data)    
  values(@cmdid,@cmd_return_data)   
  
-----------------------------------------------------------------------

--查询
insert into gate_command(kid,sn,cmdtype,cmdcontent,priority)
values(20345,'3013161600026','DATA QUERY','DATA QUERY tablename=user,fielddesc=*,filter =*',0)
insert into gate_command(kid,sn,cmdtype,cmdcontent,priority)
values(20345,'3013163300031','DATA QUERY','DATA QUERY tablename=userauthorize,fielddesc=*,filter =*',0)

3013161600026

insert into mcapp..gate_command(kid,sn,cmdtype,cmdcontent,priority)
select kid,sn,'DATA QUERY','DATA QUERY tablename=transaction,fielddesc=*,filter=NewRecord',0
 from mcapp..gate_device d 
  where kid= 34257 and deletetag=1


-------------------------------------------------------------------------------------
【正常的设置是 Door1DelayOpenTime=0/Door1Drivertime=1/Door1Intertime=0】

select * from mcapp..gate_device where kid=33690

--把后台验证关掉 SET OPTIONS AutoServerMode=0
insert into mcapp..gate_command(kid,sn,cmdtype,cmdcontent,priority)
values(33301,'3013161600042','SET OPTIONS','SET OPTIONS AutoServerMode=0',0)

insert into mcapp..gate_command(kid,sn,cmdtype,cmdcontent,priority)
values(33301,'3013161600042','SET OPTIONS','SET OPTIONS Door1DelayOpenTime=0',0)

--  查询开门延时时间 GET OPTIONS Door1DelayOpenTime
--  查询锁驱动时长，就是开门后几秒之后，继电器才锁上 GET OPTIONS Door1Drivertime  
--  查询刷卡间隔 GET OPTIONS Door1Intertime 
insert into mcapp..gate_command(kid,sn,cmdtype,cmdcontent,priority)
values(33301,'3013161600042','GET OPTIONS','GET OPTIONS Door2Intertime',0)

--  设置开门延时时间 SET OPTIONS Door1DelayOpenTime=0
--  锁驱动时长，就是开门后几秒之后，继电器才锁上，SET OPTIONS Door1Drivertime=1
--  查询刷卡间隔 SET OPTIONS Door1Intertime=0 
insert into mcapp..gate_command(kid,sn,cmdtype,cmdcontent,priority)
values(33301,'3013161600042','SET OPTIONS','SET OPTIONS Door2Intertime=0',0)



declare @year int,@month int,@day int,@hour int ,@minute int,@second int, @strdate bigint= 347748895,@strdate2 bigint= 347748895,@now datetime='2016-09-26 09:28:25' --getutcdate() 
select
 --((datepart(Year,@now)-2000)*12*31 +(datepart(Month,@now)-1)*31+(datepart(Day,@now)-1))*(24*60*60)
 --               +datepart(Hour,@now)*60*60+datepart(Minute,@now)*60+datepart(Second,@now),
((datepart(Year,@now)-100)*12*31) +(datepart(Month,@now)*31)+ datepart(Day,@now)-1)*(24*60*60)
                +(datepart(Hour,@now)*60+datepart(Minute,@now))*60+datepart(Second,@now)


select @strdate = ((datepart(Year,@now)-2000)*12*31 +(datepart(Month,@now)-1)*31+(datepart(Day,@now)-1))*(24*60*60)
                +datepart(Hour,@now)*60*60+datepart(Minute,@now)*60+datepart(Second,@now),
                @strdate2 = ((datepart(Year,@now)-100)*12*31 +(datepart(Month,@now)*31)+ datepart(Day,@now)-1)*(24*60*60)
                +(datepart(Hour,@now)*60+datepart(Minute,@now))*60+datepart(Second,@now)
                
select @year=datepart(Year,@now) ,@month=datepart(Month,@now) ,@day=datepart(Day,@now) ,
@hour=datepart(Hour,@now) ,@minute=datepart(Minute,@now) ,@second=datepart(Second,@now) 

select @now 当前时间,@strdate 格式转换后时间,@year [year],@month [month],@day [day],@hour [hour] ,@minute [minute],@second [Second]

select ((@year-100)*12*31+(@month*31)+@day-1)*(24*60*60)+(@hour*60+@minute)*60+@second
go


--------------------------------------------------------------------------------------

--通过cmd命令查询闸机设备参数
cmd--》 telnet 192.168.0.223  --》 输入 root 

-------------------------------闸机时间同步---------------------------------------
535841896

declare @strdate int= 347748895,@now datetime='2016-09-26 09:28:25' --getutcdate() 
set @strdate = ((datepart(Year,@now)-2000)*12*31 +(datepart(Month,@now)-1)*31+(datepart(Day,@now)-1))*(24*60*60)
                +datepart(Hour,@now)*60*60+datepart(Minute,@now)*60+datepart(Second,@now)
                
select @now 当前时间,@strdate 格式转换后时间,datepart(Year,@now) Year,datepart(Month,@now) Month,datepart(Day,@now) Day,
datepart(Hour,@now) Hour,datepart(Minute,@now) Minute,datepart(Second,@now) Second

insert into mcapp..gate_command(kid,sn,cmdtype,cmdcontent,priority)
values(33681,'3013161600078','SET OPTIONS','SET OPTIONS DateTime='+CAST(@strdate as varchar),1)
go

declare @dateTime int= 347748895,@now datetime='2016-09-27 19:28:25' --getutcdate() 
set @dateTime = ((datepart(Year,@now)-2000)*12*31 +(datepart(Month,@now)-1)*31+(datepart(Day,@now)-1))*(24*60*60)
                +datepart(Hour,@now)*60*60+datepart(Minute,@now)*60+datepart(Second,@now)
                
select @now 当前时间,@dateTime 格式转换后时间,datepart(Year,@now) Year,datepart(Month,@now) Month,datepart(Day,@now) Day,
datepart(Hour,@now) Hour,datepart(Minute,@now) Minute,datepart(Second,@now) Second
declare --@dateTime bigint=537874105,
@year int,@month int,@day int,@hour int ,@minute int,@second int

select @second=@dateTime%60,@minute=(@dateTime/60)%60,@hour=(@dateTime/3600)%24,
@day=(@dateTime/86400)%31+1,@month= ( @dateTime / 2678400 ) % 12 + 1,
@year = (@dateTime / 32140800 ) + 2000

select cast(@year as varchar)+'-'+cast(@month as varchar)+'-'+cast(@day as varchar)+' '+cast(@hour as varchar)+':'+cast(@minute as varchar)+':'+cast(@second as varchar) 当前时间,
@dateTime 格式转换后时间,@year [year],@month [month],@day [day],@hour [hour] ,@minute [minute],@second [Second]
go

---------------------------------------------------------------------------------------------

insert into mcapp..gate_command(kid,sn,cmdtype,cmdcontent,priority)
values(20345,'6564152700105','SET OPTIONS','SET OPTIONS MachineTZ=+0800',0)

select replace(cmdcontent,'authorizedoorid=1','authorizedoorid=3'),*
--update c set cmdcontent=replace(cmdcontent,'authorizedoorid=1','authorizedoorid=3'),status=0
 from  mcapp..gate_command c where sn='3013161600042' and cmdcontent like '%authorizedoorid=1'

--闸机时间查询
 select * from mcapp..gate_rtlog_history h
  inner join mcapp..gate_device d on h.sn=d.sn
   where d.kid=34257 and h.crtdate>='2016-09-19' 
    order by h.sn

-----------------------数据查询------------------------

select * from mcapp..gate_rtstate where crtdate>='2016-08-24' and sn='3013161600042'
select * from mcapp..gate_rtstate_history where crtdate>='2016-08-24' and sn='3013161600042'
select * from mcapp..gate_rtstate_history where crtdate>='2016-08-24' and sn='3013161600054'

select * from mcapp..gate_rtlog where crtdate>='2016-08-24'
select * from mcapp..gate_rtlog_history where crtdate>='2016-08-24'
select * from mcapp..gate_command_data where crtdate>='2016-08-24'
select * from mcapp..gate_command where kid=32210 and crtdate>='2016-09-01' order by id
select * from mcapp..gate_command_history where crtdate>='2016-08-24' order by id



select * 
--update c set status=0
from mcapp..gate_command c where kid=33830 and status<2 and crtdate>='2016-09-01' 



  
;with cet as(
 select '%DelayOpenTime%' cmdtxt union
 select '%Drivertime%' cmdtxt union
 select '%Intertime%' cmdtxt
 )
 select gc.sn,d.cmdid,d.cmd_return_data,d.crtdate
  from gate_command_data d
   inner join gate_command gc on gc.id=d.cmdid and d.cmdid>=5500 and d.cmdid<=5756
   inner join cet c on d.cmd_return_data like cmdtxt

exec mcapp..init_gate_pin @kid=32210  






