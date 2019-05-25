--Ìå¼ìµ¼Èë:project=2 

--healcheck.zgyey.com

--'13168390125yz'£¬ÉóºË£º'13168390125b'

--ÕæÊµÓ×¶ùÔ°£ºÆôË¼¹ú¼Ê£¬µ¼×ÊÁÏÕÊºÅ£º'13430308689'£¬ÉóºËÕÊºÅ£º'13002007773a'

--×ÊÁÏÕËºÅ '13250280609' £»ÉóºËÕÊºÅ£º'13138649800'

ÉóºË£º'13168390125b' Õâ¸öÕÊºÅÄú°ïÎÒ

2116844
2106696

select *from PayApp..admin_user where project=2 and kid=35625  --test
select *
--delete u
--update u set userid=2427870
from PayApp..admin_user u where project=2 and kid=34886 and id=26

select * from basicdata..[user] where userid in(2116844,2106696)

/*
insert into PayApp..admin_user(kid,userid,admintype,project) values(21935,777495,1,2)
insert into PayApp..admin_user(kid,userid,admintype,project) values(21935,1076409,0,2)

insert into PayApp..admin_user(kid,userid,admintype,project) values(35625,2503733,1,2)
insert into PayApp..admin_user(kid,userid,admintype,project) values(35625,2503732,0,2)
*/

·ëÃô¾ê '15113822332' µ¼×ÊÁÏ
¶­Ë¼  'mhjdongsi'    ÉóºË


healthapp..rep_child_standard_grow_all_detail
healthapp..rep_stu_weight_all

select * from PayApp..heal_check_excel where crtdate>='2018-06-22'
select * from PayApp..heal_check_notice where crtdate>='2018-06-22'

delete from PayApp..heal_check_excel where crtdate>='2018-04-26'
delete from PayApp..heal_check_notice where crtdate>='2018-04-26'

select *
--update n set status=0
 from payapp..heal_check_notice n where kid=20675 and term='2018-0' and userid>0 
select * 
--update g set height=0,weight=0
from healthapp..hc_grow g where adddate>='2018-04-28'

select * from HealthApp..hc_grow_change

select * from payapp..heal_check_notice n where kid=20675 and term='2018-0' and userid>0 
and not exists (select 1 from healthapp..hc_grow g where g.adddate>='2018-04-28' and n.userid=g.userid)


select n.*,g.deletetag,g.byteacher from payapp..heal_check_notice n 
outer apply (select * from healthapp..hc_grow g where g.adddate>='2018-04-28' and n.userid=g.userid) g
where kid=20675 and term='2018-0' and n.userid>0 

