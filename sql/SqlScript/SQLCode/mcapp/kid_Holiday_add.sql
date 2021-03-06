USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[kid_Holiday_add]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create Procedure [dbo].[kid_Holiday_add]
@kid int,
@begdate Date, 
@enddate Date,
@Term Varchar(10),
@oper Varchar(50)
as
Set Nocount On;

if Exists (Select * From BasicData.dbo.kid_Holiday Where kid = @kid and Term = @Term)
  Update BasicData.dbo.kid_Holiday Set begdate = @begdate, enddate = @enddate Where kid = @kid and Term = @Term
else
  Insert Into BasicData.dbo.kid_Holiday(kid, begdate, enddate, Term)
    Values(@kid, @begdate, @enddate, @Term)

GO
