USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetKinClassInfo]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      xie      
-- Create date: 2014-10-29      
-- Description: h 
-- Memo:      
[GetKinClassInfo] 224899     
*/      
--      
CREATE PROC [dbo].[GetKinClassInfo]      
 @classid int 
 ,@term nvarchar(6)     
AS      
BEGIN    
    
 select k.kname,ca.cname 
  from BasicData..class_all ca   
    inner join BasicData..kindergarten k
     on ca.kid = k.kid
    where ca.deletetag = 1
     and ca.cid=@classid
     and ca.term=@term     
END   
  


GO
