/*        
-- Author:      Master谭        
-- Create date:         
-- Description:         
-- Memo:          
*/        
CREATE PROC get_stu_mc_Day        
AS        
BEGIN        
 SET NOCOUNT ON        
       
  --UPDATE stu_mc_Day         
  -- SET ftype = ftype + 1         
  -- OutPut Deleted.kid, Deleted.stuid ,Deleted.card ,Deleted.tw ,Deleted.zz ,Deleted.cdate, Deleted.ftype,Deleted.adate         
  -- where ftype in(0,2)          
  --  and Status = 0         
        
  Declare @ss table (kid int, stuid int, card varchar(10), tw numeric(9, 2), zz varchar(50), cdate datetime, ftype int, adate datetime, commit_zz varchar(50))      
      
  UPDATE s       
   SET ftype = ftype + 1         
   OutPut Deleted.kid, Deleted.stuid ,Deleted.card ,Deleted.tw ,Deleted.zz ,Deleted.cdate, Deleted.ftype,Deleted.adate,Deleted.commit_zz    
     Into @ss(kid, stuid, card, tw, zz, cdate, ftype, adate,commit_zz)      
   from stu_mc_Day s      
    inner join BlogApp..permissionsetting p       
     on p.kid =s.kid and p.ptype=90      
   where s.ftype = 0     
    and Status = 0         
        
  Select * From @ss      
END 