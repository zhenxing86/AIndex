USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[dataimport_upgrade_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec dataimport_upgrade_GetModel 23115,0,'2014-07-22 18:31:48.960'  
CREATE PROCEDURE [dbo].[dataimport_upgrade_GetModel]        
@kid int,      
@usertype int,        
@intimestr datetime        
 AS         
 declare @syscount int,@onepass int,@nopass int,@twopass int,@allcount int,@noupgradecount int        
        
  select @syscount=COUNT(1)          
  from basicdata..[user] u         
   inner join basicdata..user_class uc on uc.userid=u.userid        
   inner join basicdata..[class] c on c.cid=uc.cid and c.kid=@kid        
   where u.kid=@kid         
   and u.usertype=@usertype         
   and u.deletetag=1 and c.deletetag=1        
        
         
 select @allcount=COUNT(1)        
  from  excel_upgrade_child      
 where kid=@kid and intime=@intimestr and deletag=1       
         
 select @onepass=COUNT(1) from excel_upgrade_child e         
  where e.kid=@kid and e.onepass=1 and intime=@intimestr  and deletag=1         
           
 select @nopass=COUNT(1) from excel_upgrade_child e         
  where e.kid=@kid and e.onepass=0 and intime=@intimestr  and deletag=1         
          
 set @twopass=0        
        
    declare @ctable table(cid int)  
    declare @term varchar(50)  
    set @term=CommonFun.dbo.fn_getCurrentTerm(@kid,GETDATE(),1)  
--获取升班资料中的原班级ID  
insert into @ctable(cid)  
select  c.cid from ossapp..excel_upgrade_child e   
left join basicdata..[User] u on e.account=u.account and u.kid=@kid and u.deletetag=1   
left join basicdata..user_class c on   u.userid=c.userid    
where e.kid=@kid and e.intime=@intimestr and c.cid>0 and e.deletag=1  
group by c.cid  
   
  
select @noupgradecount=COUNT(1)  
from basicdata..[user] u   
left join basicdata..user_class uc on u.userid=uc.userid and deletetag=1  
left join basicdata..leave_kindergarten l on u.userid=l.userid   
left join ossapp..excel_upgrade_child e on e.kid=@kid and e.intime=@intimestr and e.account=u.account and e.uname=u.name and e.deletag=1  
left join basicdata..class c on uc.cid=c.cid and c.deletetag=1 and c.iscurrent=1  
where u.kid=@kid and u.usertype=0 and u.deletetag=1 and uc.cid   in(select cid from @ctable)  
and l.ID is null and e.id is null  
        
        
select @syscount ,@onepass ,@nopass ,@twopass ,@allcount,@noupgradecount      
GO
