USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[zxbm_namecheck]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create PROCEDURE [dbo].[zxbm_namecheck]
@name nvarchar(50)
AS
BEGIN
    DECLARE @count int
    SELECT @count=count(*) FROM zxbm
	WHERE name=@name
    RETURN @count
END







GO
