USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_domain_GetListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-25
-- Description:	分页获取指定SiteID的域名
-- =============================================
CREATE PROCEDURE [dbo].[site_domain_GetListByPage]
@siteid int,
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
		INSERT INTO @tmptable(tmptableid) SELECT id FROM site_domain WHERE siteid=@siteid ORDER BY id DESC

		SET ROWCOUNT @size
		SELECT s.* FROM site_domain s join @tmptable on s.id=tmptableid WHERE row > @ignore ORDER BY id DESC
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT * FROM site_domain WHERE siteid=@siteid ORDER BY id DESC
	END	
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_domain_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_domain_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
