USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[coder_GetStoredprocedureModelInfo]    Script Date: 2014/11/24 22:59:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		HuangZhiQiang
-- Create date: 2/27/2009
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[coder_GetStoredprocedureModelInfo]
	@StoredprocedureName VarChar(128)
AS
BEGIN
	SET NOCOUNT ON;

	select   ModelInfo
	from     sys_GenerateVersion
	where    xtype = 'P'
			 and [Name] = @StoredprocedureName

END








GO
