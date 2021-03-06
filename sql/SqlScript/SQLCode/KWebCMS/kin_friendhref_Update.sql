USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kin_friendhref_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-25
-- Description:	修改友情链接
-- =============================================
CREATE PROCEDURE [dbo].[kin_friendhref_Update]
@id int,
@caption nvarchar(30),
@href nvarchar(50)
AS
BEGIN
	UPDATE kin_friendhref SET caption=@caption,href=@href WHERE id=@id

declare @siteid int
	select @siteid=siteid from kin_friendhref where id=@id
exec [kweb_site_RefreshIndexPage] @siteid

	IF @@ERROR <> 0
	BEGIN
		RETURN -1
	END
	ELSE
	BEGIN
		RETURN 1
	END
END





GO
