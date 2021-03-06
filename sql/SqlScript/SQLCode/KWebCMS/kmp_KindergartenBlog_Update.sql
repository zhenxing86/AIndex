USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_KindergartenBlog_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-11-24
-- Description:	幼儿园博客权限_修改
-- =============================================
CREATE PROCEDURE [dbo].[kmp_KindergartenBlog_Update]
@siteid int,
@BlogPermission int
AS
BEGIN
	IF EXISTS(SELECT * FROM kmp..T_KindergartenBlog WHERE kid=@siteid)
	BEGIN
		UPDATE kmp..T_KindergartenBlog 
		SET BlogPermission=@BlogPermission
		WHERE kid=@siteid
	END
	ELSE
	BEGIN
		INSERT INTO kmp..T_KindergartenBlog(kid,BlogPermission)
		VALUES(@siteid,@BlogPermission)
	END

	IF @@ERROR <> 0
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN 1
	END
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_KindergartenBlog_Update', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
