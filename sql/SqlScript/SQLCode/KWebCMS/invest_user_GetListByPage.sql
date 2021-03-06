USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[invest_user_GetListByPage]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-04
-- Description:	分页获取会员信息
-- =============================================
CREATE PROCEDURE [dbo].[invest_user_GetListByPage]
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
		INSERT INTO @tmptable(tmptableid) SELECT userid FROM invest_user ORDER BY userid DESC

		SET ROWCOUNT @size
		SELECT i.* FROM invest_user i join @tmptable on i.userid=tmptableid WHERE row > @ignore ORDER BY userid DESC
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT * FROM invest_user ORDER BY userid DESC
	END
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'invest_user_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
