USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[cardinfo_setoff]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*          
-- Author:   xie
-- Create date: 2014-11-07       
-- Description:  挂失毕业班的卡号        
-- Memo:   
        
 cardinfo_setoff 15028, 134,'毕业班的'   

    select c.cardno from cardinfo c
     inner join BasicData..[USER_child] uc
      on c.userid=uc.userid and uc.grade=38 and c.kid=15028
                    
*/          
CREATE PROCEDURE [dbo].[cardinfo_setoff]          
 @kid int,                   
 @userid int = 0,          
 @DoReason nvarchar(200)=NULL,      
 @DoWhere int=0,      
 @ipaddr nvarchar(100)=NULL     
as            
BEGIN           
 SET NOCOUNT ON          
 DECLARE @D1 INT,@D2 INT,@D3 INT,@D4 INT,@DoProc nvarchar(20) = 'cardinfo_BatchSet&' + cast(@DoWhere as varchar)         
  CREATE TABLE #CardID(col nvarchar(40))          
  
  INSERT INTO #CardID    
    select c.cardno from cardinfo c
     inner join BasicData..[USER_child] uc
      on c.userid=uc.userid and uc.grade=38 and c.kid=@kid
             
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @userid, @DoProc = @DoProc --设置上下文标志          
         
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
 openCardDate datetime,        
 memo nvarchar(100)       
    )        
            
            
  UPDATE c SET usest = -1,memo=@DoReason,           
     userid = null          
    output deleted.kid,deleted.card,GETDATE(),inserted.usest,deleted.CardType,inserted.userid,deleted.EnrolNum,@userid,@DoWhere,deleted.openCardDate,inserted.memo into @cardinfo            
   FROM cardinfo c           
   inner join #CardID ci           
    on c.cardno = ci.col          
    and c.kid = @kid            
    and c.usest = 1          
  IF @@ROWCOUNT = 0          
  RETURN -1   
           
 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志            
         
insert into mcapp..cardinfo_log(kid,card ,udate ,usest ,CardType ,userid ,EnrolNum ,DoUserid ,DoWhere ,openCardDate,memo,ipaddr)        
   select  kid,card ,udate ,usest ,CardType ,userid ,EnrolNum ,DoUserid ,DoWhere ,openCardDate,memo,@ipaddr         
    from @cardinfo          
  RETURN 1           
          
END 


GO
