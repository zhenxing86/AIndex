USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[user_class_update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
      
------------------------------------      
--用途：用于oss中幼儿批量调班      
--项目名称：      
--说明：      
--时间：2014-8-20  exec  user_class_update 863220,97464,154      
------------------------------------      
CREATE proc [dbo].[user_class_update]   
@kid int,     
@intime datetime,      
@DoUserID int      
as      
BEGIN      
 SET NOCOUNT ON      
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @DoUserID, @DoProc = 'Basicdata.dbo.user_class_update' --设置上下文标志      
 Begin tran         
 BEGIN TRY        
  insert into user_class_changehistory(oldcid,cid,userid,operateuserid)    
  select uc.cid,t.cid,t.userid,t.douserid from ossapp..user_class_tmp t inner join BasicData..user_class uc on t.userid=uc.userid where t.intime=@intime  
  and t.douserid=@DoUserID  
  delete from user_class where userid in(select t.userid from ossapp..user_class_tmp t inner join BasicData..[user] u   
  on t.userid=u.userid and u.deletetag=1  
  where t.intime=@intime  
  and t.douserid=@DoUserID and u.usertype=0)  
  insert into user_class(cid,userid) select t.cid,t.userid from ossapp..user_class_tmp t inner join BasicData..[user] u   
  on t.userid=u.userid and u.deletetag=1  
  where t.intime=@intime  
  and t.douserid=@DoUserID and u.usertype=0  
    
  declare @term varchar(50)  
  set @term=CommonFun.dbo.fn_getCurrentTerm(@kid,GETDATE(),1)      
  update a set a.cid=t.cid from  
    ossapp..user_class_tmp t inner join user_class_all a on t.userid=a.userid and term=@term where t.intime=@intime and t.douserid=@DoUserID  
  and a.term=@term and deletetag=1  
  insert into user_class_all (cid,userid,term) select t.cid,t.userid,@term from  
    ossapp..user_class_tmp t left join user_class_all a on t.userid=a.userid and term=@term and deletetag=1 where t.intime=@intime and t.douserid=@DoUserID  
  and a.ucid is null  
  delete from ossapp..user_class_tmp where douserid=@DoUserID and intime=@intime  
  
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
