USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_vip_Add_class]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addservice_vip_Add_class] 
@typename varchar(100)
,@kid int
,@cid int
,@cuid varchar(5000)
,@p1 int
,@ftime datetime
,@ltime datetime
,@ispay int
,@isopen int
,@paytime datetime
,@isproxy int
,@uid int
,@Statement int=0--是否结算，默认已结算1
as

--按班级开通VIP
begin tran 

declare @temp table 
(
tuid int,
tcid int
)



insert into @temp(tuid,tcid) 
select u.userid,c.cid from BasicData..[user] u
inner join BasicData..user_class uc on u.userid=uc.userid 
inner join BasicData..class c on c.cid=uc.cid
where u.usertype=0  and c.cid=@cid 
--and u.deletetag=1 离园的一样受影响



update  basicdata..child  set vipstatus=@isopen 
FROM basicdata..child
INNER JOIN @temp ON UserID =tuid



insert into LogData..ossapp_addservice_log
([ID] ,[kid] ,[cid] ,[uid] ,[pname] ,[describe]
,[isfree] ,[normalprice] ,[discountprice] ,[paytime]
,[ftime] ,[ltime] ,[vippaystate] ,[isproxy] ,[proxymoney]
,[proxystate] ,[proxytime] ,[proxycid]
,[a1] ,[a2] ,[a3] ,[a4] ,[a5] ,[a6] ,[a7] ,[a8],a9,[a10],[a11],[a12],[a13]
,[userid] ,[dotime] ,[deletetag])
select [ID] ,[kid] ,[cid] ,[uid] ,[pname] ,[describe]
,[isfree] ,[normalprice] ,[discountprice] ,[paytime]
,a.[ftime] ,a.[ltime] ,[vippaystate] ,[isproxy] ,[proxymoney]
,[proxystate] ,[proxytime] ,[proxycid]
,[a1] ,[a2] ,[a3] ,[a4] ,[a5] ,[a6] ,[a7] ,[a8],a9,[a10],[a11],[a12],[a13]
,[userid] ,[dotime] ,[deletetag]
FROM [addservice] a
INNER JOIN @temp ON uid =tuid
where [deletetag]=1

delete [addservice]
from [addservice]
INNER JOIN @temp ON [uid] =tuid
where [deletetag]=1 and kid=@kid


declare @fprice int,@fproxyprice int,@a1 int,@a2 int,@a3 int,@a4 int,@a5 int,@a6 int,@a7 int,@a8 int,@a1str nvarchar(20),@a9 int,@a10 int,@a11 int,@a12 int,@a13 int
select @fprice=price,@fproxyprice=proxyprice,@a1=a1,@a2=a2,@a3=a3,@a4=a4,@a5=a5,@a6=a6,@a7=a7,@a8=a8,@a9=a9,@a10=a10,@a11=a11,@a12=a12,@a13=a13 from feestandard
where ID=@p1 
select @a1str=info from dbo.dict where ID=@a1

INSERT INTO [addservice](
  [kid],[cid],[uid],[pname],[describe],[isfree],[normalprice],[discountprice],[paytime],[ftime],
 [ltime],vippaystate,[isproxy],[proxymoney],[proxystate],[proxytime],[proxycid],[a1],[a2],[a3],[a4],
 [a5],[a6],[a7],[a8],[deletetag],userid,dotime,a9,[a10],[a11],[a12],[a13])
select  @kid,t.tcid,t.tuid
,@a1str
,(case when @isopen=1 then '开通' else '关闭' end),0,@fprice,0,@paytime,@ftime,@ltime,@ispay,@isproxy,@fproxyprice,0,@paytime,0
,@a1,@a2,@a3,@a4,@a5,@a6,@a7,@a8,1,@uid,getdate(),@a9,@a10,@a11,@a12,@a13 
from @temp t



