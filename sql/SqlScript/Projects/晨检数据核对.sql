




http://tmcgw.zgyey.com/mcdatapath/mcdata/20160708/28603/002860300_148_201607081140_2240.txt
http://tmcgw.zgyey.com/mcdatapath/mcdata/20160707/28603/002860300_141_201607071110_9691.txt

----------------晨检检查--------------------------
select * from mcapp..gun_data where adate>='2016-07-15'

select * from mcapp..mc_file_record where  kid=28603 and convert(varchar(10),crtdate,120)>='2016-07-08'

select * from mcapp..mc_file_record_History where  kid=28603 and devid='002860300' order by id

select * from mcapp..stu_mc_day_raw where 
 kid=28603 and convert(varchar(10),cdate,120)='2016-07-08'
  and devid='002860300' order by cdate



insert into mcapp..mc_file_record(
kid,devid,filepath,filename,crtdate,startdate,enddate,ftype,totalCnt,succeedCnt,errorCnt,net)
values(
28603,'002860300','mcdata/20160708/28603','002860300_148_201607081140_2240.txt','2016-07-08 11:40:51.850','2016-07-08 11:40:55.717','2016-07-08 11:40:55.750',0,148,0,0,10
 )
 
select *
--update r set ftype=0
 from mcapp..mc_file_record r where kid=28603 and devid='002860300' and net=10

select * from mcapp..stu_mc_day_raw_temp where kid=28603 and devid='002860300'
select * from mcapp..stu_mc_day_raw where kid=28603 and devid='002860300'
select * from mcapp..stu_mc_day_raw where adate>='2016-07-18'
select COUNT(1) from mcapp..stu_mc_day_raw_temp where adate>='2016-07-18'
select * from mcapp..stu_mc_day_raw_error where adate>='2016-07-18'


--7-7
  select * from mcapp..stu_mc_day_raw where ID IN(
  69308175,69308186,69308189,69308200,69308219,
  69308223,69308230,69308236,69308241,69308243,
  69308246,69308254,69308255,69308259,69308266,
  69308268,69308287,69308290,69308294,69308296)
  
--7-8 
select * from mcapp..stu_mc_day_raw where ID IN(
69370057,69370081,69370084,69370086,69370091,
69370099,69370111,69370126,69370129,69370145,
69370147,69370160,69370162,69370177,69370178,
69370185,69370200
)  
  
  
select * from mcapp..stu_mc_day_raw where 
 kid=28603 and convert(varchar(10),cdate,120)='2016-07-07'
  and devid='002860300' order by ID -- cdate

--7-8

















--no_mc_data_correct 29497,'2016-01-01','2016-01-15',1  --有拍照没有刷卡记录的补救
--no_mc_data_GetList 29497,'2016-01-01','2016-01-15',1   --获取raw表数据
--no_mc_data_Check '29525,30172,19456,29279,4246,29408,29465,27867,20909,23989,27236,24071,24072,24073,14935,29457,29543,26992,24170,19467,29395,28998,21620,28240,28247,22935,31227,29497','2016-01-01','2016-01-19'
 
--------------------核对----------------
 no_mc_data_GetList 29543,'2016-01-14','2016-01-19',0  --有问题
 no_mc_data_GetList 29497,'2016-01-01','2016-01-15',1  --有问题
 no_mc_data_GetList 24878,'2016-01-01','2016-01-15',1  --有问题
 no_mc_data_GetList 28477,'2016-01-01','2016-01-15',1  --有问题
   
--江悦萌	26872	002687213	1377090	2016-01-04 17:14:53.000	20160104	13_1377090_2016-01-04-17-14-53.jpg	1	2016-01-04 12:00:00
 select * from mcapp..stu_mc_day_raw r
 inner join mcapp..cardinfo c 
 on r.card=c.card 
 where c.userid =1377090 and
  --c.kid=26872 and
  cdate>='2016-01-04' and cdate<'2016-01-05'
 
select * from mcapp..mc_pic where kid =29497 and userid=1571006 and cdate>='2015-12-08' and cdate<'2015-12-09' 
select * from mcapp..stu_mc_day where kid =29497 and stuid=1514906 and cdate>='2016-01-11' and cdate<'2016-01-12' 
select * from mcapp..mc_pic r where  kid=29543 and cdate>='2016-01-15' and cdate<'2015-12-03'
select * from basicdata..[USER] where userid= 1514231
select * from mcapp..cardinfo where userid= 899616
-----------------补救--------------------------------


幼儿园名称/ID	老师姓名	userID	卡号	刷卡时间	刷卡时间
29525/无锡市震泽实验幼儿园	浦云云	1514668	1507004768	2016/2/23	7:32:45
29525/无锡市震泽实验幼儿园	石宇	1514659	1507056198	2016/2/24	7:45:02

李黎   今天早上7:46分刷卡的
select * from basicdata..[user] where kid = 29525 and name='李黎'
select * from mcapp..cardinfo where userid=1514690
declare 
@userid int=590367
,@card nvarchar(20)='1506008480'
,@cdate datetime='2016/3/21 08:32:10'
,@devid nvarchar(20)='001938312'
,@kid int = 19383
,@adate datetime = getdate()
insert into mcapp..stu_mc_day_raw_temp(stuid,card,cdate,devid,gunid,kid,Status,adate)
select @userid,@card,@cdate,@devid,'00',@kid,0,@adate

select * from mcapp..stu_mc_day where kid =19383  and adate>='2016-03-21' and stuid= 590367
select * from mcapp..stu_mc_day_raw where kid =19383  and adate>='2016-03-21' and stuid= 590367
select day_21,* from CardApp..attendance_everymonth where kid =19383  and year=2016 and month=3 and userid= 590367

select * from mcapp..Mc_pic where userid= 590367 and crtdate>='2016-03-21'


select * from mcapp..cardinfo where card= '1506008480'  and kid=19383
 

------------------------出勤率比较高的幼儿园-------------------  
  Select top 10 *
    from record_mc_kid_day rm  
     outer apply(
     select top 1 photo from  mcapp..driveinfo d where d.kid=rm.kid and d.devicetype=1
     ) di
    where di.photo=1 and rm.cdate = '2016-01-08' -- and kid=29497 
    order by realcount desc
    
--26490,26872,24096,4246,14935, 29497,24878,29574,29525,28477
 
