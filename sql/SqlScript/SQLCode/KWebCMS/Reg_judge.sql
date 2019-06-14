USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Reg_judge]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Reg_judge]    
@IP nvarchar(50),    
@min Int    
as    
BEGIN  
    
if Exists (Select * From kwebcms.dbo.RegisterHistory Where IP = @IP and RegisterDate >= dateadd(mi, -1 * @min, GETDATE()))  
begin    
   print 1  
  return  1    
  end  
else    
begin   
print 1  
  return  0   
  end  
  END
GO
