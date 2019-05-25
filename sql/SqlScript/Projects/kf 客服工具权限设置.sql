use ossapp
go



select * from ossapp..user_rules where parentid=0
select * from ossapp..users where roleid=9 and deletetag=1

declare @roleid int=11,@name nvarchar(200)='IEEP报名费',
@operat nvarchar(200) ='ieep_pay',@level int=1,@ptype int=1,@deletetag int=1,@order int=1,@parentid int=3,@url nvarchar(200)='/ieep_pay/Index?u=5&b=9'
select @order=MAX([order]) from ossapp..user_rules where parentid=@parentid and roleid=@roleid
select @order oo,* from ossapp..user_rules where parentid=@parentid and roleid=@roleid

insert into ossapp..user_rules(roleid,name,operat,level,ptype,deletetag,[order],parentid,url)
values(@roleid,@name,@operat,@level,@ptype,@deletetag,isnull(@order,0)+1,3,@url)

select * 
--update r set url ='/ieep_pay/Index?u=5&b=9'
from ossapp..user_rules r where parentid=3 and name ='IEEP报名费' and roleid=9 



