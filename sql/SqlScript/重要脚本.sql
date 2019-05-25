
--外联集合 写法
SELECT u.userid, u.name username, t.title, u.mobile, 
					 CASE WHEN sm.userid is null then 0 ELSE sm.roletype END [state],u.usertype
 FROM 
basicdata.dbo.[user] u 
				inner join [BasicData].[dbo].[teacher] t 
					on u.userid = t.userid 
				outer apply(select top(1)* from sms_man_kid sm where u.userid = sm.userid order by (case when sm.roletype=1 then 99 else sm.roletype end ) desc	) sm 
					
			where u.usertype > 0 
				and u.kid = 12511












select 列1,row_number()over(partition by 列1 order by 列1) rn from 表名


张三 a1234234x
张三 x123131x
李四 dhdijsdf
----------------------------------------
1 张三 a1234234x
2 张三 x123131x
1 李四 dhdijsdf


select 
  tri.name  AS  TriggerName,
  tri.is_disabled AS IsDisable,
  tri.is_instead_of_trigger AS IsInsteadOfTrigger,
  c.text AS CreateTriggerSQL
from 
  sys.triggers tri LEFT OUTER JOIN
     dbo.syscomments c ON tri.object_id = c.id

--you
Declare @Id int
Declare @icnt int=0
Declare Cur Cursor For 
select id from mcapp..cardinfo where kid = 12511
Open Cur 
Fetch next From Cur Into @Id
While @@fetch_status=0 
Begin 
set @icnt = @icnt+1
Update mcapp..cardinfo  Set enrolnum=@icnt where [id] =@Id
Fetch Next From Cur Into @Id
End 
Close Cur 
Deallocate Cur 


select * from mcapp..cardinfo where cardno=''


select * from mcapp..cardinfo where card='1307006891'
delete from mcapp..cardinfo where card='1307006891'
