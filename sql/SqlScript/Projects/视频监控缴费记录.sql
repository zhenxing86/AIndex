use PayApp
go


select * from payapp..userfee_buytime where kid= 31592
select * from payapp..userfee_buytime where kid= 31996

select * from payapp..sgs_pay_record where kid=31996
select * from payapp..sgs_pay_record where kid=31592

select k.kid,k.kname,sum(case when ub.userid>0 then 1 else 0 end) 
from BasicData..kindergarten k
 left join payapp..userfee_buytime ub on k.kid =ub.kid and feetype=2
 where k.kid in(31996,31592,1695,20938,5662,33124,6748,34437,33132)
group by k.kid,k.kname


select k.kid,k.kname,COUNT(case when ub.userid>0 then 1 else 0 end) 
from BasicData..kindergarten k
 left join payapp..fee_buytime_Order ub on k.kid =ub.kid and ub.status=1 and ub.feetype=2
 where k.kid in(31996,31592,1695,20938,5662,33124,6748,34437,33132)
group by k.kid,k.kname


select * from payapp..userfee_buytime where kid=31996
select * from payapp..userfee_buytime where kid=31592
select * from payapp..userfee_buytime where kid=1695
select * from payapp..userfee_buytime where kid=20938
select * from payapp..userfee_buytime where kid=5662
select * from payapp..userfee_buytime where kid=33124
select * from payapp..userfee_buytime where kid=6748
select * from payapp..userfee_buytime where kid=34437
select * from payapp..userfee_buytime where kid=33132

select * from payapp..fee_buytime_Order where kid=31996
select * from payapp..fee_buytime_Order where kid=31592
select * from payapp..fee_buytime_Order where kid=1695
select * from payapp..fee_buytime_Order where kid=20938
select * from payapp..fee_buytime_Order where kid=5662
select * from payapp..fee_buytime_Order where kid=33124
select * from payapp..fee_buytime_Order where kid=6748
select * from payapp..fee_buytime_Order where kid=34437
select * from payapp..fee_buytime_Order where kid=33132

select * from BasicData..[user] where userid in(2140941,2034409)
select * from BasicData..[user_child] where userid in(2140941,2034409)