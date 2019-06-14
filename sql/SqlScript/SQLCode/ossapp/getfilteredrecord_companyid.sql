USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[getfilteredrecord_companyid]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[getfilteredrecord_companyid]
@BegDate Date, 
@EndDate Date,
@companyid int
as
Set Nocount On

Select '商品' tablename, title, content, adddate, Replace(keyword, '%', '') keyword
  From ossapp.dbo.filteredrecord
  Where adddate >= @BegDate and adddate <= @EndDate and companyid = @companyid and tablename = 'product'and status = 0


GO
