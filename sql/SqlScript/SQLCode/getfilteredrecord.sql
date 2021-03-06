USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[getfilteredrecord]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE Procedure [dbo].[getfilteredrecord]    
@BegDate Date,     
@EndDate Date,    
@status varchar(500)    
as    
Set Nocount  On    
if(@status!='')    
begin    
Select Distinct a.kid, b.kname, b.status, b.infofrom, c.name, a.adddate    
  From ossapp.dbo.filteredrecord a, ossapp.dbo.kinbaseinfo b, ossapp.dbo.users c    
  Where a.adddate >= @BegDate and a.adddate <= @EndDate and a.kid = b.kid and b.developer = c.ID and a.tablename <> 'product'    
    and Exists (Select * From BasicData.dbo.kindergarten d Where a.kid = d.kid) and b.status=@status  and a.Status=0  
end    
else    
begin    
Select Distinct a.kid, b.kname, b.status, b.infofrom, c.name, a.adddate    
  From ossapp.dbo.filteredrecord a, ossapp.dbo.kinbaseinfo b, ossapp.dbo.users c    
  Where a.adddate >= @BegDate and a.adddate <= @EndDate and a.kid = b.kid and b.developer = c.ID and a.tablename <> 'product'    
    and Exists (Select * From BasicData.dbo.kindergarten d Where a.kid = d.kid)   and a.Status=0  
end    
    
    
Select Distinct a.companyid, b.account, b.companyname, a.adddate    
  From ossapp.dbo.filteredrecord a, gyszq.dbo.company b    
  Where a.adddate >= @BegDate and a.adddate <= @EndDate and a.tablename = 'product' and a.companyid = b.companyid   and a.Status=0   
      
GO
