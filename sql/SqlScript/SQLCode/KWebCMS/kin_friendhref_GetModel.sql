USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kin_friendhref_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-25
-- Description:	得到友情链接实体
-- =============================================
CREATE PROCEDURE [dbo].[kin_friendhref_GetModel]
@id int
AS
BEGIN
	SELECT id,caption,href FROM kin_friendhref WHERE id=@id
END




GO
