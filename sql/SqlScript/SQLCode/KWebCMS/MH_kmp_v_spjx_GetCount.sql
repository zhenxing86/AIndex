USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_kmp_v_spjx_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-26
-- Description:	获取精彩视频列表总数
-- =============================================
CREATE PROCEDURE [dbo].[MH_kmp_v_spjx_GetCount]
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM kmp..v_spjx
	RETURN @count
END


GO
