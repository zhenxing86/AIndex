USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_synchro_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		wuzy
-- Create date: 2010-05-26
-- Description:	获得未同步的幼儿园列表
-- =============================================
CREATE PROCEDURE [dbo].[site_synchro_GetList]
AS
	SELECT  [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[Email],[synchro] 
	FROM site
	WHERE synchro=0 OR synchro is null 

GO
