USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[sitelog_add]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		gaolao
-- Create date: 2010-12-10
-- Description:	新增幼儿园资料修改日志
-- =============================================
CREATE PROCEDURE [dbo].[sitelog_add]
@describe nvarchar(500),
@userid int
AS
BEGIN
INSERT INTO site_log(describe,operDate,userid)
VALUES(@describe,getdate(),@userid)
RETURN @@IDENTITY
END

GO
