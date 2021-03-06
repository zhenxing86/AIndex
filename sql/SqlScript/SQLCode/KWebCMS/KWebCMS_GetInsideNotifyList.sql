USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[KWebCMS_GetInsideNotifyList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-02
-- Description:	内部通知读取
-- =============================================
CREATE PROCEDURE [dbo].[KWebCMS_GetInsideNotifyList]
@page int,
@size int
AS
BEGIN
	IF(@page>1)
	BEGIN
		DECLARE @count int
		DECLARE @ignore int
		SET @count=@page*@size
		SET @ignore=@count-@size

		DECLARE @temptable TABLE
		(
			row int primary key identity(1,1),
			tempid int
		)
		
		SET ROWCOUNT @count
		INSERT INTO @temptable 
		SELECT contentid FROM cms_content 
		WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=18 AND categorycode='nbtz') and deletetag = 1
		ORDER BY contentid DESC

		SELECT [contentid],[categoryid],[title],[titlecolor],[author],[createdatetime],[searchkey],[viewcount]
		FROM cms_content,@temptable
		WHERE contentid=tempid AND row>@ignore and deletetag = 1
		ORDER BY contentid DESC		
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT [contentid],[categoryid],[title],[titlecolor],[author],[createdatetime],[searchkey],[viewcount] 
		FROM cms_content 
		WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=18 AND categorycode='nbtz') and deletetag = 1
		ORDER BY contentid DESC		
	END
	ELSE
	BEGIN
		SELECT [contentid],[categoryid],[title],[titlecolor],[author],[createdatetime],[searchkey],[viewcount] 
		FROM cms_content 
		WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=18 AND categorycode='nbtz') and deletetag = 1
		ORDER BY contentid DESC	
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'KWebCMS_GetInsideNotifyList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
