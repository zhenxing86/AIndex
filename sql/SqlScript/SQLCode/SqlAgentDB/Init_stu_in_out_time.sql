USE [SqlAgentDB]
GO
/****** Object:  StoredProcedure [dbo].[Init_stu_in_out_time]    Script Date: 2014/11/24 23:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*          
-- Author:      蔡杰   
-- Create date: 2014-05-22        
-- Description: 记录幼儿入园离园时间  
-- Memo:            
*/          
CREATE Procedure [dbo].[Init_stu_in_out_time]  
as  
Set Nocount on   

Delete a
  Output deleted.stuid, deleted.card, deleted.cdate, deleted.tw, deleted.zz, deleted.ta, deleted.toe, deleted.devid, deleted.gunid, deleted.kid, deleted.Status, deleted.adate, deleted.sendtime
  Into SqlAgentDB.dbo.stu_mc_day_raw_Del(stuid, card, cdate, tw, zz, ta, toe, devid, gunid, kid, Status, adate, sendtime)
  From mcapp.dbo.stu_mc_day_raw a
  Where Exists(Select * From mcapp.dbo.stu_mc_day_raw b 
                 Where a.stuid = b.stuid and a.card = b.card
                   and a.kid = b.kid and a.cdate = b.cdate
                 Group by b.stuid, b.card, b.cdate, b.kid
                 Having MIN(b.ID) <> a.ID)
 
Select c.userid, sm.cdate Into #Data  
  from mcapp..stu_mc_day_raw sm          
    INNER join mcapp..cardinfo_V c on c.cardno = sm.card and c.kid = sm.kid          
    INNER join BasicData..[user] uc on c.userid = uc.userid         
    INNER JOIN mcapp..kindergarten k on k.kid = sm.kid         
  where sm.cdate >= CONVERT(varchar(10),GETDATE(),120)  
    and sm.adate <= CONVERT(varchar(10),Dateadd(dd, 1, GETDATE()),120)  
    and (not(k.sendSet > 0 and (CommonFun.dbo.fn_RoleGet(k.sendSet,1) = 1 OR CommonFun.dbo.fn_RoleGet(k.sendSet,2) = 1)))     
  
Insert Into mcapp.dbo.stu_in_out_time(userid, adddate, intime, outtime, sendtype)  
  Select userid, CONVERT(varchar(10), GETDATE(), 120),   
         Case When datepart(hh, MIN(cdate)) >= 16 Then null Else MIN(cdate) End,   
         Case When datepart(hh, MIN(cdate)) >= 16 Then MIN(cdate) Else Null End, 0  
    From #Data a  
    Where not Exists(Select * From mcapp.dbo.stu_in_out_time b  
                       Where b.adddate = CONVERT(varchar(10),GETDATE(),120)  
                         and a.userid = b.userid)  
    Group by userid;  
  
Select userid, MIN(cdate) cdate
  Into #outtime
  From #Data a  
  Where Exists(Select * From mcapp.dbo.stu_in_out_time b  
                 Where b.adddate = CONVERT(varchar(10),GETDATE(),120)   
                   and a.userid = b.userid and b.outtime is null  
                   and DATEADD(MI, -120, a.cdate) > b.intime)  
  Group by userid  

Update a Set outtime = b.cdate  
  From mcapp.dbo.stu_in_out_time a, #outtime b  
  Where a.adddate = CONVERT(varchar(10),GETDATE(),120) and a.userid = b.userid  
  
Drop Table #Data, #outtime
  

GO
