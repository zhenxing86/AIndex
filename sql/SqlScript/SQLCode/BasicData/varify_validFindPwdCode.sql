USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[varify_validFindPwdCode]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
-- =============================================  
-- Author:  xzx  
-- Project: com.zgyey.verify  
-- Create date: 2013-06-05  
-- Description: 校验验证码  
-- =============================================  
CREATE PROCEDURE [dbo].[varify_validFindPwdCode]  
@account nvarchar(50),  
@mobile nvarchar(20),  
@code nvarchar(20)  
AS  
declare   
@verifyTime datetime,  
@updateTime datetime,  
@verifyCount int,  
@ret varchar(20),  
@userid int  
BEGIN  
  if exists(   
  select 1 from verify    
    where account = @account   
    and mobile = @mobile  
    and verify_code = @code  
   )  
  begin  
    select @verifyTime =verify_time,@updateTime=update_time,@verifyCount=verify_count from verify    
      where account = @account   
      and mobile = @mobile  
      and verify_code = @code   
        
    if( datediff(day,@verifyTime,getdate())=0 and datediff(SS,@updateTime,getdate())<=300)  
    begin  
      if( @verifyCount <=3)  
      begin  
  set @ret ='ok'  
      end  
      else  
      begin  
  set @ret = 'codecountout'  
      end  
    end  
    else  
    begin  
  set @ret = 'codetimeout'  
    end  
  end  
  else  
  begin  
 set @ret = 'codefailure'  
  end  
    
  select @userid =userid  
   from BasicData..[user]    
    where account = @account     
    and deletetag = 1    
      
  select @ret,@userid  
END  
  
GO
