/*------------------------------------          
--用途：学生/老师返园           
--项目名称： basicdata         
--说明：          
--时间：2011-5-20 16:57:46          
memo:          
[user_CallBackUser] 777847,0          
------------------------------------*/          
alter PROCEDURE [dbo].[user_CallBackUser]          
 @userid  int,          
 @DoUserID int = 0,
 @cid int = 0          
 AS           
BEGIN          
 SET NOCOUNT ON    
 --删除kid=0的记录  
 delete from    leave_kindergarten where userid=@userid and kid=0        
 declare @kid int =0,@did int =0,@deletetag int=0          
  select @kid = l.kid,@deletetag=u.deletetag       
   from leave_kindergarten l       
    inner join basicdata..[user] u       
     on l.userid = u.userid       
   where l.userid = @userid          
        
  if (@kid=0 or @deletetag=0)      
  begin      
  print 'leave_kindergarten no record'        
  return -2      
  end         
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'Basicdata.dbo.user_CallBackUser' --设置上下文标志          
 BEGIN TRY          
 Begin tran    
       
  update r           
   set deletetag = 1,          
     kid = l.kid          
   from [user] r          
    inner join leave_kindergarten l           
     on r.userid = l.userid          
   where l.userid = @userid          
            
  insert into user_class(cid,userid)          
   select luc.cid,luc.userid           
    from leave_user_class luc          
     left join user_class uc on uc.userid = luc.userid          
    where luc.userid = @userid            
     and uc.cid is null and luc.cid>0          
  
  --班级已经被删除的，可以重新选择班级
  if(@@ROWCOUNT=0 and @cid>0)
  insert into user_class (cid,userid)
   values(@cid,@userid)  
        
   declare @term nvarchar(6)=''      
 select @term = CommonFun.dbo.fn_getCurrentTerm(@kid,GETDATE(),1)      
     
 update user_class_all set deletetag=1      
  where userid= @userid and term=@term      
  if not  exists( select top 1 * from  user_class_all where userid=@userid and term=@term and deletetag=1)    
  begin    
    
     insert into user_class_all(cid,userid,term,actiondate,deletetag)    
     select luc.cid,luc.userid,@term,GETDATE(),1           
    from leave_user_class luc          
     left join user_class uc on uc.userid = luc.userid          
    where luc.userid = @userid            
     and uc.cid >0 and luc.cid>0       
  end      
    --如果是学生，还原删除的addserve记录，添加时间2014-9-16.添加原因：返园之后幼儿的VIP都没有了。    
   -- insert into ossapp..addservice( kid, cid, uid, pname, describe, isfree, normalprice, discountprice,         
   --paytime, ftime, ltime, vippaystate, isproxy, proxymoney, proxystate, proxytime,         
   --proxycid, a1, a2, a3, a4, a5, a6, a7, a8, userid, dotime, deletetag)    
   --select top 1 kid, cid, uid, pname, describe,isfree, normalprice, discountprice,         
   --paytime, ftime,  ltime, vippaystate, isproxy, proxymoney,proxystate, proxytime,         
   --proxycid, a1, a2, a3, a4, a5, a6, a7, a8, userid, dotime, deletetag    
   --from LogData..ossapp_addservice_log where uid=@userid and deletetag=1  order by logtime desc    
        
  --更新老师所属部门      
  select @did = did from department where superior=0 and kid=@kid and deletetag=1      
  update teacher set did=isnull(did,@did) where userid=@userid      
                
  delete leave_kindergarten where userid = @userid           
  delete leave_user_class where userid = @userid             
  delete [BasicData].[dbo].[user_del] where userid=@userid          
            
  --UPDATE ci              
  -- SET userid = @userid, memo='',usest = 1          
  --  from mcapp..cardinfo ci               
  --  WHERE exists (          
  --   select 1           
  --    from leave_user_card luc          
  --     where userid =@userid and ci.card = luc.card          
  --  ) and ci.userid is null          
               
  --delete leave_user_card where userid = @userid           
            
  --  --更新VIP状态(主要是学生)            
  --  insert into ossapp..addservice            
  -- ( kid, cid, uid, pname, describe, isfree, normalprice, discountprice,             
  -- paytime, ftime, ltime, vippaystate, isproxy, proxymoney, proxystate, proxytime,     
  -- proxycid, a1, a2, a3, a4, a5, a6, a7, a8, userid, dotime, deletetag)            
  --select  kid, cid, uid, pname, describe,isfree, normalprice, discountprice,             
  -- paytime,a.ftime, a.ltime, vippaystate, isproxy, proxymoney,proxystate, proxytime,             
  -- proxycid, a1, a2, a3, a4, a5, a6, a7, a8, userid, dotime, deletetag            
  -- FROM  LogData..ossapp_addservice_log a           
  --  where uid = @userid  and a.deletetag=1           
             
  --  update LogData..ossapp_addservice_log           
  --set deletetag = 0           
  -- where uid = @userid             
                
  Commit tran                                        
 End Try                
 Begin Catch                
  Rollback tran           
  print 'error'          
  EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志                
  Return -1                 
 end Catch            
  print 'succeed'          
  EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志               
  Return 1          
END 
