USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[T_Kindergarten_Update]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		wuzy
-- Create date: 2010-12-19
-- Description:	班级主页获取水印和是否允许加入幼儿园
-- =============================================
CREATE PROCEDURE [dbo].[T_Kindergarten_Update]
@kid int,
@denycreateclass int,
@classphotowatermark nvarchar(50)
AS
UPDATE T_Kindergarten SET denycreateclass=@denycreateclass,classphotowatermark=@classphotowatermark WHERE id=@kid
IF(@@ERROR<>0)
BEGIN
	RETURN(-1)
END
ELSE
BEGIN
	RETURN(1)
END

GO