-----------------------------如果开通了数字图书馆-------------------------------------------------------------
declare @xtemp table 
	(
	xtermclass int,
	xuserid int,
	xftime datetime,
	xltime datetime
	)
	insert into @xtemp(xtermclass,xuserid,xftime,xltime)
	select (case when gtype>0 
		then convert(int,replace(gtype,4,1)) else 
		CASE CommonFun.dbo.fn_age(u.birthday) 
		WHEN 2 THEN 1 WHEN 3 THEN 1 WHEN 4 THEN 2 ELSE 3 END 
		 end)
		,a.[uid],ftime,ltime from [addservice] a
		inner join basicdata..class c on a.cid=c.cid
		inner join basicdata..grade g on g.gid=c.grade
		inner join basicdata..[user] u on u.userid=a.[uid] and u.kid=@kid
		inner join @temp on tuid=a.[uid]
	where a.kid=@kid and u.deletetag=1 and u.usertype=0 

if(@a4>0)
begin
	--开通
	if(@isopen=1)
	begin
		--先删除，如果是重复操作，则会覆盖掉旧的
		delete l from libtermbuydetail l
		inner join @xtemp on termclass=xtermclass and userid=xuserid

		insert into libtermbuydetail(termclass,userid,ftime,ltime)
		select xtermclass,xuserid,xftime,xltime from @xtemp
	
		--将新插入的写日志
		insert into LogData..ossapp_keylog([uid],dotime,descname,ipaddress,module,remark,deletetag)
		select @uid,GETDATE(),'数字图书馆阅读权限增加','0.0.0.0',@kid,'@kid='+convert(varchar,@kid)+'@termclass='+convert(varchar,xtermclass)+'@userid='+convert(varchar,xuserid)+'@ftime='+convert(varchar,xftime)+'@ltime='+convert(varchar,xltime),1 from libtermbuydetail l
		inner join @xtemp on termclass=xtermclass and userid=xuserid
	end
	
end
--关闭
if(@isopen=0)
begin
	--删除前先写日志
	insert into LogData..ossapp_keylog([uid],dotime,descname,ipaddress,module,remark,deletetag)
	select @uid,GETDATE(),'数字图书馆阅读权限删除','0.0.0.0',@kid,'@kid='+convert(varchar,@kid)+'@termclass='+convert(varchar,termclass)+'@userid='+convert(varchar,userid)+'@ftime='+convert(varchar,ftime)+'@ltime='+convert(varchar,ltime),1 from libtermbuydetail l
	inner join @xtemp on termclass=xtermclass and userid=xuserid
	
	--先删除，如果是重复操作，则会覆盖掉旧的
	delete l from libtermbuydetail l
	inner join @xtemp on termclass=xtermclass and userid=xuserid
	
	if(@a5>0)
	begin
	  update u set lqRight=CommonFun.dbo.fn_RoleDel(lqRight,[dbo].[GetCurTermType_Fun](u.userid)) 
		from basicdata..[user] u 
		inner join @temp on tuid=userid
		inner join addservice a on a.[uid]=u.userid
		where DATEDIFF(dd,ftime,GETDATE())<15
		
	end
	
end
----------------------------------------------------------------------------------------------
--如果开通乐奇
if(@a5>0)
begin

	update u set lqRight=CommonFun.dbo.fn_RoleAdd(lqRight,[dbo].[GetCurTermType_Fun](u.userid)) 
		from basicdata..[user] u 
		inner join @temp on tuid=userid
		
end


