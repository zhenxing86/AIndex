USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[dataimport_upgrade_intimeGetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[dataimport_upgrade_intimeGetList]        
@kid int      
 AS         
         
        
 if(not exists(select 1 from excel_upgrade_child where kid=@kid and deletag=1))         
 begin        
  select convert(datetime,'1900-01-01 00:00:00.000')        
 end        
 else        
 begin        
        
 ;with         
 cet as        
 (        
 select distinct top 50 intime         
  from excel_upgrade_child         
  where kid=@kid    and deletag=1    
 )        
         
 select   intime from cet  order by intime desc        
 end        
GO
