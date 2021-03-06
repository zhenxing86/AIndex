USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[defaultpage_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-21
-- Description:	添加默认首页
-- =============================================
CREATE PROCEDURE [dbo].[defaultpage_Add]
@siteid int,
@defaultpage nvarchar(20),
@startdatetime datetime,
@enddatetime datetime
AS
BEGIN
	INSERT INTO defaultpage VALUES(@siteid,@defaultpage,@startdatetime,@enddatetime)

	IF @@ERROR <> 0
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN @@IDENTITY
	END
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'defaultpage_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
