use SqlAgentDB
go 
          
/*                  
-- Author:      Master谭                  
-- Create date: 2013-07-15                  
-- Description:                   
-- Memo:                    
*/                  
alter PROC [dbo].[init_stu_mc_day]                  
AS                  
BEGIN                  
 SET NOCOUNT ON                   
       
 Declare @guid Varchar(50) = Newid()      
 Insert Into [SqlAgentDB].dbo.init_stu_mc_day_exec_time([guid], point, dt) Values(@guid, 1, Getdate())      
      
 INSERT INTO mcapp..stu_mc_day_raw(stuid, card, cdate, tw, zz, ta, toe, devid, gunid, kid, Status, adate)                  
 SELECT sm.teaid, sm.card, sm.cdate, 0, '' zz, 0, 0, sm.devid, sm.gunid, sm.kid, 0, sm.adate                     
   FROM mcapp..tea_at_day sm                  
    inner join mcapp..cardinfo c                   
     on sm.card = c.cardno                        
      and c.CardType in(0,1)                  
      inner join BasicData..[user] u                  
      on c.userid = u.userid                  
      and u.usertype = 0                  
   where sm.ctype is null                  
                     
 UPDATE mcapp..tea_at_day                   
  SET ctype = 1                   
                   
 --IC卡 IC卡不同幼儿园卡号唯一                  
 SELECT sm.ID, c.userid stuid, sm.card, sm.cdate, sm.tw,                   
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(sm.zz,'10','A'),',0',''),'0,',''),'0',''),'A','10'),',,',',') zz,                   
    sm.ta, sm.toe, sm.devid, sm.gunid, c.kid, sm.Status, sm.adate, sm.sendtime,                   
    case when u.usertype = 0 then 0 else 1 end usertype_3EF5E8E0                  
  INTO #stu_mc_day_raw                  
   FROM mcapp..stu_mc_day_raw sm                  
   inner join mcapp..cardinfo_V c                   
    on sm.card = c.cardno                  
    and c.CardType in(0,1)                  
   inner join BasicData..[user] u                  
    on c.userid = u.userid                  
   where sm.status = 0                   
 --ID卡 ID卡不同幼儿园卡号会有重复                   
 INSERT INTO #stu_mc_day_raw                  
 SELECT sm.ID, c.userid stuid, sm.card, sm.cdate, sm.tw,                   
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(sm.zz,'10','A'),',0',''),'0,',''),'0',''),'A','10'),',,',',') zz,                   
    sm.ta, sm.toe, sm.devid, sm.gunid, c.kid, sm.Status, sm.adate, sm.sendtime,                   
    case when u.usertype = 0 then 0 else 1 end usertype_3EF5E8E0                     
   FROM mcapp..stu_mc_day_raw sm                  
   inner join mcapp..cardinfo_V c                   
    on sm.card = c.cardno                  
    AND sm.kid = c.kid                  
    and c.CardType = 2                  
   inner join BasicData..[user] u                  
    on c.userid = u.userid                  
   where sm.status = 0                   
          print 'no mc data'                
 IF not exists(select * from #stu_mc_day_raw) RETURN                  
      
 Insert Into [SqlAgentDB].dbo.init_stu_mc_day_exec_time([guid], point, dt) Values(@guid, 2, Getdate())      
      
  print 'have mc data'                
 ;WITH CET AS                  
 (                  
  select *, ROW_NUMBER()OVER(PARTITION BY stuid,CONVERT(VARCHAR(10),cdate,120)                   
                ORDER BY case when ISNULL(zz,'')<>'' THEN 0 ELSE 1 END,cdate desc) rowno                   
   from #stu_mc_day_raw sm                   
   where ISNUMERIC(tw) = 1                  
    and usertype_3EF5E8E0 = 0                  
 )                  
  select ID, stuid, card, cdate, tw,                    
      zz, adate, devid, gunid, kid, Status                  
   into #T                  
   from CET                   
   WHERE rowno = 1                  
         
   ;MERGE mcapp..stu_mc_day AS sm                  
   USING (select * from #T                  
   ) t                  
   ON (sm.CheckDate = CONVERT(VARCHAR(10),t.cdate,120) and t.stuid = sm.stuid and ISNULL(sm.ftype,0) = 1)     
   WHEN MATCHED AND sm.cdate < t.cdate THEN  --更新已处理的ftype=1                  
   UPDATE SET                   
    sm.tw = case when ISNUMERIC(t.tw) = 1 and cast(t.tw as decimal(4, 2)) >0 then t.tw else sm.tw end,                  
    sm.zz = case when ISNULL(t.zz,'')<>'' then t.zz else sm.zz end,                  
    sm.card = t.card,                  
    --sm.cdate = t.cdate,                  
    --sm.adate = t.adate,                  
    sm.devid = t.devid,                  
    sm.gunid = t.gunid           
                     
   ;MERGE mcapp..stu_mc_day AS sm                 
   USING (select * from #T                    
   ) t                    
   ON (sm.CheckDate = CONVERT(VARCHAR(10),t.cdate,120) and t.stuid = sm.stuid)                    
   WHEN MATCHED AND ISNULL(sm.ftype,0) = 0 and sm.cdate < t.cdate THEN -- 只更新未发家长短信的,并且当作同一批                    
   UPDATE SET                     
    sm.tw = case when ISNUMERIC(t.tw) = 1 and cast(t.tw as decimal(4, 2)) >0 then t.tw else sm.tw end,                    
    sm.zz = case when ISNUMERIC(t.tw) = 1 and cast(t.tw as decimal(4, 2)) >0 then t.zz else sm.zz end,           
    sm.card = t.card,                    
    --sm.cdate = t.cdate,                    
    sm.adate = t.adate,                    
    sm.devid = t.devid,                    
    sm.gunid = t.gunid,        
    sm.sms_tw= case when ISNUMERIC(t.tw) = 1 and cast(t.tw as decimal(4, 2)) >0 then t.tw else sm.tw end,          
    sm.sms_zz = case when ISNUMERIC(t.tw) = 1 and cast(t.tw as decimal(4, 2)) >0 then t.zz else sm.zz end           
   WHEN NOT MATCHED and ISNULL(t.stuid,'') <> '' THEN                    
   INSERT (CheckDate, kid, stuid, card, cdate, tw, zz, adate, devid, gunid,sms_tw,sms_zz)   --增加发送短信时取到的体温、症状                 
   VALUES (t.cdate, t.kid, t.stuid, t.card, t.cdate, t.tw, t.zz, t.adate, t.devid, t.gunid,t.tw,t.zz);         
                  
  INSERT INTO mcapp..stu_at_day(stuid, card, cdate, adate, devid, gunid, kid)               
   SELECT stuid, card, cdate, adate, devid, gunid, kid                   
    FROM #stu_mc_day_raw                   
    WHERE usertype_3EF5E8E0 = 0                  
                    
  INSERT INTO mcapp..tea_at_day(teaid, card, cdate, adate, devid, gunid, kid)                  
   SELECT stuid, card, cdate, adate, devid, gunid, kid                   
    FROM #stu_mc_day_raw                   
    WHERE usertype_3EF5E8E0 = 1                     
        
  update sm1 set status = 1          
   output deleted.ID, deleted.stuid, deleted.card, deleted.cdate, deleted.adate, getdate()       
   Into init_stu_mc_day_deal_time(ID, stuid, card, cdate, adate, dt)      
   from mcapp..stu_mc_day_raw sm1                   
    inner join #stu_mc_day_raw sm2                   
     on sm1.ID = sm2.ID                  
       
 --select sm.ID,uc.userid as stuid, sm.adate,sm.cdate,sm.sendtime,                
 --   CommonFun.dbo.fn_RoleGet(k.sendSet,1) InSend,                
 --   CommonFun.dbo.fn_RoleGet(k.sendSet,2) OutSend,                
 --   ROW_NUMBER()OVER(PARTITION BY stuid order by adate)rowno                   
 --into #send                   
 --from mcapp..stu_mc_day_raw sm                  
 -- INNER join mcapp..cardinfo c on c.cardno = sm.card and c.kid = sm.kid                  
 -- INNER join BasicData..User_Child uc on c.userid = uc.userid                 
 -- INNER JOIN mcapp..kindergarten k on k.kid = sm.kid                 
 -- and k.sendSet > 0                 
 -- and (CommonFun.dbo.fn_RoleGet(k.sendSet,1) = 1                
 --  OR CommonFun.dbo.fn_RoleGet(k.sendSet,2) = 1)                
 -- where CONVERT(varchar(10),sm.cdate,120) = CONVERT(varchar(10),GETDATE(),120) --                   
 -- and CONVERT(varchar(10),sm.adate,120) = CONVERT(varchar(10),GETDATE(),120) --                  
      
Select kid, CommonFun.dbo.fn_RoleGet(k.sendSet,1) InSend, CommonFun.dbo.fn_RoleGet(k.sendSet,2) OutSend      
  Into #k      
  From mcapp..kindergarten k      
  Where k.sendSet > 0       
      
Delete #k Where not (InSend = 1 Or OutSend = 1)      
      
Select sm.ID, sm.card, sm.adate, sm.cdate, sm.sendtime, k.InSend, k.OutSend, sm.kid      
  Into #sm      
  From mcapp..stu_mc_day_raw sm, #k k      
  Where k.kid = sm.kid      
    and sm.cdate >= CONVERT(varchar(10),GETDATE(),120) and sm.cdate < CONVERT(varchar(10), dateadd(dd, 1, GETDATE()),120)      
    and sm.adate >= CONVERT(varchar(10),GETDATE(),120) and sm.adate < CONVERT(varchar(10), dateadd(dd, 1, GETDATE()),120)      
      
Select sm.ID, uc.userid as stuid, sm.adate, sm.cdate, sm.sendtime, sm.InSend, sm.OutSend, ROW_NUMBER()OVER(PARTITION BY uc.userid order by sm.adate)rowno           
  Into #send         
  From #sm sm, mcapp..cardinfo_V c, BasicData..User_Child uc      
  Where sm.card = c.cardno and sm.kid = c.kid and c.userid = uc.userid      
      
Drop table #k, #sm      
            
 --找出要发送的                  
 select MAX(ID)ID,stuid,InSend,OutSend, max(adate)adate, max(cdate)cdate, MIN(cdate) Incdate          
 into #cet                  
  from #send group by stuid,InSend,OutSend                 
  --having DATEDIFF(mi,isnull(MAX(sendtime),'20000101'),max(cdate)) > 120                  
                  
select t.ID, t.stuid, uc.mobile, uc.name, t.cdate, t.adate, t.Incdate,          
       CAST(Case When datepart(hh, cdate) >= 16 Then '离园' Else '入园' End as nvarchar(600)) [content],           
       uc.kid, t.InSend, t.OutSend, Cast(null as Int) smsport        
  into #T1          
  from #cet t inner join BasicData..User_Child uc             
    on t.stuid = uc.userid            
    and commonfun.dbo.fn_cellphone(uc.mobile) = 1            
          
Delete sqlagentdb.dbo.mc_day_raw_message Where senddate < CONVERT(Varchar(10), GETDATE(), 120)            
           
UPdate a Set [content] = '离园'           
  From #T1 a          
  Where Exists (Select * From sqlagentdb.dbo.mc_day_raw_message b          
                  Where b.kid = a.kid and b.userid = a.stuid           
                    and b.mobile = a.mobile and b.sendtype = '入园'          
                    and b.senddate >= CONVERT(Varchar(10), GETDATE(), 120)      
                    and b.senddate < CONVERT(Varchar(10), Dateadd(dd, 1, GETDATE()), 120))          
          
Delete a          
  From #T1 a, sqlagentdb.dbo.mc_day_raw_message b          
  Where b.kid = a.kid and b.userid = a.stuid and b.mobile = a.mobile          
    and b.senddate >= CONVERT(Varchar(10), GETDATE(), 120)          
    and b.senddate < CONVERT(Varchar(10), Dateadd(dd, 1, GETDATE()), 120)        
    and b.sendtype = '离园'           
          
Delete #T1 Where [content] = '离园' and datepart(hh, cdate) < 16          
    
      
;Merge mcapp.dbo.stu_in_out_time a          
Using (Select stuid, Min(Case When [content] = '入园' Then Incdate End) intime,           
                     Max(Case When [content] = '离园' Then cdate End) outtime           
         From #T1 Group by stuid) b On a.userid = b.stuid and a.adddate = CONVERT(Varchar(10), GETDATE(), 120)          
When Matched and a.adddate = CONVERT(Varchar(10), GETDATE(), 120) Then           
  Update Set a.intime = Isnull(a.intime, b.intime), a.outtime = Isnull(a.outtime, b.outtime)          
When not Matched Then           
  Insert (userid, adddate, intime, outtime, sendtype) Values(b.stuid, CONVERT(Varchar(10), GETDATE(), 120), b.intime, b.outtime, 1);          
          
Delete a From #T1 a           
  Where Not Exists (Select * From ossapp..addservice b Where a.stuid = b.uid and b.a7 = 806 and b.describe = '开通')          
          
Delete #T1 Where Isnull(OutSend, 0) <> 1 and [content] = '离园'           
          
update sm set sendtime = GETDATE()             
  from mcapp..stu_mc_day_raw sm           
   inner join #T1 t on sm.ID = t.ID           
   inner join mcapp..kindergarten k on sm.kid = k.kid           
  and k.sendSet > 0           
 where Isnull(InSend, 0) <> 1 and [content] = '入园'           
            
Delete #T1 OutPut deleted.kid, deleted.stuid, deleted.mobile, GETDATE(), '入园' Into sqlagentdb.dbo.mc_day_raw_message          
  Where Isnull(InSend, 0) <> 1 and [content] = '入园'           
      
Update a Set smsport = b.smsport      
  From #T1 a, basicdata.dbo.[user] b      
  Where a.stuid = b.userid      
print @@rowcount      
      
--判断短信通道              
;With Data as (      
Select kid, Max(Isnull(Case When ptype = 21 Then pid End, -1)) isymportstatus, Max(Isnull(Case When ptype = 86 Then pid End, -1)) iszyymportstatus      
  From blogapp..permissionsetting       
  Where ptype In (21, 86)      
  Group by kid      
)      
Update a Set smsport = Case When b.isymportstatus > 0 then 5       
                            When b.iszyymportstatus > 0 then Case When a.smsport = 0 Then 0 Else 8 End      
                            Else Case When a.smsport = 8 Then 8 Else 0 End      
                       End      
  From #T1 a, Data b      
  Where a.kid = b.kid      
      
DECLARE @MobilePort int --强制移动用户使用通道              
DECLARE @UnicomPort int --强制联通用户使用通道              
DECLARE @TelComPort int --强制电信用户使用通道              
SELECT @MobilePort = IntValue from BasicData..GlobalVarSet WHERE Name = '移动号码'              
SELECT @UnicomPort = IntValue from BasicData..GlobalVarSet WHERE Name = '联通号码'              
SELECT @TelComPort = IntValue from BasicData..GlobalVarSet WHERE Name = '电信号码'              
                
IF @MobilePort IS NOT NULL              
  Update #T1 Set smsport = @MobilePort WHERE commonfun.dbo.fn_cellphoneNet(mobile) = 0                
IF @UnicomPort IS NOT NULL              
  Update #T1 Set smsport = @MobilePort WHERE commonfun.dbo.fn_cellphoneNet(mobile) = 2                
IF @TelComPort IS NOT NULL              
  Update #T1 Set smsport = @MobilePort WHERE commonfun.dbo.fn_cellphoneNet(mobile) = 1              
        
Update #T1 Set smsport = 8 Where isnull(smsport, -1) not In (0, 8)        
      
Update #T1 Set smsport = 8 Where kid = 22935--李金乔2014.09.19      
      
Declare @sendtime Datetime          
Select @sendtime = GETDATE()          
Declare @mc_sms Table(kid Int, userid int, mobile Varchar(50), sendtype Varchar(50), sendport int, content Varchar(600))      
      
INSERT INTO sms..sms_message_yx([GUID], recuserid, recmobile,  [content], status, sendtime, writetime, kid,smstype)            
  Output Inserted.kid, Inserted.recuserid, Inserted.recmobile, Inserted.status, Inserted.content,       
         Case When CHARINDEX('由家长接离幼儿园', Inserted.[content]) > 0 Then '离园' Else '入园' End       
  Into @mc_sms(kid, userid, mobile, sendport, content, sendtype)      
  select NEWID() [GUID],stuid recuserid,mobile recmobile, name + '小朋友家长，您好，您的孩子于['            
         +DATENAME(Year,Case When [content] = '入园' then Incdate Else cdate End)+N'年'            
         +CAST(DATEPART(Month,Case When [content] = '入园' then Incdate Else cdate End) AS varchar)+N'月'            
         +DATENAME(Day,Case When [content] = '入园' then Incdate Else cdate End)+N'日'            
         +CAST(DATEPART(hh,Case When [content] = '入园' then Incdate Else cdate End) AS varchar)+N'时'            
         +CAST(DATEPART(mi,Case When [content] = '入园' then Incdate Else cdate End) AS varchar)+N'分]'            
         +'已经'+case when [content] = '离园' then '由家长接离幼儿园!' else '安全入园，请您放心!' end, 10,@sendtime,@sendtime,kid        
         ,case when [content] = '离园' then 14 else 13 end              
    from #T1          
    Where smsport = 8  --and adate<='2014-11-14 10:00'      
print @@rowcount      
         
INSERT INTO sms..sms_message([GUID], recuserid, recmobile,  [content], status, sendtime, writetime, kid,smstype)            
  Output Inserted.kid, Inserted.recuserid, Inserted.recmobile, Inserted.status, Inserted.content,       
         Case When CHARINDEX('由家长接离幼儿园', Inserted.[content]) > 0 Then '离园' Else '入园' End       
  Into @mc_sms(kid, userid, mobile, sendport, content, sendtype)      
  select NEWID() [GUID],stuid recuserid,mobile recmobile, name + '小朋友家长，您好，您的孩子于['            
         +DATENAME(Year,Case When [content] = '入园' then Incdate Else cdate End)+N'年'            
         +CAST(DATEPART(Month,Case When [content] = '入园' then Incdate Else cdate End) AS varchar)+N'月'            
         +DATENAME(Day,Case When [content] = '入园' then Incdate Else cdate End)+N'日'            
         +CAST(DATEPART(hh,Case When [content] = '入园' then Incdate Else cdate End) AS varchar)+N'时'            
         +CAST(DATEPART(mi,Case When [content] = '入园' then Incdate Else cdate End) AS varchar)+N'分]'            
         +'已经'+case when [content] = '离园' then '由家长接离幼儿园!' else '安全入园，请您放心!' end, 0,@sendtime,@sendtime,kid        
         ,case when [content] = '离园' then 14 else 13 end            
    from #T1          
    Where smsport = 0  --and adate<='2014-11-14 10:00'          
print @@rowcount      
      
Insert Into sqlagentdb.dbo.mc_day_raw_message(kid, userid, mobile, senddate, sendtype)      
  Select kid, userid, mobile,  @sendtime, sendtype      
    From @mc_sms      
      
Insert Into mcapp.dbo.mc_sms_push(kid, userid, mobile, sendtype, sendport, content, smsdate)      
  Select kid, userid, mobile, sendtype, sendport, content, @sendtime      
    From @mc_sms      
      
Insert Into mcapp.dbo.stu_mc_day_raw_monitor (ID, stuid, mobile, cdate, adate, sendtime)          
  Select ID, stuid, mobile, cdate, adate, @sendtime          
    From #T1          
          
 update sm             
 set sendtime = @sendtime           
 from mcapp..stu_mc_day_raw sm           
 inner join #T1 t on sm.ID = t.ID           
 inner join mcapp..kindergarten k on sm.kid = k.kid           
  and k.sendSet > 0          
          
            
                  
  DROP TABLE #T,#stu_mc_day_raw,#T1,#send,#cet                  
        
  Insert Into [SqlAgentDB].dbo.init_stu_mc_day_exec_time([guid], point, dt) Values(@guid, 3, Getdate())      
                
END 