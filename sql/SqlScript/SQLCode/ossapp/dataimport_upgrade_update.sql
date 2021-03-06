USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[dataimport_upgrade_update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[dataimport_upgrade_update]          
@kid int,            
@usertype int,            
@inuserid int             
 AS             
 if(@usertype=0)            
 begin            
           
update e set      
e.uname=t.uname,          
 e.cname=t.cname,          
 e.account=t.account         
  from excel_upgrade_child e           
   inner join dataimport_upgrade_tmp t           
    on t.id=e.id           
    and t.kid=e.kid            
    where e.kid=@kid and t.inuserid=@inuserid          
             
 end            
 else  if(@usertype=1)            
 begin            
           
update e set        
e.uname=t.uname,        
 e.cname=t.cname,          
 e.account=t.account            
  from excel_upgrade_child e           
   inner join dataimport_upgrade_tmp t           
    on t.id=e.id           
    and t.kid=e.kid              
    where e.kid=@kid and t.inuserid=@inuserid          
             
 end            
           
 delete dataimport_upgrade_tmp where kid=@kid and inuserid=@inuserid 
GO
