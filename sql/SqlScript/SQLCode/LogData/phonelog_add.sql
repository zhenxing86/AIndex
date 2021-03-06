USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[phonelog_add]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		gaolao
-- Create date: 2010-12-15
-- Description:	手机号码修改日志
-- =============================================
CREATE PROCEDURE [dbo].[phonelog_add]
@describe nvarchar(500),
@userid int,
@type int
AS
BEGIN
INSERT INTO phone_log(describe,operDate,userid,[type])
VALUES(@describe,getdate(),@userid,@type)
RETURN @@IDENTITY
END

GO
