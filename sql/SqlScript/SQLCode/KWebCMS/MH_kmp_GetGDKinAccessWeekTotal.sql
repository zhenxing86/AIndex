USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_kmp_GetGDKinAccessWeekTotal]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-02
-- Description:	取广东幼儿园一周排行榜
-- =============================================
CREATE PROCEDURE [dbo].[MH_kmp_GetGDKinAccessWeekTotal]
AS
BEGIN
	EXEC kmp..GetGDKinAccessWeekTotal
END



GO
