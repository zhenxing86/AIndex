USE CommonFun
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- =============================================
-- Author:		Master谭
-- Create date: 2014-2-8
-- Description:	函数用于判断电话号码的网络服务商 0移动，1电信，2联通，-1异常
-- Memo:	2014-2-8 创建
*/
CREATE FUNCTION fn_cellphoneNet(@s nvarchar(50))
RETURNS int
AS
BEGIN
	DECLARE @Result int
	IF commonfun.dbo.fn_RegExMatch(@s, N'^(0|\+86)?(134|135|136|137|138|139|147|150|151|152|157|158|159|182|183|187|188|184)\d{8}$') = 1  
	SET @Result = 0
	ELSE IF commonfun.dbo.fn_RegExMatch(@s, N'^(0|\+86)?(133|153|180|181|189)\d{8}$') = 1  
	SET @Result = 1
	ELSE IF commonfun.dbo.fn_RegExMatch(@s, N'^(0|\+86)?(130|131|132|155|156|185|186|145)\d{8}$') = 1  
	SET @Result = 2
	ELSE  
	SET @Result = -1

	RETURN @Result

END
GO

