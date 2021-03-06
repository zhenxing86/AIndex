USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[GetMainPageListByPage]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      Master谭      
-- Create date: 2013-12-3      
-- Description:     
-- Memo:    
GetMainPageListByPage 653612, 12511,1    
*/      
--      
CREATE PROC [dbo].[GetMainPageListByPage]      
 @userid int,      
 @kid int,      
 @page int         
AS      
BEGIN            
 SET NOCOUNT ON            
                 
Select Distinct type, Tag, TagValue, CrtDate, CAST(null as Int) status
  Into #MainPage
  From MainPageList
  Where userid = @userid AND kid = @kid and status = 1 

UPdate #MainPage Set status = b.status    
  From #MainPage a, SMS.dbo.sms_message_curmonth b    
  Where a.Tag = 0 and a.TagValue = b.smsid    
    
UPdate #MainPage Set status = b.status    
  From #MainPage a, KWebCMS.dbo.cms_content b    
  Where a.Tag = 1 and a.TagValue = b.contentid and b.deletetag = 1
    
Update #MainPage Set status = 1 Where Tag In(2, 3, 4)    

UPdate #MainPage Set status = b.deletetag    
  From #MainPage a, NGBApp.dbo.tea_UpPhoto b    
  Where a.Tag = 5 and a.TagValue = b.photoid    
    
UPdate #MainPage Set status = b.status    
  From #MainPage a, ClassApp.dbo.class_photos b    
  Where a.Tag = 6 and a.TagValue = b.photoid    
    
UPdate #MainPage Set status = b.deletetag    
  From #MainPage a, NGBApp.dbo.diary b    
  Where a.Tag = 7 and a.TagValue = b.diaryid    
    
UPdate #MainPage Set status = b.status    
  From #MainPage a, ClassApp.dbo.class_notice b    
  Where a.Tag = 8 and a.TagValue = b.noticeid    
    
UPdate #MainPage Set status = b.status    
  From #MainPage a, ClassApp.dbo.class_schedule b    
  Where a.Tag = 9 and a.TagValue = b.scheduleid    
    
Delete #MainPage Where status <> 1 or status is null  

CREATE TABLE #MainPageList(type int,Tag int,TagValue bigint,CrtDate datetime, con nvarchar(300), status int)          
 insert into #MainPageList(type, Tag, TagValue, CrtDate)          
  exec sp_GridViewByPager            
   @viewName = '#MainPage a',             --表名            
   @fieldName = ' type, Tag, TagValue, CrtDate ',      --查询字段            
   @keyName = 'CrtDate',       --索引字段            
   @pageSize = 10,                 --每页记录数            
   @pageNo = @page,                     --当前页            
   @orderString = ' CrtDate desc ',          --排序条件            
   @IsRecordTotal = 0,             --是否输出总记录条数            
   @IsRowNo = 0          

 update #MainPageList set con = sm.content          
  from #MainPageList mp           
  inner join SMS..sms_message_curmonth sm           
  on mp.TagValue = sm.smsid          
  WHERE mp.Tag = 0          
 update #MainPageList set con = '老师填写了幼儿表现'          
  from #MainPageList mp           
  WHERE mp.Tag = 2          
 update #MainPageList set con = '老师新上传了班级照片'          
  from #MainPageList mp           
  WHERE mp.Tag = 6          
 update #MainPageList set con = '老师新上传了在园剪影'          
  from #MainPageList mp           
  WHERE mp.Tag = 5          
 update #MainPageList set con = '老师填写了每月进步'          
  from #MainPageList mp           
  WHERE mp.Tag = 3          
 update #MainPageList set con = '老师填写了观察评价'          
  from #MainPageList mp           
  WHERE mp.Tag = 4          
 update #MainPageList set con = cc.title          
  from #MainPageList mp           
  inner join KWebCMS..cms_content cc           
  on mp.TagValue = cc.contentid          
  WHERE mp.Tag = 1          
         
 --班级公告        
 update #MainPageList set con = '[班级公告:]'+cc.title          
  from #MainPageList mp           
  inner join ClassApp..class_notice cc           
  on mp.TagValue = cc.noticeid          
  WHERE mp.Tag = 8        
        
 --教学安排        
 update #MainPageList set con = '[教学安排:]'+cc.title          
  from #MainPageList mp           
  inner join ClassApp..class_schedule cc           
  on mp.TagValue = cc.scheduleid          
  WHERE mp.Tag = 9        
          
 SELECT type, Tag, TagValue, CrtDate, con         
  from #MainPageList ORDER BY CrtDate desc          
             
 SELECT gbid, d.pagetplid, d.diaryid,           
    CASE WHEN u.usertype = 0 then 0 else 1 end AuthorType,           
    d.CrtDate, pp.ckey, pp.cvalue, pp.ctype, ISNULL(d.Src,0)Src,pt.tpltype,pt.tplsubtype                  
  FROM NGBApp..diary d               
   inner join NGBApp..PageTpl pt          
  on d.pagetplid = pt.pagetplid           
  INNER JOIN #MainPageList mp           
   on d.diaryid = mp.TagValue            
   inner join NGBApp..page_public pp              
   on pp.diaryid = d.diaryid              
  LEFT JOIN BasicData..[user] u              
   on u.userid = d.Author              
  where mp.Tag = 7           
  and mp.type = 3          
           
          
 DECLARE @TOP INT = 3          
 select mp.TagValue diaryid,ca1.Contents,ca1.name,ca2.cnt           
   from #MainPageList mp          
   cross apply(          
   select top(@TOP)c.Contents,u.name from NGBApp..Comment c           
    inner join BasicData..[user] u           
    on c.userid = u.userid           
    where c.diaryid = mp.TagValue order by c.CrtDate)ca1          
   cross apply(select SUM(1)cnt from NGBApp..Comment c where c.diaryid = mp.TagValue)ca2           
  where mp.Tag = 7          
   and mp.type = 3          
            
           
 select mp.TagValue diaryid,ca1.name,ca2.cnt           
 from #MainPageList mp          
  cross apply(          
  select top(@TOP)u.name from NGBApp..Nice n           
   inner join BasicData..[user] u           
   on n.userid = u.userid           
   where n.diaryid = mp.TagValue order by n.CrtDate)ca1          
  cross apply(select SUM(1)cnt from NGBApp..Nice c where c.diaryid = mp.TagValue)ca2          
            
  Select a.userid, a.msgtype, Replace(a.msgcon, '<br>', Char(13) + Char(10)) msgcon, a.crtdate, b.name, b.headpic, b.headpicupdate
    From [dbo].[FriendSMS] a, basicdata.dbo.[user] b
    Where a.Touserid = @userid and a.deletetag = 1 and a.IsRead = 0
      and a.userid = b.userid
           
END 




GO
