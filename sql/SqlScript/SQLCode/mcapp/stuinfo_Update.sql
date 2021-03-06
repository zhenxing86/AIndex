USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[stuinfo_Update]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-07-22  
-- Description: 学生开卡  
-- Memo:   
exec stuinfo_Update   
 @stuid = 295767,  
 @tts = '',  
 @card1 = '1303001716',  
 @card2 = '1303001717',  
 @card3 = '1303001720',  
 @card4 = '1303001722',   
 @userid = 123 ,  
 @DoWhere  = 1  
*/  
CREATE PROCEDURE [dbo].[stuinfo_Update]   
 @stuid int,  
 @tts varchar(50),  
 @card1 varchar(40),  
 @card2 varchar(40),  
 @card3 varchar(40),  
 @card4 varchar(40),  
 @userid int = 0,  
 @DoWhere int = null, --0后台操作,1用户操作  
 @DoReason varchar(200) = null,
 @ipaddr nvarchar(100)=NULL   
AS   
BEGIN  
 SET NOCOUNT ON  
 DECLARE @kid int  
 SELECT @kid = kid from BasicData..[user] where userid = @stuid  
 IF NULLIF(@card1,'') = NULLIF(@card2,'')  
 or NULLIF(@card1,'') = NULLIF(@card3,'')  
 or NULLIF(@card1,'') = NULLIF(@card4,'')  
 or NULLIF(@card2,'') = NULLIF(@card3,'')  
 or NULLIF(@card2,'') = NULLIF(@card4,'')  
 or NULLIF(@card3,'') = NULLIF(@card4,'')  
 RETURN -1  
 DECLARE @DoProc varchar(100)  
 set @DoProc = 'stuinfo_Update&'+ISNULL(cast(@DoWhere as varchar(10)),'')  
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @userid, @DoProc = @DoProc --设置上下文标志  
     
 update BasicData..[user]   
  set tts = @tts   
  where userid = @stuid   
   and ISNULL(@tts,'') <> ''  
     
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
	
 UPDATE cardinfo   
  SET userid = @stuid,memo='', openCardDate=ISNULL(openCardDate,GETDATE()), 
    usest = 1  
  output deleted.kid,deleted.card,GETDATE(),inserted.usest,deleted.CardType,inserted.userid,deleted.EnrolNum,@userid,@DoWhere,inserted.openCardDate,'' into @cardinfo    
  WHERE cardno IN(@card1,@card2,@card3,@card4)  
   and kid = @kid  
   
 UPDATE cardinfo   
  SET userid = NULL, memo=@DoReason,  
    usest = -1  
    output deleted.kid,deleted.card,GETDATE(),inserted.usest,deleted.CardType,inserted.userid,deleted.EnrolNum,@userid,@DoWhere,inserted.openCardDate,inserted.memo into @cardinfo    
  WHERE userid = @stuid   
   AND cardno NOT IN(@card1,@card2,@card3,@card4)  
   
  insert into mcapp..cardinfo_log(kid,card ,udate ,usest ,CardType ,userid ,EnrolNum ,DoUserid ,DoWhere ,openCardDate,memo,ipaddr)
   select  kid,card ,udate ,usest ,CardType ,userid ,EnrolNum ,DoUserid ,DoWhere ,openCardDate,memo,@ipaddr
    from @cardinfo 
   
 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志        
END  
GO
