USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[kid_Holiday_del]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create Procedure [dbo].[kid_Holiday_del]
@kid int,
@Term Varchar(10),
@oper Varchar(50)
as
Set Nocount On;

Delete BasicData.dbo.kid_Holiday Where kid = @kid and Term = @Term


GO
