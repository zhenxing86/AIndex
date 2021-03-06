USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[stuinfo_AutoSet_ex]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--开两张大卡/两张小卡
CREATE PROCEDURE [dbo].[stuinfo_AutoSet_ex]
@kid int 
,@cardtype int =0
as

select c.userid into #userid from mcapp..cardinfo c
 inner join BasicData..user_child uc on c.userid=uc.userid
  where c.kid=@kid and c.CardType=@cardtype
  
create table #temp      
 (      
  xid int IDENTITY,      
  tuid int,      
  tcard varchar(20),      
  tcard2 varchar(20)      
 )           
  insert into #temp(tuid)      
   SELECT uc.userid      
   FROM BasicData..User_Child uc       
   where uc.kid = kid       
    and uc.grade <> 38   
    and uc.kid= @kid 
    and not exists(select * from #userid where userid = uc.userid)      
   order by uc.cid  
   
;with       
   cetc as       
   (      
    select card,      
    (ROW_NUMBER()over(order by [card])+1)/2 row1       
     from cardinfo       
      where kid=@kid       
      and usest = 0      
      and CardType = 0   
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
    output deleted.kid,deleted.card,inserted.udate,inserted.usest,deleted.CardType,inserted.userid,deleted.EnrolNum,134,0,inserted.openCardDate into @cardinfo  
  from cardinfo c       
   inner join #temp t       
    on t.tcard = c.[card]       
       
 update cardinfo       
  set usest = 1,      
    udate = GETDATE(), openCardDate=ISNULL(openCardDate,GETDATE()),        
    userid = t.tuid    
    output deleted.kid,deleted.card,inserted.udate,inserted.usest,deleted.CardType,inserted.userid,deleted.EnrolNum,134,0,inserted.openCardDate into @cardinfo      
  from cardinfo c       
   inner join #temp t       
    on t.tcard2 = c.[card]       
      
 insert into mcapp..cardinfo_log(kid,card ,udate ,usest ,CardType ,userid ,EnrolNum ,DoUserid ,DoWhere ,openCardDate,ipaddr)  
  select  kid,card ,udate ,usest ,CardType ,userid ,EnrolNum ,DoUserid ,DoWhere ,openCardDate,'127.0.0.1'   
   from @cardinfo   
   
   
   drop table #userid,#temp
  --select * from BasicData..user_child where kid=@kid
  
  
  --select  *from cardinfo where userid=896829  udate>='2014-09-19 13:20'
  --select  *from cardinfo where udate>='2014-09-19 13:20' and userid is null
  --update cardinfo set opencarddate=null where udate>='2014-09-19 13:20' and userid is null
GO
