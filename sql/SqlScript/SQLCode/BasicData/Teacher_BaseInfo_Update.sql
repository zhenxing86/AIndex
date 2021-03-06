USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[Teacher_BaseInfo_Update]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-08-01  
-- Description: 修改老师基本资料  
-- Memo:    
select * from [user] where userid = 296418  
select * from [user_baseinfo] where userid = 296418  
select * from [teacher] where userid = 296418  
  
exec Teacher_BaseInfo_Update 296418, '李秋芽','李秋芽',2,'1988-05-02',290,291,'18028633611','广州科学城',  
 '主班老师','幼中高', '硕士研究生结业', '','','',''  
select * from [user] where userid = 296418  
select * from [user_baseinfo] where userid = 296418  
select * from [Child] where userid = 296418   
  
*/  
CREATE PROCEDURE [dbo].[Teacher_BaseInfo_Update]  
 @userid int,  
 @name varchar(50),  
 @nickname varchar(50),  
 @garder int,  
 @birthday datetime,  
 @province int,  
 @city int,  
 @moblie varchar(50),  
 @address varchar(150),  
 @gw varchar(50),  
 @post varchar(50),  
 @education varchar(50),  
 @employmentinfo varchar(50),  
 @politicalface varchar(50),  
 @email varchar(50),  
 @excitele varchar(100) 
 ,@douserid int=0  
AS  
BEGIN    
SET NOCOUNT ON  

 EXEC commonfun.dbo.SetDoInfo @DoUserID = @douserid, @DoProc = 'Basicdata.dbo.Teacher_BaseInfo_Update' --设置上下文标志
 Begin tran     
 BEGIN TRY    
  update user_baseinfo   
   set name = @name,  
     nickname = @nickname,  
     birthday = @birthday,  
     gender = @garder,  
     mobile = @moblie,  
     email = @email,  
     [address] = @address,  
     privince = @province,  
     city = @city,  
     exigencetelphone = @excitele  
  where userid = @userid  
    
  update [user]   
   set name = @name,  
     nickname = @nickname,  
     birthday = @birthday,  
     gender = @garder,  
     mobile = @moblie,  
     email = @email,  
     [address] = @address,  
     privince = @province,  
     city = @city,  
     exigencetelphone = @excitele  
  where userid = @userid   
  
  update teacher    
   set title = @gw,  
   post = @post,  
   education = @education,  
   employmentform = @employmentinfo,  
   politicalface = @politicalface   
  where userid = @userid  
  
 
  Commit tran                                
 End Try        
 Begin Catch   
 
 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志      
  Rollback tran     
  Return -1         
 end Catch   
 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志   
  Return 1      
END  
GO
