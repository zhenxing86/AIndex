USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[invest_user_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-04
-- Description:	获取会员总数
-- =============================================
CREATE PROCEDURE [dbo].[invest_user_GetCount]
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM invest_user
	RETURN @count
END



GO
