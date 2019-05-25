USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[coder_GetTables]    Script Date: 08/28/2013 14:42:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		HuangZhiQiang
-- Create date: 2/6/2009
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[coder_GetTables]
AS
BEGIN
	SET NOCOUNT ON;

	select   [name],
			 crdate,
			 refdate
	from     sysobjects
	where    xtype = 'U'
	order by name
END
GO
