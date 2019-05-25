--我想清楚幼儿园有哪些家长只关注了健康卫士哪些家长绑定了健康卫士，能不能查得到？或者能不能将这些数据导出来
use BasicData
go

select * from User_Child uc 
where kid=20675 and exists(select 1 from weixin_user wu where uc.userid=wu.userid)

