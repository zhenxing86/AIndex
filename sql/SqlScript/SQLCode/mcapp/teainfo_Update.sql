USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[teainfo_Update]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-07-22  
-- Description: 老师开卡  
-- Memo:   
select * from basicdata..[user] where name ='黄湘娥'     
 exec [teainfo_Update] 479936,'1303001667',1,12511,0,0,''   
*/   
CREATE  PROCEDURE [dbo].[teainfo_Update]    
 @teaid int,    
 @card nvarchar(20),    
 @syntag int,    
 @kid int,    
 @userid int = 0,     
 @DoWhere int = null, --0后台操作,1用户操作    
 @tts nvarchar(20)=NULL,  
 @DoReason nvarchar(200)=NULL,
  @ipaddr nvarchar(100)=NULL   
AS    
BEGIN    
 SET NOCOUNT ON     
 DECLARE @DoProc varchar(100)    
 set @DoProc = 'teainfo_Update&'+ISNULL(cast(@DoWhere as varchar(10)),'')    
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
    
 declare @i int    
 set @i=0    
   
 update BasicData..[user]     
  set tts = ISNULL(@tts,tts)     
  where userid = @teaid     
      
 --用户存在才进行操作    
 begin    
 --挂失卡    
  if(@card='')    
  begin    
   update cardinfo     
    set usest = -1, memo=@DoReason, userid = null
    output deleted.kid,deleted.card,GETDATE(),inserted.usest,deleted.CardType,
     inserted.userid,deleted.EnrolNum,@userid,@DoWhere,deleted.openCardDate,inserted.memo into @cardinfo       
    where userid = @teaid     
   set @i=1    
  end    
 --新增卡    
  else    
  begin    
   --卡存在而且没被使用    
   if(exists(select 1 from cardinfo where cardno=@card and kid = @kid and usest=0))    
   begin    
    update cardinfo set usest=1,
     userid = @teaid, openCardDate=ISNULL(openCardDate,GETDATE()) 
     output deleted.kid,deleted.card,GETDATE(),inserted.usest,deleted.CardType,
      inserted.userid,deleted.EnrolNum,@userid,@DoWhere,inserted.openCardDate,inserted.memo into @cardinfo   
     WHERE cardno = @card and kid = @kid    
    set @i=1    
   end    
   else if(exists(select 1 from cardinfo where cardno=@card and userid = @teaid and kid = @kid and usest=1))    
   begin    
    set @i=1    
   end    
  end    
 end  
 
  insert into mcapp..cardinfo_log(kid,card ,udate ,usest ,CardType ,userid ,EnrolNum ,DoUserid ,DoWhere ,openCardDate,memo,ipaddr)
   select  kid,card ,udate ,usest ,CardType ,userid ,EnrolNum ,DoUserid ,DoWhere ,openCardDate,memo,@ipaddr
    from @cardinfo 
      
 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志     
     
 return @i    
END 
GO
