USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[kid_Holiday_getModel]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[kid_Holiday_getModel]
@kid Int,
@Term Varchar(10)
as
Set Nocount On

Select a.kid, a.begdate, a.enddate, a.Term
  From BasicData.dbo.kid_Holiday a
  Where a.kid = @kid and a.Term = @Term


GO
