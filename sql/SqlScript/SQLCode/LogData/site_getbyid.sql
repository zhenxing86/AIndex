USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[site_getbyid]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		gaolao
-- Create date: 2011-1-6
-- Description:	获取学校名称
-- =============================================
CREATE PROCEDURE [dbo].[site_getbyid]
@siteid int
AS
SELECT siteid,[name]
FROM KWebCMS..site
WHERE siteid=@siteid

GO
