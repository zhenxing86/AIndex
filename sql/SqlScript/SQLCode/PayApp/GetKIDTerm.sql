USE [PayApp]
GO
/****** Object:  StoredProcedure [dbo].[GetKIDTerm]    Script Date: 2014/11/24 23:23:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================      
-- Author:  蔡杰
-- Create date: 2014-04-004      
-- Description:园长用阅读计划结算获取学期
-- =============================================      
CREATE PROCEDURE [dbo].[GetKIDTerm]      
@kid int      
AS      
SET NOCOUNT ON;      

Declare @Term Table (Term Varchar(50))
Insert Into @Term
  Select a.Term
    From BasicData.dbo.Springday a, BasicData.dbo.kindergarten b
    Where a.sdate > b.actiondate and a.sdate <= GETDATE() and b.kid = @kid

Insert Into @Term 
  Select Cast(Cast(Replace(Term, '-0', '') as Int) - 1 as Varchar) + '-1' From @Term

if MONTH(Getdate()) > 9
  Insert Into @Term 
    Select CAST(Year(getdate()) as Varchar) + '01'

Select Distinct Term From @Term Order by Term Desc

  
GO
