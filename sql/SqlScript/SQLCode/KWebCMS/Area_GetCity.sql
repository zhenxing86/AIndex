USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[Area_GetCity]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-08-08
-- Description:	Area_GetCity
-- =============================================
create PROCEDURE [dbo].[Area_GetCity]
@id int
AS
BEGIN
	SELECT ID,Title,Superior,[Level],Code FROM BasicData..Area WHERE Superior=@id
END





GO
