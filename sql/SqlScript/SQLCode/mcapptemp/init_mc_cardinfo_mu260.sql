USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[init_mc_cardinfo_mu260]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      xie    
-- Create date: 2013-10-22    
-- Description: 过程用于mu260批量插入卡号 到 cardinfo 表    
-- Memo:    
 exec init_mc_cardinfo 12511,1308009901,1308010000,0    
*/    
CREATE PROCEDURE [dbo].[init_mc_cardinfo_mu260]    
 @kid int,    
 @str varchar(8000),    
 @cardtype int,    
 @userid int = 0    
as    
BEGIN    
 SET NOCOUNT ON    
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @userid, @DoProc = 'init_mc_cardinfo_mu260&0' --设置上下文标志    
     
  CREATE TABLE #CardNo(col int)    
    
  INSERT INTO #CardNo    
    select distinct col  --将输入字符串转换为列表    
    from BasicData.dbo.f_split(@str,',')    
     
 insert into cardinfo(kid,card,cardtype)    
  select @kid,col,@cardtype    
   from #CardNo where not exists(
		select 1 from cardinfo 
			where kid=@kid and col=cardno
   )
       
 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志        
END    
GO
