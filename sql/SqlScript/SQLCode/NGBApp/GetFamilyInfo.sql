USE NGBApp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-08-21
-- Description:	函数用于获取家长姓名
-- Memo:		
SELECT dbo.GetFamilyInfo(295765,'Dadname')
SELECT dbo.GetFamilyInfo(295765,'MomName')
*/
CREATE FUNCTION dbo.GetFamilyInfo(@userid int,@colname varchar(50))
returns varchar(200)
as
BEGIN
	DECLARE @S varchar(200)
	SELECT @S = CASE @colname WHEN 'Dadname' then fathername WHEN 'MomName' THEN mothername end
		FROM BasicData..Child
		WHERE userid = @userid 
	RETURN @S
END
GO