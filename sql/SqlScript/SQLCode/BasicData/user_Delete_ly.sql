USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_Delete_ly]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*------------------------------------      
--用途：幼儿/老师离园    
--项目名称：      
--说明：      
--时间：2011-5-25 17:57:18      
momo:    
[user_Delete_ly] 734833,'12001',0,1 
[user_Delete_ly] 940055,'12001',134,1    
------------------------------------*/    
CREATE PROCEDURE [dbo].[user_Delete_ly]      
 @userid int,      
 @leavereason varchar(100)='',      
 @DoUserID int = 0,      
 @deletetag int=1 --1：离园（默认），0：彻底删除    
 AS       
BEGIN      
 SET NOCOUNT ON       
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'Basicdata.dbo.user_Delete_ly' --设置上下文标志      
      
 Begin tran         
 BEGIN TRY       
 declare @usertype int =0,@kid int =0    
 select @kid=kid ,@usertype = case when ISNULL(usertype,0)=0 then 0 else 1 end    
  from [user]    
  where userid = @userid    
      
    IF (@usertype=0 and (@leavereason='资料有误要删除' or @leavereason='12005' or @leavereason='资料有误要删除(彻底删除)') )     
 BEGIN      
  set @deletetag = 0 --彻底删除    
    END    
   --删除userid=@userid，kid=0的数据，防止数据不正确，导致后面返园的时候失败  
   if exists( select top 1 * from leave_kindergarten where kid=0 and userid=@userid)   
   begin  
 delete   from BasicData..leave_kindergarten where userid=@userid and kid=0  
   end   
     
 insert into dbo.leave_kindergarten(kid,userid,leavereason,outtime)      
  select kid,userid,@leavereason,GETDATE()       
   from [user]      
   where userid = @userid     
      
    --delete   from BasicData..leave_user_class添加时间2014-9-4，原因：防止leave_user_class有数据导致离园失败  
 if   exists(select * from leave_user_class where userid=@userid)  
 begin  
 delete   from BasicData..leave_user_class where userid=@userid  
   end  
     
  insert into leave_user_class(cid,userid)     
  select cid,userid     
   from user_class     
    where userid=@userid    
     
     
 insert into leave_user_card(userid,card)    
  select userid,card    
   from mcapp..cardinfo      
    where userid = @userid    
       
 DELETE user_class WHERE userid=@userid     
     
 declare @term nvarchar(8)=''    
 select @term = CommonFun.dbo.fn_getCurrentTerm(@kid,GETDATE(),1)   
      
 update    user_class_all  set deletetag=0  
  where userid= @userid and term=@term and deletetag=1   
      
 update [user] set deletetag = @deletetag, kid = 0   WHERE userid=@userid      
     
   if (@usertype=0) --学生    
   begin      
    --将该用户的所有卡号挂失      
    --exec mcapp..stuinfo_Update @userid,'','','','','',0,0,'离园自动挂失'    
    exec mcapp..stuinfo_Update     
	 @stuid = @userid,    
	 @tts = '',    
	 @card1 = '',    
	 @card2 = '',    
	 @card3 = '',    
	 @card4 = '',     
	 @userid = @DoUserID ,    
	 @DoWhere  = 1 ,
	 @DoReason = '离园自动挂失',  
	 @ipaddr =NULL 
	       
    --更新VIP状态      
    insert into LogData..ossapp_addservice_log      
   (ID, kid, cid, uid, pname, describe, isfree, normalprice, discountprice,       
   paytime, ftime, ltime, vippaystate, isproxy, proxymoney, proxystate, proxytime,       
   proxycid, a1, a2, a3, a4, a5, a6, a7, a8, userid, dotime, deletetag,logtime)      
  select ID, kid, cid, uid, pname, describe,isfree, normalprice, discountprice,       
   paytime,a.ftime, a.ltime, vippaystate, isproxy, proxymoney,proxystate, proxytime,       
   proxycid, a1, a2, a3, a4, a5, a6, a7, a8, userid, dotime, deletetag,getdate()      
   FROM ossapp..addservice a      
    where uid = @userid      
     and deletetag = 1      
       
    delete ossapp..addservice      
   where uid = @userid       
    and deletetag = 1       
    and kid = @kid      
   end     
   else--老师    
   begin    
   --update teacher set did=null where userid=@userid  --老师所属部门不删除    
   --将该用户的所有卡号挂失      
   --exec mcapp..teainfo_Update @userid,'',1,@kid,0,0,null,'离园自动挂失'   
   exec mcapp..teainfo_Update     
	 @teaid =@userid,      
	 @card ='',      
	 @syntag =1,      
	 @kid =@kid,      
	 @userid = @DoUserID,       
	 @DoWhere = 1, --0后台操作,1用户操作      
	 @tts =NULL,    
	 @DoReason ='离园自动挂失',  
	 @ipaddr =NULL 
     
   DELETE mcapp..sms_man_kid WHERE userid = @userid      
   end        
     
   if @kid >0  
   begin  
    delete [BasicData].[dbo].[user_del] where userid=@userid     
    insert into [BasicData].[dbo].[user_del](userid,usertype,kid,updatetime)      
  values (@userid,@usertype,@kid,GETDATE())     
   end    
       
   INSERT INTO [mcapp].[dbo].[querycmd]([kid],[devid],[querytag],[adatetime],[syndatetime],[status])     
    select @kid,devid,3,getdate(),getdate()+0.01,1     
     from mcapp..driveinfo    
      where kid =@kid and devid not like '%30'    
         
  Commit tran                                    
 End Try            
 Begin Catch            
  Rollback tran       
  print '离园失败'    
  EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志            
  Return -1             
 end Catch        
  EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志       
  print '离园成功'        
  Return 1      
END        
      
      
       
 if(@@ERROR<>0)      
 begin      
  return (-1)      
 end      
 else      
 begin      
  return (1)      
 end      
 
 
 
GO