--如果开通的阅读计划
if(@a10>0)
begin

	--开通
	if(@isopen=1)
	begin
			--获取本幼儿园的kid
			select @kid=max(kid) from @temp
					inner join basicdata..[user] on tuid=userid
				
			declare @orderno varchar(100)
			--唯一来源批次
			set @orderno=replace(replace(replace(CONVERT(varchar, getdate(), 120 ),'-',''),' ',''),':','')+convert(varchar,@uid)
		
			--创建一堆订单(本学期不能重复创建)
			INSERT INTO payapp..order_record(userid, plus_amount, plus_bean, actiondatetime, orderno, [status], [from], PayType,operuid)
			select distinct tuid,ISNULL(f.price,50),ISNULL(f.price,50)*5,GETDATE(),@orderno,1,'809',1,@uid from @temp t
			inner join basicdata..[user] u on u.userid=t.tuid
			left join feestandard f on f.kid=u.kid 
			and a10>0 and isnull(a2,0)=0 and isnull(a3,0)=0 and isnull(a4,0)=0 and isnull(a5,0)=0
			and isnull(a6,0)=0 and isnull(a7,0)=0 and isnull(a8,0)=0 and isnull(a9,0)=0
			and isnull(a11,0)=0 and isnull(a12,0)=0 and isnull(a13,0)=0
			left join payapp..order_record o on o.userid=u.userid and o.[status]<>-1 and  healthapp.dbo.[getTerm_New](@kid,o.actiondatetime)=healthapp.dbo.[getTerm_New](@kid,GETDATE())
			where o.userid is null
			
			--默认他们已经缴费(本学期不能重复创建)
			INSERT INTO sbapp..EnterRead(UserID, Kid, Name)
				select distinct u.UserID, u.Kid, u.Name 
					FROM BasicData..[user] u
						inner join @temp on tuid=u.userid
						left join sbapp..EnterRead s on s.UserID=u.userid 
						and  healthapp.dbo.[getTerm_New](@kid,s.CrtDate)=healthapp.dbo.[getTerm_New](@kid,GETDATE())
						where s.userid is null
			
			
			--更新状态幼儿资料加入权限
			UPDATE u 
					SET u.ReadRight = Commonfun.dbo.fn_RoleAdd(u.ReadRight, 
							CASE WHEN g.gtype in(1,2,3,4) THEN 2 * g.gtype ELSE 2 END - Commonfun.dbo.fn_GetTermSemester(u.kid, GETDATE())) 
					from BasicData..[User] u 
						inner join @temp on tuid=userid
						INNER JOIN BasicData..user_class uc on u.userid = uc.userid and u.usertype = 0
						INNER JOIN BasicData..class c on uc.cid = c.cid
						INNER JOIN BasicData..grade g ON c.grade = g.gid
		
			--生成结算单
			declare @M_ID bigint=0
			
			--主表
			insert into payapp..Statement_M (Kid,CrtDate,OperName,Receiver,ReceiverMobile,FinalAmount,[Status],FromCode)
			values(@kid,GETDATE(),(select max(name) from users where ID=@uid),'','',0,@Statement,'线下')
			
			SET @M_ID = ident_current('payapp.dbo.Statement_M') 
			
			--从表
			insert into payapp..Statement_D(StatementID,OrderID,Amount)
			select distinct m.StatementID,o.orderid,ISNULL(o.plus_amount,50) from payapp..Statement_M m 	
					INNER JOIN BasicData..[User] u on u.kid=m.Kid
					inner join @temp on tuid=userid
					inner join payapp..order_record o on o.orderno=@orderno and o.userid=u.userid
			where m.StatementID=@M_ID 
		

	end
end

if(@a10=0 or @isopen=0)
begin
			--作废本学期的订单payapp..order_record status=-1
			update o set [status]=-1 
			 from payapp..order_record o 
				inner join @temp on tuid=o.userid
				where o.[status] = 1 
						and  healthapp.dbo.[getTerm_New](@kid,o.actiondatetime)=healthapp.dbo.[getTerm_New](@kid,GETDATE())
		

			--幼儿资料加入取消权限
			UPDATE u SET u.ReadRight = 0
					from BasicData..[User] u 
						inner join @temp on tuid=userid
						
			----获取主表ID
			--select @M_ID=MAX(d.StatementID) from payapp..order_record o 
			--	inner join @temp on tuid=o.userid
			--	inner join payapp..Statement_D d on d.OrderID=o.orderid
			--	where o.[status]=-1
			
			----作废主表
			--update payapp..Statement_M set [Status]=-1 where StatementID=@M_ID
	

	
	
	
end


-----------------------------------------------------------------------------------------------------




if @@error<>0 --判断如果有任何一条出现错误
begin rollback tran 
end
else  
begin commit tran 
end

GO
