USE CommonFun
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-10-16
-- Description:	函数用于去除特殊字符
-- Memo:		
*/
ALTER FUNCTION DBO.fn_delSingle(@S VARCHAR(100))
RETURNS VARCHAR(100)
AS
BEGIN
WHILE PATINDEX('%[#|]%',@S) > 0
BEGIN
set @s=stuff(@s,patindex('%[#|]%',@s),1,'')
END
RETURN @S
END
GO