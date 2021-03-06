USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[admin_account_update]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:yz  
-- Create date:2014-5-21  
-- Description:   
-- =============================================  
CREATE PROCEDURE [dbo].[admin_account_update]  
 -- Add the parameters for the stored procedure here  
   @userid int,  
   @naccount nvarchar(50)  
   ,@douserid int =0
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
 
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @douserid, @DoProc = 'Basicdata.dbo.admin_account_update' --设置上下文标志   
 if not EXISTS (select userid from BasicData..[User] where account = @naccount)  
   begin  
     update u set u.account = @naccount  
       from BasicData..[user] u  
       where u.userid = @userid 
       
 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志  
    return 1  
   end  
     
 else  
   begin  
   
 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志 
     return -2  
   end  
END  
GO
