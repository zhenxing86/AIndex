USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[dataimport_noupgradelist]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--查询是否还有没有升班的小朋友     dataimport_noupgradelist 22084,'2014-07-29 11:44:45.750'     
CREATE proc [dbo].[dataimport_noupgradelist]    
@kid int,      
@intimestr datetime,      
@term varchar(100) ='2014-0'     
as      
begin      
  declare @ctable table(cid int)  
    
--获取升班资料中的原班级ID  
insert into @ctable(cid)  
select  c.cid from ossapp..excel_upgrade_child e   
left join basicdata..[User] u on e.account=u.account and u.kid=@kid and u.deletetag=1   
left join basicdata..user_class c on   u.userid=c.userid    
where e.kid=@kid and e.intime=@intimestr and c.cid>0 and e.deletag=1  
group by c.cid  
    
     
    set @term=CommonFun.dbo.fn_getCurrentTerm(@kid,GETDATE(),1)  
      
select distinct u.userid,c.cname,u.name,u.account,case when a.cid >0 then '是' else '否' end  ,e.id    
from basicdata..[user] u   
left join basicdata..user_class uc on u.userid=uc.userid and deletetag=1  
left join basicdata..leave_kindergarten l on u.userid=l.userid   
left join ossapp..excel_upgrade_child e on e.kid=@kid and e.intime=@intimestr and e.account=u.account and e.uname=u.name and e.deletag=1  
left join basicdata..class c on uc.cid=c.cid and c.deletetag=1 and c.iscurrent=1  
left join basicdata..user_class_all a on u.userid=a.userid and term=@term  
where u.kid=@kid and u.usertype=0 and u.deletetag=1 and uc.cid   in(select cid from @ctable)  
and l.ID is null and e.id is null    
 order by userid desc  
  
end
GO
