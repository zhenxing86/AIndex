托费:project=1,admintype=2 



http://payment.pc118.zgyey.com/
http://lsgspay.zgyey.com/kinpay/notice/?uid=685549&cdate=2016-11-01
http://lsgspay.zgyey.com/kinpay/noticeV2/?uid=685549&cdate=2018-04-01

http://sgs.pay.zgyey.com/kinpay/noticeV2?uid=685549&cdate=2016-11-01

select * from kmapp..km_user where kid=35029 and role=0
insert into PayApp..admin_user(kid,userid,admintype,project) values(35029,0,1,1)
insert into PayApp..admin_user(kid,userid,admintype,project) values(35029,0,1,1)

select *
--update a set project=1,admintype=2
 from PayApp..admin_user a 
  inner join basicdata..[user] u on u.userid=a.userid
   where a.kid=33858 and id=1
select * from payapp..kin_pay_notice where userid=2132560 and cdate='2016-10-01 00:00:00.000'
payapp..kin_pay_notice_GetModelEx 

--幼儿园的账号是 广州银行 6214633136901552900 黄妙欢
--http://sgs.pay.zgyey.com/kinpay/noticev2?uid=685549&cdate=2016-11-01
insert into FeeNotice(kid,kname,sendapp,sendweixin,remarks) values(29096,'福元贝尔幼儿园',1,0,N'<p class="title">温馨提示</p>
            <p>
            各位家长，您好！具体收费项目：<br />
            1、托费（按实收取）<br />
            2、膳费19天共342元<br />
            请家长按时刷卡交费，也可以支付宝或银行转帐。<br />
            感谢您的配合！
            </p>
			<p style="padding:1rem 0 .28rem .48rem; font-weight: bold;">幼儿园收款帐号信息如下：</p>
            <ul>
                <li>1、支付宝：<span class="color-a1">请联系中幼修改</span></li>
                <li>2、银行帐号：<span class="color-a1">请联系中幼修改</span></li>
			    <li>户名：<span class="color-a1">请联系中幼修改</span></li>
				<li>收款银行：<span class="color-a1">请联系中幼修改</span></li>
            </ul>
')


insert into FeeNotice(kid,kname,sendapp,sendweixin,remarks) values(33858,'广州市天河区新塘幼儿园',1,1,N'<p class="title">温馨提示</p>
			<p>
			各位家长，您好！幼儿园{Month}月份收费时间是{noticedesc}，具体收费项目：<br />
			1、托费（按实收取）<br />
			2、膳费22天共396元<br />
			请家长按时刷卡交费，也可以支付宝、微信支付或银行转帐。<br />
			感谢您的配合！
			</p>
			<p style="padding:1rem 0 .28rem .48rem; font-weight: bold;">幼儿园收款帐号信息如下：</p>
            <ul>
				<li>1、支付宝支付：<span class="color-a1">15360811312</span></li>
				<li>2、微信支付：<span class="color-a1">15360811312</span></li>
				<li>3、银行帐号：<span class="color-a1">622439910000399974</span></li>
				<li>户名：<span class="color-a1">宋小玲</span></li>
				<li>收款银行：<span class="color-a1">广州农村商业银行小新塘支行</span></li>
            </ul>
')




update f set remarks=N'<p class="title">通    知</p>
			<p>
			各位家长，你们好！幼儿园11月份收费时间是11月7日至9日（共3天），具体收费项目如下：<br />
			1、托费（按实收取）<br />
			2、膳费22天共396元，退11月6日秋游一天膳费，本月实收膳费21天共378元，<br />
			请家长按时刷卡交费，同时也支持支付宝、微信转帐和银行转帐。<br />
			感谢您的配合！
			</p>
			<p style="padding:1rem 0 .28rem .48rem; font-weight: bold;">幼儿园收款帐号信息如下：</p>
            <ul>
				<li>1、支付宝支付：<span class="color-a1">15360811312</span></li>
				<li>2、微信支付：<span class="color-a1">15360811312</span></li>
				<li>3、银行帐号：<span class="color-a1">622439910000399974</span></li>
				<li>户名：<span class="color-a1">宋小玲</span></li>
				<li>收款银行：<span class="color-a1">广州农村商业银行小新塘支行</span></li>
            </ul>
'
 from payapp..FeeNotice f
 where kid=33858

各位家长：
你们好！幼儿园11月份收费时间是11月7日至9日（共3天），具体收费项目如下：1、托费（按实收取），2、膳费22天共396元，退11月6日秋游一天膳费，本月实收膳费21天共378元，请家长按时刷卡交费，也可以支付宝、微信转帐、银行转帐。谢谢配合。

天河区新塘幼儿园
 2018年11月6日

 
 
select *
--update f set sendweixin=1
--delete 
from FeeNotice f where kid= 20675

