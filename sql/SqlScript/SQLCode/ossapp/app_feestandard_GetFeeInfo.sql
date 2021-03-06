USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[app_feestandard_GetFeeInfo]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
CREATE PROCEDURE [dbo].[app_feestandard_GetFeeInfo]  
@kid int,  
@feeid int,  
@userid int,  
@xid int=0  
 AS   
   
   
declare @nowterm int

	set @nowterm=ossapp.dbo.[GetCurTermType_Fun](@userid)
  
  
 declare @isopen varchar(100)='0'  
  
  select @isopen=describe from  addservice a   
 where a.[uid]=@userid and a.deletetag=1  
   
if(@xid>0)  
begin  
 select @isopen=case when @xid=804 then CommonFun.dbo.fn_RoleGet(lqRight,@nowterm) else ossapp.dbo.addservice_vip_GetRule(@userid,@xid) end      
   from BasicData..[User]     
    where userid= @userid    
      
    if @isopen='0'  
     set @isopen ='未开通'  
     else   
     set @isopen ='开通'  
end  
  
  
  
select f.proxyprice,f.remark,f.ID,isnull(@nowterm,-1),@isopen  
 from  feestandard  f  
  where f.kid=@kid
   and f.deletetag=1    
   and f.ID=@feeid  

GO
