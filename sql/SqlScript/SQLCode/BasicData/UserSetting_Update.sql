USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[UserSetting_Update]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
  
-- =============================================  
-- Author:  lx  
-- Create date: 更新用户基本设置  
-- Description:   
-- exec UserSetting_Update 83963,'幼儿园管理员的教学助手1',''  
-- =============================================  
CREATE PROCEDURE [dbo].[UserSetting_Update]  
@userid int,  
@blogtitle varchar(50),  
@photowater varchar(50),  
@descrition varchar(1000),  
@network int  
,@douserid int=0
AS  
BEGIN  

 EXEC commonfun.dbo.SetDoInfo @DoUserID = @douserid, @DoProc = 'Basicdata.dbo.UserSetting_Update' --设置上下文标志   
  update t1 set t1.blogtitle=@blogtitle,t1.photowatermark=@photowater,t1.[description]=@descrition from blogapp..blog_baseconfig t1,user_bloguser t2  
  where t1.userid=t2.bloguserid and t2.userid=@userid  
  
  
 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志  
  IF(@@ERROR<>0)  
  BEGIN  
  RETURN -1  
  END  
  ELSE  
  BEGIN  
  RETURN 1  
  END  
    
END  
  
  
  
  
  
GO
