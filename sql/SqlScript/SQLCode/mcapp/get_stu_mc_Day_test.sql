USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[get_stu_mc_Day_test]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      Master谭    
-- Create date:     
-- Description:     
-- Memo:  mcapp    
*/    
CREATE PROC [dbo].[get_stu_mc_Day_test]    
AS    
BEGIN    
 SET NOCOUNT ON    
   
  --UPDATE stu_mc_Day     
  -- SET ftype = ftype + 1     
  -- OutPut Deleted.kid, Deleted.stuid ,Deleted.card ,Deleted.tw ,Deleted.zz ,Deleted.cdate, Deleted.ftype,Deleted.adate     
  -- where ftype in(0,2)      
  --  and Status = 0     
    
  Declare @ss table (kid int, stuid int, card varchar(10), tw numeric(9, 2), zz varchar(50), cdate datetime, ftype int, adate datetime)  
  
  UPDATE s   
   SET ftype = ftype + 1     
   OutPut Deleted.kid, Deleted.stuid ,Deleted.card ,Deleted.tw ,Deleted.zz ,Deleted.cdate, Deleted.ftype,Deleted.adate  
     Into @ss(kid, stuid, card, tw, zz, cdate, ftype, adate)  
   from stu_mc_Day_test s  
    inner join BlogApp..permissionsetting p   
     on p.kid =s.kid and p.ptype=90  
   where s.ftype in(0,2)      
    and Status = 0     
    
  Select * From @ss  
END     
  
GO
