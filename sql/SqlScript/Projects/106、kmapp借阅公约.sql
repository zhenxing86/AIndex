

;with cet as(
 select col kid from CommonFun.dbo.f_split('1897',',')t
)
insert into AtsApp..set_borrow_time(kid,gradeid,gradename,week,weekname,ftime,ltime,orderby,typeid,deletetag)
select c.kid,gradeid,gradename,week,weekname,ftime,ltime,orderby,typeid,deletetag
 from AtsApp..set_borrow_time h
  cross join cet c 
   where h.kid=-1 and not exists( select 1 from AtsApp..set_borrow_time hm where hm.kid=c.kid)





--修改阅读公约
select  * 
--update m set convention = '<div class="jygy">     <p class="tips"><img src="../../Content/images/gh.png" width="20px" style=" margin-right:5px;"  /><span class="t_tx">家长如需借书，请办理借阅证</span></p>        <ul>            <li>            <p class="sum">1</p>            <p class=                    "title">借阅数量</p>            <p class="tx">每周可凭证从绘本馆借阅一次，每次可借2本；</p>            </li>            <li>            <p class="sum">2</p>            <p class="title">借阅服务费</p>            <p class="tx">借阅服务费100元/半学期（用于更新和补充新书及日常图书管理）。</p>                          </li>            <li>            <p class="sum">3</p>            <p class="title">借阅时间</p>            <p class="tx">为保证图书的流动性，借阅时间最长不超过2周，请及时归还；</p>            </li>            <li>            <p class="sum">4</p>            <p class="tit                    le">多媒体数字图书馆</p>            <p class="tx">办理借阅证后，可免费开通多媒体数字图书馆。每个学期配套50本多媒体数字童书和9大领域思维训练课程。</p>            </li>            <li>            <p class="sum">5</p>            <p class="title">借还规则</p>            <p class="tx">借阅前请先归还上次借书；</p>            </li                    >            <li>            <p class="sum">6</p>            <p class="title">遗失或损坏</p>            <p class="tx">爱护图书是美德。如图书遗失或损坏(只限页面严重破损或缺页，轻微磨损无妨，建议自行修补)，请购买新书或按价赔偿；</p>            </li>            <li>            <p class="sum">7</p>            <p cla                    ss="title">推荐书单</p>            <p class="tx">根据您孩子的年龄特点，【我的书单】为Ta每月推荐适宜好书，建议家长根据推荐书单有针对性借阅。</p>            </li>        </ul>    </div>'
from atsapp.dbo.set_config_model m where kid=32524

--修改支付里的显示	payapp..sgs_GetUserFeeInfo
select  * 
--update m set expires=2
from payapp.dbo.fees m where kid=12511  


select * from payapp..fees where kid=31717
select * from payapp..fees where fee_id=150

update payapp..fees set fee_money=100 where fee_id=150