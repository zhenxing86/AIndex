USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_domain_Update]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-25
-- Description:	修改域名
-- =============================================
CREATE PROCEDURE [dbo].[site_domain_Update]
@id int,
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
		UPDATE site_domain SET domain=@domain WHERE id=@id

		IF @@ERROR <> 0
		BEGIN
			RETURN -1
		END
		ELSE
		BEGIN
			RETURN 1
		END
	END
END


GO
