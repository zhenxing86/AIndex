USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[defaultpage_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-21
-- Description:	获取默认首页
-- =============================================
CREATE PROCEDURE [dbo].[defaultpage_GetModel]
@defaultpageid int
AS
BEGIN
	SELECT defaultpageid,siteid,defaultpage,startdatetime,enddatetime
	FROM defaultpage 
	WHERE defaultpageid=@defaultpageid
END



GO
