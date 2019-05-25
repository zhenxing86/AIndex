
-------------------------借书、还书时间设置---------------------------

--31991设置为待定
use AtsApp
go

insert into set_borrow_time(kid,gradeid,gradename,week,weekname,ftime,ltime,orderby,typeid,deletetag)
select 31446,gradeid,gradename,week,weekname,ftime,ltime,orderby,typeid,deletetag
 from set_borrow_time  where kid=31991
 



-------------------------价钱及还书时长设置---------------------------
use AtsApp
go
declare 
 @kid int =31446,    
 @book_money nvarchar(50)='200',    
 @book_duration nvarchar(50)='2'     
   
BEGIN    
    
    
declare @val varchar(3000)    
set @val='<div class="jygy">     <p class="tips"><img src="../../Content/images/gh.png" width="20px" style=" margin-right:5px;"  /><span class="t_tx">家长如需借书，请办理借阅证</span></p>        <ul>            <li>            <p class="sum">1</p>            <p class=
  
"title">借阅数量</p>            <p class="tx">每周可凭证从绘本馆借阅一次，每次可借2本；</p>            </li>            <li>            <p class="sum">2</p>            <p class="title">借阅服务费</p>            <p class="tx">借阅服务费'+@book_money+'元/学期（用于更新和补充新书及日常图书管理）。</p>            
  
</li>            <li>            <p class="sum">3</p>            <p class="title">借阅时间</p>            <p class="tx">为保证图书的流动性，借阅时间最长不超过'+@book_duration+'周，请及时归还；</p>            </li>            <li>            <p class="sum">4</p>            <p class="tit
  
le">多媒体数字图书馆</p>            <p class="tx">办理借阅证后，可免费开通多媒体数字图书馆。每个学期配套50本多媒体数字童书和9大领域思维训练课程。</p>            </li>            <li>            <p class="sum">5</p>            <p class="title">借还规则</p>            <p class="tx">借阅前请先归还上次借书；</p>            </li
  
>            <li>            <p class="sum">6</p>            <p class="title">遗失或损坏</p>            <p class="tx">爱护图书是美德。如图书遗失或损坏(只限页面严重破损或缺页，轻微磨损无妨，建议自行修补)，请购买新书或按价赔偿；</p>            </li>            <li>            <p class="sum">7</p>            <p cla
  
ss="title">推荐书单</p>            <p class="tx">根据您孩子的年龄特点，【我的书单】为Ta每月推荐适宜好书，建议家长根据推荐书单有针对性借阅。</p>            </li>        </ul>    </div>'    
    
if(exists(select * from dbo.set_config_model where kid=@kid))    
begin    
update dbo.set_config_model set convention=@val where kid=@kid    
end    
else     
begin    
insert into set_config_model(kid,convention)    
values (@kid,@val)    
end    
    
    
END
GO
-------------------------------------END------------------------------------------------


select 1 from blogapp..permissionsetting where kid=20759 and ptype=109              
select * from payapp..[user_fees] where kid=20759
select * from payapp..[sgs_pay_record] where kid=20759 and status=1 and crtdate>=''
select * from ossapp..[addservice] where uid=1472258 
select * from ossapp..[addservice_log] where uid=1472258


34148]广州市海珠区保利红棉幼儿园保利分园，[34147]广州市海珠区保利红棉幼儿园红棉总园，1.借阅服务费用： 150元/人/学期。
2.缴费方式：登陆时光树APP线上缴费（登陆方法见背面）
3.缴费期限： 2016年9月28日- 2016年10月15日。以后每学期借阅证办理时间：为开学的第一个月内，错过办理时间的请在下一个办理时间内办理。


declare @fee_kid int=32986,@fee_money float=240,@pay_bgndate datetime='2016-09-28',@pay_enddate datetime='2016-09-28'
insert into payapp..fees([from],kid,fee_name,fee_des,expires,fee_money,
deletetag,feetype,expiresType,expiresRemark,expiresenddate,fee_kid,pay_bgndate,pay_enddate)
--declare @fee_kid int=32986,@fee_money float=240,@pay_bgndate datetime='2016-09-28',@pay_enddate datetime='2016-09-28'
select 'WX_JSAPI',0,fee_name,'' fee_des,expires,@fee_money fee_money,
deletetag,feetype,expiresType,expiresRemark,'2017-03-01 23:59:59' expiresenddate,@fee_kid fee_kid,@pay_bgndate pay_bgndate,@pay_enddate  pay_enddate
 from payapp..fees where fee_id=170


[25834]沙富童和幼儿园，150元/学期，有效期至2017年9月1日。麻烦配置微信支付二维码，谢谢
32986   深圳市盐田区国际金宝园 借阅费 240元  有效期到2017/3/1号

select *
--update f set pay_bgndate='2016-09-26',pay_enddate='2016-10-10'
--update f set fee_money=100
  from payapp..fees f where fee_kid=32986


 --二维码链接： http://payweixin.pc118.zgyey.com/sgspay/ProductPageV5.aspx?kid=25834 

 --强制需要绑定手机号
http://payweixin.pc118.zgyey.com/sgspay/ProductPageV5.aspx?kid=32986 
 
 --不强制绑定手机号，（要输入姓名）
http://payweixin.pc118.zgyey.com/sgspay/ProductPageV6.aspx?kid=34022 
 
 select * from basicdata..[user] where userid=2175900
 
 select * from PayApp..sgs_pay_record where userid=25834


select *
--update u set mobile='13632432093'
 from BasicData..[user] u where userid =1997886




http://payweixin.pc118.zgyey.com/sgspay/ProductPageV5.aspx?kid=24082 


http://payweixin.pc118.zgyey.com/sgspay/ProductVideo.aspx?kid=24082&userid=1949969&feetype=2 


select * from basicdata..user_child where kid=24082 

