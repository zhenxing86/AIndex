USE NGBApp
GO
/*  
-- Author:      Master̷  
-- Create date: 2013-08-15  
-- Description:  
-- Paradef:   
-- Memo:   
*/   
ALTER function [dbo].fn_ModuleSet(@kid int, @term varchar(6))   
returns @t table  
(  
 kid    int,  
 term   varchar (6),  
 hbModList varchar(200),   
 gbModList varchar(200),  
 Monadvset varchar(50),   
 celltype int,   
 cellset  varchar(100)  
)     
as  
BEGIN  
insert into @t(kid, term, hbModList, gbModList, Monadvset, celltype, cellset)  
 select ms.kid, ms.term, ms.hbModList, ms.gbModList, 
		CASE WHEN ISNULL(ms.Monadvset,'')= '' then '3,4,5,6,7,8,9,10,11,12,1,2' else ms.Monadvset end Monadvset, 
		ISNULL(cs.celltype,1), ISNULL(cs.cellset,'1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20')     
  from ModuleSet ms   
   left join CellSet cs   
    on ms.kid = cs.kid   
    and ms.celltype = cs.celltype  
   where ms.kid = @kid   
   and ms.term = @term        
 IF @@ROWCOUNT = 0    
  insert into @t(kid, term, hbModList, gbModList, Monadvset, celltype, cellset)  
   select @kid, @term, 'GartenInfo,Foreword,ClassInfo,Section,Cell,LifePhoto,WorkPhoto,Summary',   
       '', '3,4,5,6,7,8,9,10,11,12,1,2', 1, '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20'   
 return  
END