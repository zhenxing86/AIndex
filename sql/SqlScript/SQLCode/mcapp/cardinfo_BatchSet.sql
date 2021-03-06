USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[cardinfo_BatchSet]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*        
-- Author:      Master谭        
-- Create date: 2013-07-20        
-- Description:         
-- Memo:         
 cardinfo_BatchSet 12511, '1303001616,1303001617',0        
         
 SELECT * FROM cardinfo WHERE CARD IN ('1303001616','1303001617')        
 SELECT * FROM stuinfo WHERE CARD1 IN ('1303001616','1303001617')        
 SELECT * FROM stuinfo WHERE CARD2 IN ('1303001616','1303001617')        
 SELECT * FROM stuinfo WHERE CARD3 IN ('1303001616','1303001617')        
 SELECT * FROM stuinfo WHERE CARD4 IN ('1303001616','1303001617')        
*/        
CREATE PROCEDURE [dbo].[cardinfo_BatchSet]        
 @kid int,        
 @str varchar(8000),        
 @flag int ,        
 @userid int = 0,        
 @DoReason nvarchar(200)=NULL,    
 @DoWhere int=0,    
 @ipaddr nvarchar(100)=NULL    
 -- -1批量注销卡 将已使用的卡（usest=1） 变成 -1,同时将stuinfo中已开卡信息清除 。        
 --  0批量还原卡 将已挂失的卡（usest=-1） 变成 0。        
  -- -2批量作废卡 将未使用的卡（usest=0） 变成 -2。        
  -- 3批量删除卡 将新开卡而且没分配给人的卡删除。  
  -- 4批量将小卡转为大卡。   
  -- 5批量将大卡转为小卡。        
as          
BEGIN         
 SET NOCOUNT ON        
 DECLARE @D1 INT,@D2 INT,@D3 INT,@D4 INT,@DoProc nvarchar(20) = 'cardinfo_BatchSet&' + cast(@DoWhere as varchar)       
  CREATE TABLE #CardID(col nvarchar(40))        
  INSERT INTO #CardID        
    select distinct col  --将输入字符串转换为列表        
    from BasicData.dbo.f_split(@str,',')        
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
          
 if(@flag = 3)        
 begin        
  delete from c         
   output deleted.kid,deleted.card,GETDATE(),deleted.usest,deleted.CardType,deleted.userid,deleted.EnrolNum,@userid,@DoWhere,deleted.openCardDate,'' into @cardinfo          
   FROM cardinfo c         
   inner join #CardID ci         
    on c.cardno = ci.col        
    and c.kid = @kid         
    and c.usest = 0 and c.userid is null        
  IF @@ROWCOUNT = 0        
  RETURN -1         
 end        
 else if @flag in(0,-2)        
 begin          
  UPDATE c         
   SET usest = @flag,memo='',        
     userid = null        
     output deleted.kid,deleted.card,GETDATE(),inserted.usest,deleted.CardType,inserted.userid,deleted.EnrolNum,@userid,@DoWhere,deleted.openCardDate,'' into @cardinfo          
  FROM cardinfo c         
   inner join #CardID ci         
    on c.cardno = ci.col        
    and c.kid = @kid         
    and c.usest = case when @flag = -2 then 0 else -1 end        
  IF @@ROWCOUNT = 0        
  RETURN -1         
 end        
 else if @flag = -1        
 begin          
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
 end     
 else if @flag in (4,5)     
 begin          
  UPDATE c SET CardType = (case when @flag=4 then 0 else 1 end)    
    output deleted.kid,deleted.card,GETDATE(),deleted.usest,inserted.CardType,deleted.userid,deleted.EnrolNum,@userid,@DoWhere,deleted.openCardDate,deleted.memo into @cardinfo          
   FROM cardinfo c         
   inner join #CardID ci         
    on c.cardno = ci.col        
    and c.kid = @kid    
  IF @@ROWCOUNT = 0        
  RETURN -1          
 end       
 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志          
       
 insert into mcapp..cardinfo_log(kid,card ,udate ,usest ,CardType ,userid ,EnrolNum ,DoUserid ,DoWhere ,openCardDate,memo,ipaddr)      
   select  kid,card ,udate ,usest ,CardType ,userid ,EnrolNum ,DoUserid ,DoWhere ,openCardDate,memo,@ipaddr       
    from @cardinfo        
  RETURN 1         
        
END 
GO
