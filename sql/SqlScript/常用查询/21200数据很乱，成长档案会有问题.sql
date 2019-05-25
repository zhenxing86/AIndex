--¿Í·ş²¿¡ªÑÕĞ¡ÑŞ 2018/9/19 18:17:09
--ID21200£»ÕËºÅ13512743866 £»Áõè÷İæ   ÕÅÓğÍ®£¬ÕËºÅ15999972581


select * from BasicData..[user] where kid=21200 and name='Áõè÷İæ'
select * from BasicData..[user_child] where kid=21200 and name='Áõè÷İæ'
select * from BasicData..leave_kindergarten where userid=2291531

insert into BasicData..user_class(cid,userid,[order])values(164028,2120820,1)
insert into BasicData..user_class(cid,userid,[order])values(164028,2291531,1)


insert into BasicData..user_class_all(cid,userid,term,[actiondate],deletetag,[order] )values(164028,2120820,'2018-1',GETDATE(),1,1)
insert into BasicData..user_class_all(cid,userid,term,[actiondate],deletetag,[order] )values(164028,2291531,'2018-1',GETDATE(),1,1)


select * 
--update uc set cid=164028
from BasicData..user_class where userid=2120820
select * from BasicData..user_class where userid=2291531

select * from BasicData..class where kid=21200 and deletetag=1

select * from BasicData..user_class_all where userid=2120820
select * from BasicData..user_class_all where userid=2291531

'15999972581'