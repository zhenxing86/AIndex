USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[defaultpage_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-21
-- Description:	修改默认首页
-- =============================================
CREATE PROCEDURE [dbo].[defaultpage_Update]
@defaultpageid int,
@defaultpage nvarchar(20),
@startdatetime datetime,
@enddatetime datetime
AS
BEGIN
	UPDATE defaultpage
	SET [defaultpage]=@defaultpage,startdatetime=@startdatetime,enddatetime=@enddatetime 
	WHERE defaultpageid=@defaultpageid

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
