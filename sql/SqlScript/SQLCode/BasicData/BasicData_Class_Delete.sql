USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_Class_Delete]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--BasicData_Class_Delete 72167    
--删除班级    
CREATE PROCEDURE [dbo].[BasicData_Class_Delete]    
@cid int    
as    
    
 EXEC commonfun.dbo.SetDoInfo @DoUserID = 0, @DoProc = 'BasicData_Class_Delete&0' --设置上下文标志     
begin tran     
begin try    
     
 --删除classapp数据库里的class_article,class_album，class_photos，class_forum,class_notice,class_photos,class_schedule,class_video      
 --classapp..class_video where [status]<>1    
update classapp..class_article    
set deletetag=-1    
where classid=@cid    
    
    
update classapp..class_photos set [status]=-1    
where cid = @cid    
    
    
update classapp..class_album     
set [status]=-1    
where classid=@cid    
    
update classapp..class_forum     
set [status]=-1    
where classid=@cid    
    
    
update classapp..class_notice      
set [status]=-1    
where classid=@cid    
    
update classapp..class_schedule      
set [status]=-1    
where classid=@cid    
    
    
update classapp..class_video      
set [status]=-1    
where classid=@cid    
------------------------------------------------------------------------------------------------------------------------      
     
     
     
--更新VIP状态    
 insert into LogData..ossapp_addservice_log    
 ([ID] ,[kid] ,[cid] ,[uid] ,[pname] ,[describe]    
 ,[isfree] ,[normalprice] ,[discountprice] ,[paytime]    
 ,[ftime] ,[ltime] ,[vippaystate] ,[isproxy] ,[proxymoney]    
 ,[proxystate] ,[proxytime] ,[proxycid]    
 ,[a1] ,[a2] ,[a3] ,[a4] ,[a5] ,[a6] ,[a7] ,[a8]    
 ,[userid] ,[dotime] ,[deletetag])    
 select [ID] ,[kid] ,[cid] ,[uid] ,[pname] ,[describe]    
 ,[isfree] ,[normalprice] ,[discountprice] ,[paytime]     
 ,a.[ftime] ,a.[ltime] ,[vippaystate] ,[isproxy] ,[proxymoney]    
 ,[proxystate] ,[proxytime] ,[proxycid]    
 ,[a1] ,[a2] ,[a3] ,[a4] ,[a5] ,[a6] ,[a7] ,[a8]    
 ,[userid] ,[dotime] ,[deletetag]    
  FROM ossapp..[addservice] a    
   where cid =@cid    
    and [deletetag]=1    
    
 delete ossapp..[addservice]    
  from ossapp..[addservice]    
   where  cid = @cid and [deletetag]=1     
--更新VIP状态    
    
    
--设置卡号为挂失状态    
update ci     
 set ci.usest = -1,ci.userid = ''    
 from mcapp..cardinfo ci    
  inner join BasicData..User_Child uc     
  on uc.userid = ci.userid    
 where uc.cid = @cid    
    
--离园幼儿    
insert into BasicData..leave_kindergarten(kid,userid,leavereason,outtime)    
select u.kid,uc.userid,'12005',GETDATE() from BasicData..user_class uc    
inner join BasicData..[user] u    
on u.userid=uc.userid    
where uc.cid=@cid and u.deletetag=1 and u.usertype=0    
  
insert into BasicData..leave_user_class(cid,userid)  
select cid,uc.userid  
 from BasicData..user_class uc    
inner join BasicData..[user] u    
on u.userid=uc.userid    
where uc.cid=@cid and u.deletetag=1 and u.usertype=0    
  
    
    
--资料有误删除幼儿    
update u set u.deletetag=0    
from BasicData..user_class uc    
inner join BasicData..[user] u    
on u.userid=uc.userid    
where uc.cid=@cid and u.deletetag=1 and u.usertype=0    
    
    
     
--删除班级关系表（幼儿+老师）    
delete BasicData..user_class    
where cid=@cid     
     
--删除班级    
update  BasicData..class     
set deletetag=0    
where cid=@cid    
    
    
commit tran    
select 1    
end try    
begin catch    
 rollback tran    
 select 0     
end catch    
 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志        
  
GO
