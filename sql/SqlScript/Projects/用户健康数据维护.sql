数据健康查询  
select top 100 * from LogData..ossapp_keylog where ID>199929 order by ID desc
select MAX(id) from LogData..ossapp_keylog 

select * from BasicData..[user] where account='13750992285'
select * from ossapp..addservice where userid =626908

李凯晟ys207    528887 
select * from BasicData..[user] where userid =528887   547798  528887 
select *From basicdata..user_class where userid =547798
select *From mcapp..cardinfo where userid =547798

select * from BasicData..[user] where userid=547798
select *From basicdata..leave_kindergarten where userid =547798
select *From basicdata..leave_user_class where userid =547798
select *From basicdata..leave_user_card where userid =547798
select *From basicdata..[user_del] where userid =547798

user_add_new_teacher  暂时将cardapp 注释了 

Select b.name From Syscomments a, sysobjects b Where TEXT Like '%cardinfo_temp%' and a.id = b.id
Select b.name From Syscomments a, sysobjects b Where TEXT Like '%user_class_history%' and a.id = b.id

select * from BasicData..department where kid=12511
--删除幼儿园门户的文章
select *from KWebCMS..cms_content 
where contentid=353341 and title like '预防手足口病，拥有健康%' 

Select * From KWebCMS..mh_content_content_relation p Where p.s_contentid in (353341)
--delete from KWebCMS..mh_content_content_relation  where s_contentid in (353341) and actiondate='2014-04-25 15:19:49.000'


  select * from BasicData..[user_child] where kid=12511 and account='jz1'  55906
  
  select * from mcapp..kindergarten where kid =12511    55906
  
  select * from mcapp..kindergarten where kid =12511 
  
  mc_sms_man_tea_GetList   






