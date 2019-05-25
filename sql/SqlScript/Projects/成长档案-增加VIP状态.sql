use ossapp
go

/*
exec [UserBaseInfo_GetListTag] 349264,'2014-0',1 ,'2014-0' 

select * from  ossapp..addservice_status_log s
  where userid= 349264
*/  
  
declare
@typename varchar(100)='child'   --kin、class、child
,@kid int=2429
,@cid int=53848
,@p1 int= 26 --VIP套餐id
,@ftime datetime = '2014-07-10 10:00:00'
,@ltime datetime = '2014-07-15 10:00:00'
,@isopen int =1
,@uid int =134  --操作人

--select * from feestandard where kid =@kid
declare @temp table   
	(  
	tuid int,  
	tcid int  
	) 
declare @fprice int,@fproxyprice int,@a1 int,@a2 int,@a3 int,@a4 int,@a5 int,@a6 int,
	                @a7 int,@a8 int,@a1str nvarchar(20),@a9 int,@a10 int,@a11 int,@a12 int,@a13 int  
	 
	 insert into @temp values(349264,53848)
			select @fprice=price,@fproxyprice=proxyprice,@a1=a1,@a2=a2,@a3=a3,@a4=a4,@a5=a5,@a6=a6,@a7=a7,@a8=a8,
			       @a9=a9,@a10=a10,@a11=a11,@a12=a12,@a13=a13 from feestandard  
			 where ID=@p1   
			select @a1str=info from dbo.dict where ID=@a1  
	
			--insert into addservice_status_log
					 --  (kid,cid,userid,pid,pname,status,normalprice,discountprice,
						--paytime,ftime,ltime,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,douserid,dotime)
			 select @kid,tcid,tuid,@p1,@a1str,1,@fprice,@fproxyprice,GETDATE(),@ftime,@ltime,  
					@a1,@a2,@a3,@a4,@a5,@a6,@a7,@a8,@a9,@a10,@a11,@a12,@a13,@uid,GETDATE() 
			  from @temp t 
			  
			  --delete from addservice_status_log where ID>1
			  
			  
			  --update addservice_status_log set ftime ='2014-07-10 10:00:00'

--同步数据之 修改feeid
update a set pid = f.id		
 from addservice_status_log a 
  inner join dict d 
   on a.pname = d.info
  inner join feestandard f 
   on f.a1 = d.ID 