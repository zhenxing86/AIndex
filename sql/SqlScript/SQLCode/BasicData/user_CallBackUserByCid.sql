USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_CallBackUserByCid]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
--用途：得到用户数   
--项目名称：  
--说明：  
--时间：2011-5-20 16:57:46  

--user_CallBackUserByCid 
------------------------------------  
CREATE PROCEDURE [dbo].[user_CallBackUserByCid]  
 @kid int,  
 @cid  int,  
 @DoUserID int = 0  
 AS   
BEGIN  
 SET NOCOUNT ON   
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'Basicdata.dbo.user_CallBackUser' --设置上下文标志  
 Begin tran     
 BEGIN TRY    
  update r   
   set deletetag = 1,  
     kid = l.kid  
   from [user] r  
    inner join leave_kindergarten l   
     on r.userid = l.userid  
    inner join leave_user_class luc 
     on r.userid= luc.userid
   where luc.cid = @cid  
    
  insert into user_class(cid,userid)  
   select luc.cid,l.userid   
    from leave_kindergarten l
     inner join leave_user_class luc 
      on l.userid= luc.userid and l.kid>0  
     left join user_class uc on uc.userid = l.userid  
   where l.cid = @cid    
    and uc.cid is null  
  
 declare @term nvarchar(6)=''      
 select @term = CommonFun.dbo.fn_getCurrentTerm(@kid,GETDATE(),1)   
   
  ;With Data as (    
 select luc.cid,luc.userid
  from BasicData..[User] u 
   inner join BasicData..leave_user_class luc
   on u.userid=luc.userid and u.usertype=0 and kid=@kid
   where u.usertype=0 and kid=@kid and luc.cid=@cid
 ) 
 Merge BasicData..user_class_all uca   
 Using Data b On uca.userid=b.userid and uca.term=@term 
 When Matched Then    
 Update Set deletetag=1,cid=b.cid
 When not Matched Then    
 Insert (cid, userid, term, actiondate,deletetag)   
  Values(b.cid, b.userid, @term, getdate(), 1);   
    
  UPDATE ci              
   SET userid = luc.userid, memo='',usest = 1          
    from mcapp..cardinfo ci               
     inner join leave_user_card c   
      on ci.card = c.card
     inner join leave_user_class luc   
      on c.userid= luc.userid  
     where luc.cid=@cid               
               
  delete c
   from leave_user_card c
    inner join leave_user_class luc   
     on c.userid= luc.userid  
   where luc.cid=@cid         
            
    --更新VIP状态(主要是学生)            
    insert into ossapp..addservice            
   ( kid, cid, uid, pname, describe, isfree, normalprice, discountprice,             
   paytime, ftime, ltime, vippaystate, isproxy, proxymoney, proxystate, proxytime,             
   proxycid, a1, a2, a3, a4, a5, a6, a7, a8, userid, dotime, deletetag)        
  select  kid, a.cid, uid, pname, describe,isfree, normalprice, discountprice,             
   paytime,a.ftime, a.ltime, vippaystate, isproxy, proxymoney,proxystate, proxytime,             
   proxycid, a1, a2, a3, a4, a5, a6, a7, a8, a.userid, dotime, deletetag            
   FROM  LogData..ossapp_addservice_log a           
    inner join leave_user_class luc 
     on a.uid = luc.userid
   where luc.cid = @cid  and a.deletetag=1           
             
  update l
  set deletetag = 0   
   from LogData..ossapp_addservice_log l
    inner join leave_user_class luc 
     on l.uid = luc.userid
   where luc.cid = @cid 
    
  delete r from [BasicData].[dbo].[user_del] r  
   inner join leave_user_class luc
     on r.userid = luc.userid
   where luc.cid=@cid   
    
  delete l
   from leave_kindergarten l
    inner join leave_user_class luc
     on l.userid = luc.userid
   where kid = @kid   
    and luc.cid = @cid   
      
    
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
