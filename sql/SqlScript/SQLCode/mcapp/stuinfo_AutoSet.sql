USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[stuinfo_AutoSet]    Script Date: 2014/11/24 23:15:11 ******/
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
    
*/    
CREATE PROCEDURE [dbo].[stuinfo_AutoSet]    
 @kid int,    
 @type int = 0,-- 0 按幼儿园 ， 1 按班级 ， 2 按小朋友    
 @str varchar(8000)= '',--'123,345'    
 @flag int = 1, -- 1 开一张大卡， 2， 开两大张卡 ，3 开一张小卡， 4 开两张小卡，5 开一大一小     
 @userid int = 0,
 @ipaddr nvarchar(100)=NULL   
as      
BEGIN     
 SET NOCOUNT ON    
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @userid, @DoProc = 'stuinfo_AutoSet&0' --设置上下文标志     
  CREATE TABLE #ID(col int)    
  IF @type <> 0    
  INSERT INTO #ID    
    select distinct col  --将输入字符串转换为列表    
    from BasicData.dbo.f_split(@str,',')    
    
 create table #temp    
 (    
  xid int IDENTITY,    
  tuid int,    
  tcard varchar(20),    
  tcard2 varchar(20)    
 )    
 IF @type = 0    
  insert into #temp(tuid)    
   SELECT uc.userid    
   FROM BasicData..User_Child uc     
   where uc.kid = @kid     
    and uc.grade <> 38    
    and not exists(select * from cardinfo where userid = uc.userid)    
   order by uc.cid    
 else if @type = 1    
  insert into #temp(tuid)    
   SELECT uc.userid    
   FROM BasicData.dbo.[user_Child] uc    
    inner join #ID i on uc.cid = i.col    
   where uc.kid=@kid     
    and uc.grade <> 38    
    and not exists(select * from cardinfo where userid = uc.userid)    
   order by uc.cid    
 else if @type = 2    
  insert into #temp(tuid)    
   SELECT uc.userid    
   FROM BasicData.dbo.[user_Child] uc    
    inner join #ID i on uc.userid = i.col     
   where uc.kid = @kid     
    and not exists(select * from cardinfo where userid = uc.userid)    
   order by uc.cid    
 if @flag = 5    
 begin      
   ;with tpbig as    
  (    
   select ROW_NUMBER() over (order by [card]) as rownum,[card]    
    from cardinfo     
    where usest = 0     
     and kid = @kid     
     and CardType = 0    
  ),tpsmall as    
  (    
   select ROW_NUMBER() over (order by [card]) as rownum,[card]    
    from cardinfo     
    where usest = 0     
     and kid = @kid     
     and CardType = 1    
  )    
  update #temp     
   set tcard = tb.[card],     
     tcard2 = ts.card     
   from #temp t     
    inner join  tpbig tb     
     on t.xid = tb.rownum     
    inner join tpsmall ts     
     on t.xid = ts.rownum     
      
 end    
 else if @flag in(2,4)    
 begin      
  ;with     
   cetc as     
   (    
    select card,    
    (ROW_NUMBER()over(order by [card])+1)/2 row1     
     from cardinfo     
      where kid=@kid     
      and usest = 0    
      and CardType = CASE WHEN @flag = 2 THEN 0 ELSE 1 END      
   ) ,    
   cetc1 as    
   (    
    select row1, MIN(card)Tcard, max(card) Tcard1     
     from cetc a     
      group by row1    
   )     
       
   update #temp set Tcard = c.Tcard, Tcard2 = c.Tcard1    
    from #temp t     
    inner join cetc1 c     
     on t.xid = c.row1    
     and c.Tcard <> c.Tcard1    
 end    
 else if @flag IN(1,3)    
 begin      
   ;with tp as    
  (    
   select ROW_NUMBER() over (order by [card]) as rownum,[card]    
    from cardinfo     
    where usest = 0     
     and kid = @kid     
     and CardType = CASE WHEN @flag = 1 THEN 0 ELSE 1 END    
  )    
  update #temp set tcard=[card] from tp where rownum=xid    
 end    
     
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
     
 update cardinfo     
  set usest = 1,    
    udate = GETDATE(), openCardDate=ISNULL(openCardDate,GETDATE()),      
    userid = t.tuid  
    output deleted.kid,deleted.card,inserted.udate,inserted.usest,deleted.CardType,inserted.userid,deleted.EnrolNum,@userid,0,inserted.openCardDate into @cardinfo    
  from cardinfo c     
   inner join #temp t     
    on t.tcard2 = c.[card]     
    
 insert into mcapp..cardinfo_log(kid,card ,udate ,usest ,CardType ,userid ,EnrolNum ,DoUserid ,DoWhere ,openCardDate,ipaddr)
  select  kid,card ,udate ,usest ,CardType ,userid ,EnrolNum ,DoUserid ,DoWhere ,openCardDate,@ipaddr 
   from @cardinfo 
 
 drop table #temp  
 
 
    
END 


GO
