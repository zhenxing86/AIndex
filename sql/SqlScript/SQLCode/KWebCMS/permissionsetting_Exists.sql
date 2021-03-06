USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[permissionsetting_Exists]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-10
-- Description:	Delete
-- =============================================
CREATE PROCEDURE [dbo].[permissionsetting_Exists]
@ptype int,
@siteid int
AS
BEGIN
	IF EXISTS (SELECT * FROM blogapp..permissionsetting WHERE ptype=@ptype AND kid=@siteid)
	BEGIN
		RETURN 1
	END
	ELSE
	BEGIN
		RETURN 0
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'permissionsetting_Exists', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
