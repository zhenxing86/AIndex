USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[CreateActivationCodeBatch]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- =============================================
-- Author:		Master谭
-- Create date: 2014-02-18
-- Description:	批量生成激活码
-- Memo:	
CreateActivationCodeBatch 2000
*/
CREATE PROCEDURE [dbo].[CreateActivationCodeBatch]
	@Num int 
AS
BEGIN
	SET NOCOUNT ON;
	select left(REPLACE(NEWID(),'-',''),10) Code 
	INTO #TA
	from CommonFun..Nums1W 
	INSERT INTO ActivationCode(CodeNo)
	output inserted.CodeNo
	SELECT top(@Num)Code
		FROM #TA t
		where not exists(select * from ActivationCode where CodeNo = t.Code)
END

GO
