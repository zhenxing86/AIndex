@谢振兴 代理客服将14935桃花园，登录名是13287798772，手机号是13287798772
王鹏老师
的资料转园误彻底删除，老师好几个学期的教案都没了。他们问能否将这家园的数据还原到删除资料之前的，如果恢复资料，会影响晨检数据吗


user_Delete_ly basicdata
select * from [user] where account='13287798772'
select * from leave_kindergarten where userid= 1080639
select * from BasicData..leave_user_class where userid=1080639
select * from BasicData..leave_user_card where userid=529408

select * from user_class_all  where userid= 529408 and term='2015-1' and deletetag=1    

update [user] set deletetag=1 where userid= 529408

select * from [user]  where updatetime>='2015-09-22 10:38' and usertype=1 and kid=0


27167
