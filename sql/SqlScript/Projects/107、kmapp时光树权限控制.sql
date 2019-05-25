use kmapp
go

/*

时光树权限控制

*/
'yz1'
---------------------【权限说明permission（对应oss后台的所有权限列表）】-------------------
select * from [BlogApp].[dbo].[permission] where parentid=0
select * 
--update p set opentype=1
from [BlogApp].[dbo].[permission] p where parentid=8 and ptype=154

--新增权限列表
declare @ptype int,@pname nvarchar(100),@remark nvarchar(max),@levelno int,@parentid int,@opentype int,@sgs int,@orderno int,@isExt int,@agentopen int

--select @levelno=1,@sgs=1,@orderno=1,@isExt=0,@agentopen=0,
--@parentid=3,@ptype=148,@pname='开通激活晨检卡',@remark='开通激活晨检卡',@opentype=1

--select @levelno=1,@sgs=1,@orderno=1,@isExt=0,@agentopen=0,
--@parentid=8,@ptype=153,@pname='关闭班级圈中的生活剪影、手工作品',@remark='勾选后，关闭班级圈中的生活剪影、手工作品',@opentype=0

select @levelno=1,@sgs=1,@orderno=1,@isExt=0,@agentopen=0,
@parentid=8,@ptype=154,@pname='允许照片同步到生活剪影、手工作品、成长日记',@remark='勾选后，允许照片同步到生活剪影、手工作品、成长日记',@opentype=0

select @orderno=MAX(isnull(orderno,0))+1 from [BlogApp].[dbo].[permission] where parentid=@parentid
insert into [BlogApp].[dbo].[permission](ptype,pname,remark,levelno,parentid,opentype,sgs,orderno,isExt,agentopen)
select @ptype,@pname,@remark,@levelno,@parentid,@opentype,@sgs,@orderno,@isExt,@agentopen

----------------------【时光树权限个性化描述及个性化链接地址Custom_Package】-------------------

--默认是使用 kid=0的描述和链接地址

select * from kmapp.[dbo].Custom_Package where kid=24082
select * from kmapp.[dbo].Custom_Package where kid=28277
select * from [BlogApp].[dbo].[permission]
--34147,34148
select * from BasicData..[User] where kid=34148 and deletetag=1 and usertype=0
insert into kmapp.[dbo].Custom_Package(kid,ptype,title,url,deletetag)
values(0,150,'健康服务包','http://sgs.pay.zgyey.com/pay/index?kid={kid}&client={client}&appver={appver}&uid={uid}&hxuid={hxuid}&role={role}&key={key}',1)


----------------------【各幼儿园的权限permissionsetting】-------------------

select * from [BlogApp].[dbo].[permissionsetting]
select distinct ptype from [BlogApp].[dbo].[permissionsetting]

select * 
--update p set pname='关闭时光树使用https协议',remark='勾选后，时光树不使用https协议'
from [BlogApp].[dbo].[permission] p
where ptype=151

----------------------------------------------------------------------------------------
declare @kid int=12511
Select * Into #permission From [BlogApp].[dbo].[permissionsetting] where kid = @kid  
select ptype,title,url into #Custom from kmapp..Custom_Package where kid= @kid and deletetag=1                                                                        
insert into #Custom select ptype,title,url
 from kmapp..Custom_Package cp where kid= 0 and deletetag=1
  and not exists(
    select 1 from #Custom cp1
     where cp1.ptype=cp.ptype
)

Select p.ptype,isnull(c.title,'') title,isnull(c.url,'') url,                                      
case when p.opentype =1 then (case when p2.ptype>0 then 1 else 0 end )                                      
else (case when p2.ptype>0 then 0 else 1 end ) end isopen                                      
From [BlogApp]..[permission] p                                      
 left join #Custom c on c.ptype = p.ptype                                    
 left join #permission p2 on p.ptype=p2.ptype                                      
  where p.sgs=1 and p.ptype>-1 and deletetag=1
  
drop table #Custom,#permission
-----------------------------------------------------------------------------------


declare @editchild int,@editteacher int  
select @editchild= sum(case when roletype=6 then 1 else 0 end), @editteacher= sum(case when roletype=7 then 1 else 0 end)  
from mcapp..sms_man_kid where kid=23967 and userid=862869 and roletype in(6,7)
group by userid

select @editchild,@editteacher


'chhlls'