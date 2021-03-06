USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[xiehebn_GetListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-03
-- Description:	分页获取站点
-- =============================================
CREATE PROCEDURE [dbo].[xiehebn_GetListByPage]
@sf nvarchar(50),
@page int,
@size int
AS
BEGIN
	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) SELECT id FROM xiehe_bn where sf=@sf ORDER BY id DESC

		SET ROWCOUNT @size
		select [id],[zfr],[dw],[bj],[zy],[img],[sf],[rq] from xiehe_bn s join @tmptable on s.id=tmptableid WHERE row > @ignore ORDER BY id DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		select [id],[zfr],[dw],[bj],[zy],[img],[sf],[rq] from xiehe_bn where sf=@sf ORDER BY id DESC
	END
	ELSE
	BEGIN
		select [id],[zfr],[dw],[bj],[zy],[img],[sf],[rq] from xiehe_bn  where sf=@sf ORDER BY id DESC
	END
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'xiehebn_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
