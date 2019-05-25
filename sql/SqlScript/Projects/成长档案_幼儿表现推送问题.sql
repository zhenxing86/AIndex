
--[24071]广州金苗幼儿园 反馈昨天大一班的老师填写的家园联系册，家长收到的推送点击查看没有评语，但是在家园联系册进去查看第6周是有评
kmapp..[km_getPMHistoryMessages]    

select * from kmapp.dbo.push_message_history  where userid=867554  and adddate>='2016-10-14' and title = '【幼儿表现】'


http://m.jz.jylx.zgyey.com/Cell/Index?gbid=114303652&index=4

http://m.jz.jylx.zgyey.com?uid=867554
getgrowthbookv2 114303652


 select d.gbid, d.diaryid, CASE WHEN u.usertype = 0 then 0 else 1 end AuthorType, d.pagetplid, pc.title,d.crtdate,                          
     pc.TeaPoint, pc.TeaWord, pc.ParPoint, pc.ParWord                           
  FROM diary d                          
   inner join page_cell pc                          
    on pc.diaryid = d.diaryid                          
  LEFT JOIN BasicData..[user] u                          
   on u.userid = d.Author                          
  where d.gbid = 114303652                          
  order by pc.title     
  