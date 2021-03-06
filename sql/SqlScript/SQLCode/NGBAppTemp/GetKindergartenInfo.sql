USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[GetKindergartenInfo]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      along
-- Create date: 2013-09-15
-- Description:	get_kindergarten表
-- Memo:		
exec [GetKindergartenInfo] 12511
*/
create PROC [dbo].[GetKindergartenInfo]
	@kid int	
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT NGB_Descript,NGB_Pic
		FROM BasicData..kindergarten
			WHERE kid=@kid	
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'读取幼儿园信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetKindergartenInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetKindergartenInfo', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
