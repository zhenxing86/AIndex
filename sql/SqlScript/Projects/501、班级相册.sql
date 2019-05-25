


--麻烦查一下28603小小二班这几个相册里面的照片是被谁删除的。


select * from ClassApp..class_album where kid=28603 and classid=135814
select * from ClassApp..class_album where kid=28603 and classid=148808
select * from ClassApp..class_album where kid=28603 and classid=122387


select * from ClassApp..class_photos where kid=28603 and cid=135814
select * from ClassApp..class_photos where kid=28603 and cid=148808
select * from ClassApp..class_photos where kid=28603 and cid=122387

select * from basicdata..class where kid=28603
select * from basicdata..class where kid=28603

select *
from applogs..class_log
 where actionuserid=@actionuserid   --操作人
  and actiontypeid=@actiontypeid    --类型
   and actionobjectid=@actionobjectid   --主键id

select *
from applogs..class_log l
 inner join BasicData..[user] u on l.actionuserid=u.userid and l.classid in(135814,148808,122387)
 order by l.actionid

--135814,148808,122387


