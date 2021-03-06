USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[init_mc_cardinfo]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-04-28  
-- Description: 过程用于批量插入卡号 到 cardinfo 表  
-- Memo:  
 exec init_mc_cardinfo 12511,1308009901,1308010000,0  
*/  
CREATE PROCEDURE [dbo].[init_mc_cardinfo]  
 @kid int,  
 @start_card bigint,  
 @end_card bigint,   
 @cardtype int,   
 @userid int = 0,
 @ipaddr nvarchar(100)=NULL   
as  
BEGIN  
 SET NOCOUNT ON  
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @userid, @DoProc = 'init_mc_cardinfo&0' --设置上下文标志  
 if len(@start_card) <> LEN(@end_card)  
 begin  
  raiserror('起止卡号位数不一致',11,1)  
  return -1  
 end  
 if @start_card/1000000 <> @end_card/1000000  
 begin  
  raiserror('只能处理后六位，前面的数字需要相同',11,1)  
  return -2  
 end  
 
    
 insert into cardinfo(kid,card,cardtype)  
  select @kid, CAST(@start_card/1000000 as varchar(10))+ CommonFun.dbo.padleft(CAST(n as varchar(10)),6,'0'),@cardtype  
   from CommonFun.dbo.nums   
   where N >= @start_card%1000000   
    AND N <= @end_card%1000000  
 
 insert into cardinfo_log(kid,card ,udate ,usest ,CardType ,DoUserid ,DoWhere ,ipaddr)   
 select @kid, CAST(@start_card/1000000 as varchar(10))+ CommonFun.dbo.padleft(CAST(n as varchar(10)),6,'0'),
  getdate(),0,@cardtype, @userid,0,@ipaddr
   from CommonFun.dbo.nums   
   where N >= @start_card%1000000   
    AND N <= @end_card%1000000     
 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志      
END  
  
GO
