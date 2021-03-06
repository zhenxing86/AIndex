USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_Delete]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
--用途：删除一条用户详细信息记录   
--项目名称：  
--说明：  
--时间：2011-5-25 17:57:18  
------------------------------------  
CREATE PROCEDURE [dbo].[user_Delete]  
 @userid int,  
 @deletetype int,  
 @DoUserID int = 0  
 AS  
BEGIN  
 SET NOCOUNT ON   
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'Basicdata.dbo.user_Delete' --设置上下文标志  
 declare @kid int       
 select @kid=kid from [user] where userid=@userid  
 Begin tran     
 BEGIN TRY    
  if(@deletetype=0)  
  begin  
   insert into user_class_history(cid,userid) select cid,userid from user_class where userid=@userid  
   insert into user_kindergarten_history(kid,userid) select kid,userid from [user] where userid=@userid  
   DELETE user_class WHERE userid=@userid  
   update [user] set deletetag = 0, kid = 0   WHERE userid=@userid  
     
  end  
  else  
  begin  
   insert into user_class_history(cid,userid) select cid,userid from user_class where userid=@userid  
   insert into user_kindergarten_history(kid,userid)values(@kid,@userid)  
   DELETE user_class WHERE userid=@userid  
   update [user] set kid = 0   WHERE userid=@userid  
   update teacher set did=null where userid=@userid  
  end  
  
  --将该用户的所有卡号挂失  
  exec mcapp..teainfo_Update @userid,'',1,@kid,0,0,null,'离园自动挂失'  
  DELETE mcapp..sms_man_kid WHERE userid = @userid  
    
    
    
   delete [BasicData].[dbo].[user_del] where userid=@userid  
       
   insert into [BasicData].[dbo].[user_del](userid,usertype,kid,updatetime)  
   values (@userid,1,@kid,GETDATE())   
     
  INSERT INTO [mcapp].[dbo].[querycmd]  
           ([kid],[devid],[querytag],[adatetime],[syndatetime],[status]) 
   select @kid,devid,3,getdate(),getdate()+0.01,1 
    from mcapp..driveinfo
     where kid =@kid and devid not like '%30'
    
  Commit tran                                
 End Try        
 Begin Catch        
  Rollback tran   
  EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志        
  Return -1         
 end Catch    
  EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志       
  Return 1  
END   
GO
