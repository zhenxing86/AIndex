USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_domain_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-25
-- Description:	添加域名
-- =============================================
CREATE PROCEDURE [dbo].[site_domain_Add]
@siteid int,
@domain nvarchar(100)
AS
BEGIN
	IF EXISTS(SELECT * FROM site_domain WHERE domain=@domain)
	BEGIN
		RETURN 0
	END
	ELSE IF EXISTS(SELECT * FROM site WHERE sitedns=@domain)
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		INSERT INTO site_domain VALUES(@siteid,@domain)

		IF @@ERROR <> 0
		BEGIN
			RETURN -1
		END
		ELSE
		BEGIN
			RETURN @@IDENTITY
		END
	END
END





GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_domain_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
