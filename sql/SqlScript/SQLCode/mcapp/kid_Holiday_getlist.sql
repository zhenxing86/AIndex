USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[kid_Holiday_getlist]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[kid_Holiday_getlist]
@Term Varchar(10),
@kid int
as
Set Nocount On

Select a.kid, b.kname, c.name, a.begdate, a.enddate, a.Term
  From BasicData.dbo.kid_Holiday a, Ossapp.dbo.Kinbaseinfo b Left Join Ossapp.dbo.users c On b.developer = c.ID
  Where a.kid = b.kid and Term = @Term and Case WHen Isnull(@kid, 0) = 0 Then Isnull(@kid, 0) Else a.kid End = Isnull(@kid, 0) 


GO
