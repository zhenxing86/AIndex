USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[Chile_BaseInfo_Update]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-08-01  
-- Description: 修改小朋友基本资料  
-- Memo:    
select * from [user] where userid = 295765  
select * from [user_baseinfo] where userid = 295765  
select * from [Child] where userid = 295765  
  
exec Chile_BaseInfo_Update 295765, '李文涛','李文涛',3,'2009-04-22',179,190,'18028633611',' 安泰易居',  
 '李浩','厉翠翠','枪。车','害怕小动物，不爱接触新鲜事物','水饺，鱼，西兰花，芹菜。虾。','基本没有过敏的','1501549077',' 15175754777'  
select * from [user] where userid = 295765  
select * from [user_baseinfo] where userid = 295765  
select * from [Child] where userid = 295765   
   
*/   
CREATE  PROCEDURE [dbo].[Chile_BaseInfo_Update]  
 @userid int,  
 @name varchar(50),  
 @nickname varchar(50),  
 @garder int,  
 @birthday datetime,  
 @province int,  
 @city int,  
 @moblie varchar(50),  
 @address varchar(150),  
 @fathername varchar(50),  
 @mothername varchar(50),  
 @favitething varchar(500),  
 @fearthing varchar(500),  
 @favitefoot varchar(500),  
 @fearfoot varchar(500),  
 @email varchar(50),  
 @excitele varchar(100)
 ,@douserid int=0 
AS  
BEGIN  
 SET NOCOUNT ON   
  EXEC commonfun.dbo.SetDoInfo @DoUserID = @douserid, @DoProc = 'Basicdata.dbo.Chile_BaseInfo_Update' --设置上下文标志     
 DECLARE @gender varchar(6)  
 DECLARE @brithday2 varchar(10)  
  
 if(@garder=3)     
  SET @gender='男'     
 ELSE     
  SET @gender='女'     
 Begin tran     
 BEGIN TRY    
 update user_baseinfo   
  set name = @name ,  
    nickname = @nickname,  
    birthday = @birthday,  
    gender = @garder,  
    mobile = @moblie,  
    email = @email,  
    [address] = @address ,  
    privince = @province,  
    city = @city,  
    exigencetelphone = @excitele  
  where userid = @userid   
    
 update [user]   
  set name = @name ,  
    nickname = @nickname,  
    birthday = @birthday,  
    gender = @garder,  
    mobile = @moblie,  
    email = @email,  
    [address] = @address ,  
    privince = @province,  
    city = @city,  
    exigencetelphone = @excitele  
  where userid = @userid  
    
 update child    
  set fathername = @fathername,  
    mothername = @mothername,  
    favouritething = @favitething,  
    fearthing = @fearthing,  
    favouritefoot = @favitefoot,  
    footdrugallergic = @fearfoot   
  where userid = @userid  
  
 Commit tran                                
 End Try        
 Begin Catch        
 Rollback tran    
  SELECT @brithday2=CONVERT(varchar(10),@birthday,120) 
  EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志       
  Return -1          
 end Catch       
  SELECT @brithday2=CONVERT(varchar(10),@birthday,120)  
  EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志     
  return 1   
END  
GO
