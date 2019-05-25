use basicdata
go


select  * from BasicData.dbo.kid_term where kid=14496      
select  * from BasicData.dbo.class_all where kid=14496 and term='2019-0'  --28      
select uca.* from basicdata..user_class_all uca      
inner join basicdata..[user] u on uca.userid=u.userid       
where kid= 14496 and term='2019-0'   --1466      

/*

delete from BasicData.dbo.kid_term where kid=14496 and term='2019-0'      

declare @date datetime=getdate()  
exec commonfun.dbo.SetCurTerm @kid=14496,@date=@date,@douserid=374,@del_leave =1  --0：不删除user_class_all表中离园的用户，1：删除user_class_all表中离园的用户  

14496]金碧湾幼儿园2018-2019 下学期

*/

select * from ossapp..users where name like '%颜%'
