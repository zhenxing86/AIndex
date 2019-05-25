
update user_rules set deletetag=0 where ID in(9,11,12,13,14,15,16,17,18,23,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40)

declare @name nvarchar(100)='幼儿园活跃查询',
@operat nvarchar(100) ='Abnormal'
insert into user_rules(roleid,name,operat,[level],ptype,deletetag)
values(8,@name,@operat,0,1,1)

insert into ossapp..user_rules(roleid,name,operat,[level],ptype,deletetag,[order],parentid,url)
select 10,name,operat,[level],ptype,deletetag,[order],parentid,url
from ossapp..user_rules
where roleid=9

alter table user_rules add [order] int
alter table user_rules add parentid int
alter table user_rules add url nvarchar(100)


 SELECT kb.ID, kb.kid, kb.kname,       
       kb.regdatetime, kb.ontime, kb.expiretime, kb.privince, kb.city, kb.area, kb.linkstate,       
       kb.ctype, kb.cflush, kb.clevel, kb.parentpay, kb.infofrom, kb.status,       
       kb.invoicetitle, kb.netaddress, kb.address, kb.remark, kb.deletetag, kb.abid    
    FROM ossapp..kinbaseinfo kb  
   WHERE kb.developer = '263' --and kb.status='正常缴费'       
    order by kb.kid desc

declare @name nvarchar(100)='时光树登录统计',
@operat nvarchar(100) ='TimeTreeOperate',
@url nvarchar(100)='/TimeTreeOperate/rep_login_proxy?u=5&b=7',
@order int =1,@level int=1,@parentid int =7
select @order = ISNULL(MAX([order]),0)+1 from user_rules
 where level=@level and parentid=@parentid
insert into user_rules(roleid,name,operat,[level],ptype,deletetag,parentid,[order],url)
values(11,@name,@operat,@level,1,1,@parentid,@order,@url)



user_rules

select * from ossapp..user_rules where name='客服常用功能'
update user_rules set roleid=8,[order]=1,url='~/buginfo/Index?u=1&b=1' where ID=8

update user_rules set roleid=8



select ur.*,t.name,t.operat,t.url from user_rules ur
 outer apply( select top 1 name,operat,url from user_rules urc
  where ur.id=urc.parentid and urc.deletetag=1
  )t
  where ur.parentid=0 and ur.deletetag=1 
  
  user_rules_main_menu_GetList
  [user_rules_GetList]
  
  

