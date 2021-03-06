USE [CommonFun]
GO
/****** Object:  StoredProcedure [dbo].[Filter_Kid]    Script Date: 2014/11/24 22:58:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		

DECLARE 	@provinceid int, @cityid int, @areaid int, @kname varchar(50), @kid int, @flag int

CREATE TABLE #kid(kid int)
EXEC @flag = CommonFun.DBO.Filter_Kid -1,-1,-1,null,12511
SELECT * FROM #kid
SELECT @flag

*/
CREATE PROC [dbo].[Filter_Kid]
	@provinceid int, 
	@cityid int, 
	@areaid int, 
	@kname varchar(50), 
	@kid int
AS
BEGIN
	SET NOCOUNT ON
	IF ISNULL(@provinceid,-1) = -1 AND ISNULL(@cityid,-1) = -1 AND ISNULL(@areaid,-1) = -1 AND ISNULL(@kname,'') = '' and ISNULL(@kid,-1) = -1
	BEGIN
		RETURN -1  
	END
	ELSE
	BEGIN 
		IF @kid > 0
			INSERT INTO #kid 
				SELECT @kid
		ELSE IF ISNULL(@kname,'') <> '' 
			INSERT INTO #kid 
				select distinct kid 
					from BasicData.dbo.kindergarten 
					where kname like '%'+@kname+'%'
		ELSE IF @areaid > 0
			INSERT INTO #kid
				select distinct kid 
					from BasicData.dbo.kindergarten 
					where area = @areaid
		ELSE IF @cityid > 0
			INSERT INTO #kid
				select distinct kid 
					from BasicData.dbo.kindergarten 
					where city = @cityid
		ELSE IF @provinceid > 0
			INSERT INTO #kid
				select distinct kid 
					from BasicData.dbo.kindergarten 
					where privince = @provinceid
	END
	RETURN 1
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用于生成符合条件的Kid列表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Filter_Kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'省份ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Filter_Kid', @level2type=N'PARAMETER',@level2name=N'@provinceid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'城市ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Filter_Kid', @level2type=N'PARAMETER',@level2name=N'@cityid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'区域ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Filter_Kid', @level2type=N'PARAMETER',@level2name=N'@areaid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Filter_Kid', @level2type=N'PARAMETER',@level2name=N'@kname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Filter_Kid', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
