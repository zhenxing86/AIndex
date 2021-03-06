USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[coder_GetParameters]    Script Date: 08/28/2013 14:42:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		HuangZhiQiang
-- Create date: 2/6/2009
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[coder_GetParameters]
	@StoredprocedureName VarChar(128)
AS
BEGIN
	SET NOCOUNT ON;

	select   sc.Name   as Name,
			 st.Name   as Type,
			 sc.length as Length,
			 sc.xprec  as Prec,
			 sc.xscale as Scale
	from     syscolumns sc
			 inner join sysobjects so
			   on so.id = sc.id
			 inner join systypes st
			   on sc.xtype = st.xtype
	where    so.Name = @StoredprocedureName
			 and so.xtype = 'P' and st.Name != 'sysname'
	order by sc.colid asc


END
GO
