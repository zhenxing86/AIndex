USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_kmp_graduatemessage_GetTotalList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-08
-- Description:	获取毕业留言
-- =============================================
CREATE PROCEDURE [dbo].[kweb_kmp_graduatemessage_GetTotalList]
@siteid int,
@categorytype int,
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
		INSERT INTO @tmptable(tmptableid) SELECT ID FROM kmp..GraduateMessage 
		WHERE Kid=@siteid AND (((categorytype=0 OR categorytype IS NULL) AND Status>0) OR (categorytype>0)) AND categorytype=@categorytype
		ORDER BY parentid ASC,CreateDate DESC

		SET ROWCOUNT @size
		SELECT ID,'SiteID'=Kid,[content],Title,CreateDate,IP,Status,UserName,E_Mail,ContractPhone,Address,categorytype,parentid 
		FROM kmp..GraduateMessage g join @tmptable on g.ID=tmptableid WHERE row > @ignore ORDER BY CreateDate DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT ID,'SiteID'=Kid,[content],Title,CreateDate,IP,Status,UserName,E_Mail,ContractPhone,Address,categorytype,parentid
		FROM kmp..GraduateMessage 
		WHERE Kid=@siteid AND (((categorytype=0 OR categorytype IS NULL) AND Status>0) OR (categorytype>0)) AND categorytype=@categorytype
		ORDER BY parentid ASC,CreateDate DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT ID,'SiteID'=Kid,[content],Title,CreateDate,IP,Status,UserName,E_Mail,ContractPhone,Address,categorytype,parentid
		FROM kmp..GraduateMessage 
		WHERE Kid=@siteid AND (((categorytype=0 OR categorytype IS NULL) AND Status>0) OR (categorytype>0)) AND categorytype=@categorytype
		ORDER BY parentid ASC,CreateDate DESC
	END
END









GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_kmp_graduatemessage_GetTotalList', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_kmp_graduatemessage_GetTotalList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
