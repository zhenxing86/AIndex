


select appid,min(actiondatetime),MAX(actiondatetime) From appcenter_log
where appid >100 and appid<108
group by appid

select MAX(actiondatetime) From appcenter_log
where appid=101  

select appid,COUNT(userid) from(
select appid,userid From appcenter_log
where appid >100 and appid<108
group by appid,userid
)t
group by appid

select appid,COUNT(userid) From appcenter_log
where appid >100 and appid<108
group by appid


总共健康管理的vip人数也统计一下


select COUNT(*) from ossapp..addservice a
inner join basicdata..[Child] c
 on a.uid=c.userid and c.vipstatus=1
where a.a9>0 


    (userid,usertype,actiondatetime,appid,asctiondesc)  
   VALUES(@userid,@usertype,getdate(),@appid,@asctiondesc)   


readcount_Update  readtestapp

  update ReadCount set [count]=[count]+1 where userid=@uid and pushid=@pushid  

select COUNT(userid),SUM(readcount) readcount from(
select userid,SUM([count]) readcount from readtestapp..ReadCount 
group by userid
)t


select userid,COUNT(userid),SUM(count) readcount from readtestapp..ReadCount 
group by userid