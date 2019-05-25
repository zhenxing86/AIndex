use ossapp
go
/*        
-- Author:      xie        
-- Create date: 2014-07-15       
-- Description: 新增VIP套餐状态记录        
-- Memo:      
    
  addservice_status_Add 'child',2429,-1,'349264',26,'2014-07-20 10:00:00.000','2014-09-21 10:00:00.000',1,134
*/        
        
alter PROC [dbo].[addservice_status_Add]        
@typename varchar(100)   --kin、class、child
,@kid int --必须
,@cid int --选填
,@cuid varchar(5000) --选填
,@p1 int  --VIP套餐id
,@ftime datetime
,@ltime datetime
,@isopen int --
,@uid int  --操作人   
         
AS        
BEGIN        
    
	declare @temp table   
	(  
	tuid int,  
	tcid int  
	) 
	
	if(@typename= 'kin')
	begin
		insert into @temp(tuid,tcid)   
		 select u.userid,c.cid
		  from BasicData..[user] u  
		   inner join BasicData..user_class uc on u.userid=uc.userid   
		   inner join BasicData..class c on c.cid=uc.cid  
		 where u.usertype=0 and c.deletetag=1 
		  and c.kid=@kid and c.grade<>38  
	end
	else if(@typename= 'class')
	begin
		insert into @temp(tuid,tcid)   
		 select u.userid,uc.cid
		  from BasicData..[user] u  
		   inner join BasicData..user_class uc on u.userid=uc.userid  
		  where u.usertype=0 
		   and uc.cid=@cid 
	
	end
	else if(@typename= 'child')
	begin
		CREATE TABLE #ID(col int)  
        INSERT INTO #ID  
		 select distinct col  --将输入字符串转换为列表  
		  from BasicData.dbo.f_split(@cuid,',') 
		   
		insert into @temp(tuid,tcid)   
		 select u.userid,uc.cid
		  from BasicData..[user] u  
		   inner join BasicData..user_class uc 
		    on u.userid=uc.userid
		   inner join #ID d 
		    on d.col=u.userid
		  where u.usertype=0 
	end
	
	Begin tran     
	BEGIN TRY  
	    if(@isopen=0)
		begin
			--关闭原有套餐
			update s set status=0,
			  ftime = case when DATEDIFF(SS, GETDATE() ,ftime) < 0 then ftime else GETDATE() end
		      ,ltime= case when DATEDIFF(SS, GETDATE() ,ltime) < 0 then ltime else GETDATE() end
			 from addservice_status_log s
			  inner join @temp t on s.userid =s.userid and s.status=1
		end
		else if @isopen=1 --开通
		begin
			--关闭原有套餐
			update s set status=0,
			   ftime = case when DATEDIFF(SS, GETDATE() ,ftime) < 0 then ftime else GETDATE() end,
			   ltime= case when DATEDIFF(SS, GETDATE() ,ltime) < 0 then ltime else GETDATE() end
			 from addservice_status_log s
			  inner join @temp t on s.userid =s.userid and s.status=1
			  
			declare @fprice int,@fproxyprice int,@a1 int,@a2 int,@a3 int,@a4 int,@a5 int,@a6 int,
	                @a7 int,@a8 int,@a1str nvarchar(20),@a9 int,@a10 int,@a11 int,@a12 int,@a13 int,@a14 int  
	 
			select @fprice=price,@fproxyprice=proxyprice,@a1=a1,@a2=a2,@a3=a3,@a4=a4,@a5=a5,@a6=a6,@a7=a7,@a8=a8,
			       @a9=a9,@a10=a10,@a11=a11,@a12=a12,@a13=a13,@a14=a14 from feestandard  
			 where ID=@p1   
			select @a1str=info from dbo.dict where ID=@a1  
	
			insert into addservice_status_log
					   (kid,cid,userid,pid,pname,status,normalprice,discountprice,
						paytime,ftime,ltime,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,douserid,dotime,a14)
			 select @kid,tcid,tuid,@p1,@a1str,1,@fprice,@fproxyprice,GETDATE(),
			 case when DATEDIFF(SS, GETDATE() ,@ftime) > 0 then @ftime else GETDATE() end,
			 case when DATEDIFF(SS, GETDATE() ,@ltime) > 0 then @ltime else GETDATE() end,  
					@a1,@a2,@a3,@a4,@a5,@a6,@a7,@a8,@a9,@a10,@a11,@a12,@a13,@uid,GETDATE(),@a14 
			  from @temp t 
        end       
	    Commit tran                                
	 End Try        
	 Begin Catch  
		select ERROR_LINE() as Line, 
		 ERROR_MESSAGE() as message1, 
		 ERROR_NUMBER() as number, 
		 ERROR_PROCEDURE() as proc1, 
		 ERROR_SEVERITY() as severity, 
		 ERROR_STATE() as state1   
		Rollback tran        
	 end Catch         
END 


--declare @time1 datetime =getdate(),@time2 datetime ='2014-07-14 15:00'
--SELECT DATEDIFF([second], @time1 , @time2)  
--SELECT DATEDIFF(ss, @time1 , @time2)