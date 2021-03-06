USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_GetClassIDBySiteID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-29
-- Description:	获取班级ID
-- =============================================
CREATE PROCEDURE [dbo].[kmp_GetClassIDBySiteID]
@siteid int
AS
BEGIN
	DECLARE @classid int
	SELECT @classid=id FROM kmp..t_class WHERE kindergartenid=@siteid AND status=1
	IF @classid IS NULL
	BEGIN
		SET @classid=0
	END
	RETURN @classid
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_GetClassIDBySiteID', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
