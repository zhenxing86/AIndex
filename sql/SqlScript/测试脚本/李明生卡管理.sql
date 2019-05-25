select *from ossapp..users where bid>0
select *from basicdata..[user] where usertype>1 and kid=4246
select *From basicdata..[User_Child] where account='13707910517'

update ossapp..users set password='7C4A8D09CA3762AF61E59520943DC26494F8941B' where ID=129

select * from basicdata..[user] where kid=7525 and usertype>0 name=' Ñ¦Ñ¤Òð' account='115681' userid=@userid

;with cet as(
select *,ROW_NUMBER()over(partition by card order by userid desc,udate desc)rowno
 from mcapp..cardinfo_log  where kid= 19722 --and usest=1  
)
select cet.userid,u.name,c.card,* from mcapp..cardinfo c
inner join cet on c.card=cet.card and cet.userid is not null
inner join basicdata..[user] u on u.userid= cet.userid
 where c.usest=-1 and c.kid= 19722 and c.memo='ÀëÔ°×Ô¶¯¹ÒÊ§' and c.udate>='2014-09-01'
 order by c.card
 
select *From mcapp..cardinfo c where  c.kid= 19722 and c.memo='ÀëÔ°×Ô¶¯¹ÒÊ§' and c.udate>='2014-09-01'
select cet.userid,u.name,c.card,* from mcapp..cardinfo c
inner join BasicData..leave_user_card cet on c.card=cet.card
inner join basicdata..[user] u on u.userid= cet.userid
 where c.usest=-1 and c.kid= 19722 and c.memo='ÀëÔ°×Ô¶¯¹ÒÊ§' and c.udate>='2014-09-01'
 order by c.card
 
 225-195  30
 11 189
 
 select *from BasicData..leave_user_card