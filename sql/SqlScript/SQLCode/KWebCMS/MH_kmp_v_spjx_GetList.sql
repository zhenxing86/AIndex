USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_kmp_v_spjx_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-26
-- Description:	获取精彩视频列表
-- =============================================
CREATE PROCEDURE [dbo].[MH_kmp_v_spjx_GetList]
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
			row int IDENTITY (1, 1),
			PhotoUrl nvarchar(300),
			Url nvarchar(500),
			Title nvarchar(100)
		)
		SET ROWCOUNT @prep
		INSERT @tmptable (PhotoUrl,Url,Title) 
		SELECT PhotoUrl,Url,Title FROM kmp..v_spjx

		SELECT PhotoUrl,Url,Title FROM @tmptable WHERE row>@ignore
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT PhotoUrl,Url,Title FROM kmp..v_spjx
	END
	ELSE
	BEGIN
		SELECT PhotoUrl,Url,Title FROM kmp..v_spjx
	END
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_kmp_v_spjx_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
