USE [AndroidApp]
GO
/****** Object:  StoredProcedure [PushSMS]    Script Date: 2014/11/24 19:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [PushSMS]  
 @bgn date,  
 @end date,  
 @type int --1周，0月  
as  
begin  
  
--发送周期定义：发送周期（每周6，每月最后一天）  
--格式：本周、本月xxxxxx  
--幼儿园过滤条件：对已合作的的幼儿园才做以下分析数据的推送。（已合作园标记：ossapp..kinbaseinfo表中，收费状态为正常缴费）  
select kid into #kid from ossapp..kinbaseinfo where status = '正常缴费'  
  
--and_msg  
--and_msg_detail  
select DISTINCT s.siteid kid, s.appuserid userid   
into #userid  
from KWebCMS..site_user s  
inner join KWebCMS_Right.dbo.sac_user u on u.[user_id]=[UID] and s.appuserid is not null  
inner join KWebCMS_Right.dbo.sac_user_role r on r.[user_id]=u.[user_id]  
inner join KWebCMS_Right.dbo.sac_role l on l.role_id=r.role_id  
where l.role_name = '园长'  
and exists(select * from and_userinfo where userid = s.appuserid)  
  
declare @rtype varchar(50)  
set @rtype = '本' + CASE WHEN @type = 1 THEN '周' else '月' END  
--103 运营分析-入园分析 本月/周 入园人数{0}；  
;WITH CET AS  
(  
select ISNULL(NULLIF(u.kid,0),lk.kid)kid,   
    count(distinct u.userid)cnt   
 from basicdata..[user] u   
  left join basicdata..leave_kindergarten lk   
   on u.userid = lk.userid  
 where regdatetime >= @bgn  
  and regdatetime < @end  
  AND EXISTS(SELECT * FROM #kid WHERE kid = ISNULL(ISNULL(NULLIF(u.kid,0),lk.kid),0))   
 group by ISNULL(NULLIF(u.kid,0),lk.kid)   
)  
insert into and_msg_and_msg_detail_V(title, contents, push_type, sent_time, msg_code, sender, param, userid, tag, bgndate, enddate, typedate)      
 select '运营分析-入园分析' title, @rtype + '入园人数' + CAST(cnt AS VARCHAR(10)) contents,   
     1 push_type, GETDATE() sent_time, 100 msg_code, '中国幼儿园门户' sender,   
     CONVERT(VARCHAR(10),GETDATE(),120) +'A103a' param, u.userid, c.kid, @bgn, @end, @type  
 from cet c inner join #userid u  
  on c.kid = u.kid   
  
--104 运营分析-离园分析 本月/周 离园人数{0}。  
;WITH CET AS  
(  
select kid, count(distinct userid)cnt   
 from basicdata..leave_kindergarten   
 where outtime >= @bgn   
  and outtime < @end  
 group by kid   
)  
insert into and_msg_and_msg_detail_V(title, contents, push_type, sent_time, msg_code, sender, param, userid, tag, bgndate, enddate, typedate)      
 select '运营分析-离园分析' title, @rtype + '离园人数' + CAST(cnt AS VARCHAR(10)) contents,   
     1 push_type, GETDATE() sent_time, 100 msg_code, '中国幼儿园门户' sender,   
     CONVERT(VARCHAR(10),GETDATE(),120) +'A104a' param, u.userid, c.kid, @bgn, @end, @type  
 from cet c inner join #userid u  
  on c.kid = u.kid   
 WHERE EXISTS(SELECT * FROM #kid WHERE kid = c.kid)   
  
--101  运营分析-班级统计  
--班级主页内容活跃度 本月/周新增班级公告{0}篇，教学安排{}篇，上传班级照片{}张，班级主页访问排行：小一班：2918人次，小二班：1929人次。  
--数据库存与表说明：  
--公告：  
--教学安排：classapp..class_schedule  
--班级照片：classapp..class_photo  
--访问排行：classapp..class_config这个表可以考滤合并放到basicdata..class表中  
  
--CREATE TABLE #T(kid int, cnt varchar(5000),rowno int)  
--本月/周新增班级公告{0}篇  
--insert   
select kid, cast('班级公告'+CAST(count(1) AS VARCHAR(10))+'篇' as varchar(5000)) contents, 1 rowno   
into #T  
 from ClassApp..class_notice   
 where createdatetime >= @bgn   
  and createdatetime < @end  
 group by kid   
union   
--教学安排{}篇  
select kid, '教学安排'+CAST(count(1) AS VARCHAR(10))+'篇' contents, 2 rowno   
 from ClassApp..class_schedule   
 where createdatetime >= @bgn   
  and createdatetime < @end  
 group by kid   
union   
--上传班级照片{}张   
Select ca.kid, '上传班级照片'+CAST(count(1) AS VARCHAR(10))+'张' contents, 3 rowno   
  from  ClassApp..class_album ca   
  inner join ClassApp..class_photos cp   
   on ca.albumid = cp.albumid   
   and cp.status = 1   
   and ca.status = 1   
 where cp.uploaddatetime >= @bgn   
  and cp.uploaddatetime < @end     
  Group by ca.kid   
  
CREATE CLUSTERED index idx_kid_cnt on #T(kid,rowno)  
  
Select kid, '新增' + CommonFun.dbo.sp_GetSumStr(contents+'，') as contents, 1 rowno      
into #T1        
  from #T   
  Group by kid      
union    
--班级主页访问排行：小一班：2918人次，小二班：1929人次  
Select k.kid, '班级主页访问排行 ' + CommonFun.dbo.sp_GetSumStr(ca.cname + '：'+CAST(CA.accessnum AS VARCHAR(10))+'人次，') as contents, 2 rowno            
  from #kid k  
  cross apply(  
   select top(3) c.cname, cc.accessnum   
   from  ClassApp..class_config cc   
   inner join BasicData..class c   
    on cc.cid = c.cid   
    and c.deletetag = 1   
    and c.grade <> 38  
   where c.kid = k.kid  
    and ISNULL(cc.accessnum,0) <> 0  
   ORDER BY cc.accessnum desc  
   )ca  
  Group by k.kid    
  
CREATE CLUSTERED index idx_kid_cnt on #T1(kid,rowno)    
  
;with cet as  
(  
Select kid, @rtype + CommonFun.dbo.sp_GetSumStr(contents) as contents, 1 rowno      
  from #T1   
  Group by kid      
)  
insert into and_msg_and_msg_detail_V(title, contents, push_type, sent_time, msg_code, sender, param, userid, tag, bgndate, enddate, typedate)      
 select '运营分析-班级统计' title, LEFT(c.contents,LEN(c.contents)-1) +'。',   
     1 push_type, GETDATE() sent_time, 400 msg_code, '中国幼儿园门户' sender,   
     CONVERT(VARCHAR(10),GETDATE(),120) +'A' param, u.userid, c.kid, @bgn, @end, @type  
  from cet c inner join #userid u  
   on c.kid = u.kid   
  WHERE EXISTS(SELECT * FROM #kid WHERE kid = c.kid)   
--教学管理  
select u.kid,tt.booktype,COUNT(1)cnt   
into #T2  
 from EBook..TNB_TeachingNotebook tt   
  inner join BasicData..[user] u on tt.userid = u.userid and u.kid <> 0  
  inner join Ebook..TNB_chapter tc   
   on tt.teachingnotebookid = tc.teachingnotebookid and tc.deletetag = 1
   and tt.booktype in(0,1,2,3)  and tc.deletetag = 1
 where tc.createdate >= convert(varchar(10),@bgn,120)   
  and tc.createdate < convert(varchar(10),@end,120)    
  and EXISTS(SELECT * FROM #kid WHERE kid = u.kid)    
  Group by u.kid,tt.booktype   
  
insert into and_msg_and_msg_detail_V(title, contents, push_type, sent_time, msg_code, sender, param, userid, tag, bgndate, enddate, typedate)      
 select '教学管理-电子教案' title, @rtype + '新增电子教案' + CAST(cnt AS VARCHAR(10))+'篇。' contents,   
     1 push_type, GETDATE() sent_time, 200 msg_code, '中国幼儿园门户' sender,   
     CONVERT(VARCHAR(10),GETDATE(),120) +'A201a' param, u.userid, c.kid, @bgn, @end, @type  
 from #T2 c inner join #userid u  
  on c.kid = u.kid   
  AND c.booktype = 0  
insert into and_msg_and_msg_detail_V(title, contents, push_type, sent_time, msg_code, sender, param, userid, tag, bgndate, enddate, typedate)      
 select '教学管理-老师随笔' title, @rtype + '新增老师随笔' + CAST(cnt AS VARCHAR(10))+'篇。' contents,   
     1 push_type, GETDATE() sent_time, 200 msg_code, '中国幼儿园门户' sender,   
     CONVERT(VARCHAR(10),GETDATE(),120) +'A202a' param, u.userid, c.kid, @bgn, @end, @type  
 from #T2 c inner join #userid u  
  on c.kid = u.kid   
  AND c.booktype = 1  
insert into and_msg_and_msg_detail_V(title, contents, push_type, sent_time, msg_code, sender, param, userid, tag, bgndate, enddate, typedate)      
 select '教学管理-教学反思' title, @rtype + '新增教学反思' + CAST(cnt AS VARCHAR(10))+'篇。' contents,   
     1 push_type, GETDATE() sent_time, 200 msg_code, '中国幼儿园门户' sender,   
     CONVERT(VARCHAR(10),GETDATE(),120) +'A203a' param, u.userid, c.kid, @bgn, @end, @type  
 from #T2 c inner join #userid u  
  on c.kid = u.kid   
  AND c.booktype = 2  
insert into and_msg_and_msg_detail_V(title, contents, push_type, sent_time, msg_code, sender, param, userid, tag, bgndate, enddate, typedate)      
 select '教学管理-观察记录' title, @rtype + '新增观察记录' + CAST(cnt AS VARCHAR(10))+'篇。' contents,   
     1 push_type, GETDATE() sent_time, 200 msg_code, '中国幼儿园门户' sender,   
     CONVERT(VARCHAR(10),GETDATE(),120) +'A204a' param, u.userid, c.kid, @bgn, @end, @type  
 from #T2 c inner join #userid u  
  on c.kid = u.kid   
  AND c.booktype = 3  
  
--400  消息中心  
--老师活跃 本周/本月｛某某｝｛｝篇。注：排前三的老师列出来。  
  
   select u.kid,u.userid,u.name,COUNT(1)cnt   
   into #T4  
    from EBook..TNB_TeachingNotebook tt   
     inner join Ebook..TNB_chapter tc   
      on tt.teachingnotebookid = tc.teachingnotebookid  
      and tt.booktype = 0 and tc.deletetag = 1
     inner join BasicData..[user] u on tt.userid = u.userid  
    where tc.createdate >= convert(varchar(10),@bgn,120)   
     and tc.createdate <  convert(varchar(10),@end,120)  
    GROUP BY u.kid,u.userid,u.name  
    ORDER BY cnt DESC    
    
;WITH CET AS  
(  
select k.kid, CommonFun.dbo.sp_GetSumStr(ca.name + '老师发表教案 '+CAST(CA.cnt AS VARCHAR(10))+'篇，') as contents           
  from #kid k  
  cross apply(  
   select top(3)userid,name,cnt   
    from #T4  
    where k.kid = kid   
    ORDER BY cnt DESC  
   )ca  
  Group by k.kid    
)  
insert into and_msg_and_msg_detail_V(title, contents, push_type, sent_time, msg_code, sender, param, userid, tag, bgndate, enddate, typedate)      
 select '消息中心-老师活跃' title,  c.contents,   
     1 push_type, GETDATE() sent_time, 400 msg_code, '中国幼儿园门户' sender,   
     CONVERT(VARCHAR(10),GETDATE(),120) +'A' param, u.userid, c.kid, @bgn, @end, @type  
 from cet c inner join #userid u  
  on c.kid = u.kid   
  
--400  消息中心  
----幼儿表现 本周/本月幼儿表现填写情况：某某班：已填｛｝人，未填{}人  
select kid   
 into #kidmonth   
 from #kid k  
 where exists(select * from NGBApp..ModuleSet where celltype = 4 AND term = HealthApp.dbo.getTerm_New(0,getdate()) and k.kid = kid)  
;with cet as  
(  
 select kid from #kid  
 except   
 select kid from #kidmonth  
)  
 select kid   
  into #kidweek   
  from cet   
 if @type = 1  
 begin  
    
;WITH CET1 AS  
(  
select k.kid, uc.cid, uc.cname, COUNT(1)cnt  
   from #kidweek k   
    inner join NGBApp..growthbook g on k.kid = g.kid  
    inner join BasicData..[User_Child] uc on uc.userid = g.userid  
    inner join NGBApp..Diary d on g.gbid = d.gbid   
    inner join NGBApp..page_cell pc on d.diaryid = pc.diaryid    
   where d.CrtDate >= @bgn   
    and d.CrtDate < @end   
   GROUP BY k.kid, uc.cid, uc.cname    
), CET AS  
(  
select kid, '幼儿表现填写情况：' + CommonFun.dbo.sp_GetSumStr(c.cname + '：已填 '+CAST(C.cnt AS VARCHAR(10))+'人，') as contents   
   from CET1 c  
   GROUP BY kid  
)  
insert into and_msg_and_msg_detail_V(title, contents, push_type, sent_time, msg_code, sender, param, userid, tag, bgndate, enddate, typedate)      
 select '消息中心-幼儿表现' title, @rtype + c.contents,   
     1 push_type, GETDATE() sent_time, 400 msg_code, '中国幼儿园门户' sender,   
     CONVERT(VARCHAR(10),GETDATE(),120) +'A' param, u.userid, c.kid, @bgn, @end, @type  
 from cet c inner join #userid u  
  on c.kid = u.kid    
        
 end  
 ELSE IF @type = 0  
 BEGIN  
  ;WITH CET1 AS  
  (  
  select k.kid, uc.cid, uc.cname, COUNT(1)cnt  
   from #kidmonth k   
    inner join NGBApp..growthbook gb on k.kid = gb.kid  
    inner join BasicData..[User_Child] uc on uc.userid = gb.userid  
    inner join NGBApp..Diary d on gb.gbid = d.gbid   
    inner join NGBApp..page_cell pc on d.diaryid = pc.diaryid    
   where d.CrtDate >= @bgn   
    and d.CrtDate < @end   
   GROUP BY k.kid, uc.cid, uc.cname    
  ), CET AS  
  (  
  select kid, '幼儿表现填写情况：' + CommonFun.dbo.sp_GetSumStr(c.cname + '：已填 '+CAST(C.cnt AS VARCHAR(10))+'人，') as contents   
     from CET1 c  
     GROUP BY kid  
  )  
  insert into and_msg_and_msg_detail_V(title, contents, push_type, sent_time, msg_code, sender, param, userid, tag, bgndate, enddate, typedate)      
   select '消息中心-幼儿表现' title, @rtype + c.contents,   
       1 push_type, GETDATE() sent_time, 400 msg_code, '中国幼儿园门户' sender,   
       CONVERT(VARCHAR(10),GETDATE(),120) +'A' param, u.userid, c.kid, @bgn, @end, @type  
   from cet c inner join #userid u  
    on c.kid = u.kid    
    
  
  ;WITH CET1 AS  
  (  
  select k.kid,uc.cid, uc.cname, COUNT(1)cnt  
   from #kid k   
    inner join NGBApp..growthbook gb on k.kid = gb.kid  
    inner join BasicData..[User_Child] uc on uc.userid = gb.userid  
    inner join NGBApp..Diary d on gb.gbid = d.gbid   
    inner join NGBApp.. page_month_sec pm on d.diaryid = pm.diaryid    
   where d.CrtDate >= @bgn   
    and d.CrtDate < @end   
   GROUP BY k.kid, uc.cid, uc.cname    
  ), CET AS  
  (  
  select kid, '每月进步填写情况：' + CommonFun.dbo.sp_GetSumStr(c.cname + '：已填 '+CAST(C.cnt AS VARCHAR(10))+'人，') as contents   
     from CET1 c  
     GROUP BY kid  
  )  
  insert into and_msg_and_msg_detail_V(title, contents, push_type, sent_time, msg_code, sender, param, userid, tag, bgndate, enddate, typedate)      
   select '消息中心-每月进步' title, @rtype + c.contents,   
       1 push_type, GETDATE() sent_time, 400 msg_code, '中国幼儿园门户' sender,   
       CONVERT(VARCHAR(10),GETDATE(),120) +'A' param, u.userid, c.kid, @bgn, @end, @type  
   from cet c inner join #userid u  
    on c.kid = u.kid      
   
  ;WITH CET1 AS  
  (  
  select k.kid, uc.cid, uc.cname, COUNT(1)cnt  
   from #kid k   
    inner join NGBApp..growthbook gb on k.kid = gb.kid  
    inner join BasicData..[User_Child] uc on uc.userid = gb.userid  
    inner join NGBApp..Diary d on gb.gbid = d.gbid   
    inner join NGBApp.. page_month_evl pm on d.diaryid = pm.diaryid    
   where d.CrtDate >= @bgn   
    and d.CrtDate < @end   
   GROUP BY k.kid, uc.cid, uc.cname   
  ), CET AS  
  (  
  select kid, '观察评价填写情况：' + CommonFun.dbo.sp_GetSumStr(c.cname + '：已填 '+CAST(C.cnt AS VARCHAR(10))+'人，') as contents   
     from CET1 c  
     GROUP BY kid  
  )  
  insert into and_msg_and_msg_detail_V(title, contents, push_type, sent_time, msg_code, sender, param, userid, tag, bgndate, enddate, typedate)      
   select '消息中心-观察评价' title, @rtype + c.contents,   
       1 push_type, GETDATE() sent_time, 400 msg_code, '中国幼儿园门户' sender,   
       CONVERT(VARCHAR(10),GETDATE(),120) +'A' param, u.userid, c.kid, @bgn, @end, @type  
   from cet c inner join #userid u  
    on c.kid = u.kid         
 END      
 ;WITH CET1 AS  
 (  
  select k.kid, uc.cname, COUNT(1)cnt  
   from  #kid k   
    inner join NGBApp..growthbook gb on k.kid = gb.kid  
    inner join BasicData..[User_Child] uc on uc.userid = gb.userid  
    inner join NGBApp..tea_UpPhoto d on gb.gbid = d.gbid   
   where d.updatetime >= @bgn   
    and d.updatetime < @end  
    and d.deletetag = 1  
   GROUP BY k.kid, uc.cname   
 ), CET AS  
 (  
 select kid, '在园影像上传照片情况：' + CommonFun.dbo.sp_GetSumStr(c.cname + '上传 '+CAST(C.cnt AS VARCHAR(10))+'张照片，') as contents   
    from CET1 c  
    GROUP BY kid  
 )  
 insert into and_msg_and_msg_detail_V(title, contents, push_type, sent_time, msg_code, sender, param, userid, tag, bgndate, enddate, typedate)      
  select '消息中心-在园影像' title, @rtype + c.contents,   
      1 push_type, GETDATE() sent_time, 400 msg_code, '中国幼儿园门户' sender,   
      CONVERT(VARCHAR(10),GETDATE(),120) +'A' param, u.userid, c.kid, @bgn, @end, @type  
  from cet c inner join #userid u  
   on c.kid = u.kid      
     
      
 /*  
  
 300 保育分析  
 --保育分析 今天的晨检总体情况描述，出勤报告，异常情况  
  
 400  消息中心  
  
 --每月进步 本月每月进步填写情况：某某班：已填｛｝人，未填{}人  
 --观察评价 本月观察评价填写情况：某某班：已填｛｝人，未填{}人  
 --在园影像 本周/本月在园影像上传照片情况：某某班上传{}张照片  
 */  
 --NGBApp..tea_UpPhoto  
  
 ;with cet as  
 (  
 select userid,  
 ROW_NUMBER()over(partition by userid,convert(varchar(10),logindatetime,120) order by logindatetime)rowno   
 from applogs..log_login  
 where logindatetime >= @bgn  
   and logindatetime < @end  
 )  
 select userid   
  into #T3   
  from cet   
  where rowno = 1  
  
 ;with cet as  
 (  
 select u.kid, COUNT(case when u.usertype = 0 then 1 else null end)cntC, COUNT(case when u.usertype > 0 then 1 else null end)cntT   
  from #T3 t   
   inner join BasicData..[user] u on t.userid = u.userid    
  WHERE EXISTS(SELECT * FROM #kid WHERE kid = u.kid)   
  GROUP BY u.kid  
 )  
 insert into and_msg_and_msg_detail_V(title, contents, push_type, sent_time, msg_code, sender, param, userid, tag, bgndate, enddate, typedate)      
  select '运营分析-网站统计' title,   
      @rtype + '家长登录网站 ' + CAST(cntC AS VARCHAR(10))   
       +'人次，老师登录网站 ' + CAST(cntT AS VARCHAR(10)) +'人次。' contents,   
      1 push_type, GETDATE() sent_time, 400 msg_code, '中国幼儿园门户' sender,   
      CONVERT(VARCHAR(10),GETDATE(),120) +'A' param, u.userid, c.kid, @bgn, @end, @type  
  from cet c inner join #userid u on c.kid = u.kid  
    
 end  
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自动初始化推送使用，监控各个地方，寻找推送资源' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'PushSMS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'PushSMS', @level2type=N'PARAMETER',@level2name=N'@bgn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'PushSMS', @level2type=N'PARAMETER',@level2name=N'@end'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0是月，1是周' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'PushSMS', @level2type=N'PARAMETER',@level2name=N'@type'
GO
