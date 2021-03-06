USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[stuinfo_AutoSet_OneCard]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      Master谭      
-- Create date: 2013-07-20      
-- Description:       
-- Memo:       
 stuinfo_AutoSet 17709,0,'',5      
 select * from cardinfo where kid = 12511      
 select * from cardinfo where kid = 17709      
   
   select *into  cardinfo141028 from cardinfo
   stuinfo_AutoSet_OneCard 24170,'98824',3,1407104905,1407104933,134
*/      
CREATE PROCEDURE [dbo].[stuinfo_AutoSet_OneCard]  
 @kid int,      --按按班级   
 @cidlst varchar(8000)= '',--'123,345'      
 @flag int = 1, -- 1 开一张大卡，3 开一张小卡   
 @start_card bigint,    
 @end_card bigint,
 @userid int = 0,  
 @ipaddr nvarchar(100)=NULL     
as        
BEGIN       
 SET NOCOUNT ON      
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @userid, @DoProc = 'stuinfo_AutoSet_OneCard&0' --设置上下文标志       
  CREATE TABLE #ID(col int)      
    
  INSERT INTO #ID      
    select distinct col  --将输入字符串转换为列表      
    from BasicData.dbo.f_split(@cidlst,',')      
  
  select * into #CardInfo 
   from cardinfo
    where kid= @kid and usest=0
      
 create table #temp      
 (      
  xid int IDENTITY,      
  tuid int,      
  tcard varchar(20),      
  tcard2 varchar(20)      
 )      
    
  insert into #temp(tuid)      
   SELECT uc.userid      
   FROM BasicData.dbo.[user_Child] uc      
    inner join #ID i on uc.cid = i.col      
   where uc.kid=@kid       
    and uc.grade <> 38   
    and uc.userid not in (875227,875286,875307,875559,875573,875331,875337,875341,875450,875460,875463,875466,875472,875484)
    --and not exists(select * from cardinfo where userid = uc.userid)      
   order by uc.cid      
   
 if @flag IN(1,3)  --开一张大卡/小卡    
 begin        
   ;with tp as      
  (      
   select ROW_NUMBER() over (order by [card]) as rownum,[card]      
    from #CardInfo       
    where usest = 0       
     and kid = @kid       
     and CardType = CASE WHEN @flag = 1 THEN 0 ELSE 1 END
     and CAST(cardno as bigint)>=@start_card
     and CAST(cardno as bigint)<=@end_card
  )      
  update #temp set tcard=[card] from tp where rownum=xid      
 end      
    
  --   select t.tuid,c.* 
  --from cardinfo c       
  -- inner join #temp t       
  --  on t.tcard = c.[card] 
    
  declare @cardinfo table(  
  kid int,  
  card nvarchar(40),  
  udate datetime,  
  usest int,  
  CardType int,  
  userid int,  
  EnrolNum int,  
  DoUserid int,  
  DoWhere int,  
  openCardDate datetime  
 )  
 update cardinfo       
  set usest = 1,      
    udate = GETDATE(), openCardDate=ISNULL(openCardDate,GETDATE()),        
    userid = t.tuid     
    output deleted.kid,deleted.card,inserted.udate,inserted.usest,deleted.CardType,inserted.userid,deleted.EnrolNum,@userid,0,inserted.openCardDate into @cardinfo  
  from cardinfo c       
   inner join #temp t       
    on t.tcard = c.[card]  
      
 insert into mcapp..cardinfo_log(kid,card ,udate ,usest ,CardType ,userid ,EnrolNum ,DoUserid ,DoWhere ,openCardDate,ipaddr)  
  select  kid,card ,udate ,usest ,CardType ,userid ,EnrolNum ,DoUserid ,DoWhere ,openCardDate,@ipaddr   
   from @cardinfo   
   
 drop table #temp,#CardInfo    
   
   
      
END   
  

GO
