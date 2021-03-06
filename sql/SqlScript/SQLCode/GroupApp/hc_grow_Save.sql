USE [HealthApp]
GO
/****** Object:  StoredProcedure [dbo].[hc_grow_Save]    Script Date: 2014/11/24 23:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
CREATE Procedure [dbo].[hc_grow_Save]
@userid bigint,
@indate date,
@height float,
@weight float
as
Set Nocount On

if Not Exists (Select * From hc_grow Where userid = @userid and indate = @indate)
  Insert Into hc_grow(userid, indate, height, weight)
    Select @userid, @indate, @height, @weight
else
  Update hc_grow Set height = @height, weight = @weight, deletetag = 1
    Where userid = @userid and indate = @indate

if @@ROWCOUNT > 0 
  Select 1
else 
  Select 0
  


GO
