USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_graduatemessage_GetListByPage]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-06-11
-- Description:	获取毕业留言
--[kmp_graduatemessage_GetListByPage] 12511,1,17589,1,10
-- =============================================
CREATE PROCEDURE [dbo].[kmp_graduatemessage_GetListByPage] --12511,1,17589,1,10
@siteid int,
@categorytype int,
@parentid int,
@page int,
@size int
AS
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
   if(@siteid<>216)
   BEGIN 
  
	IF(@page>1)
	BEGIN
	
		
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) SELECT ID FROM kmp..GraduateMessage 
		WHERE Kid=@siteid AND 
--((categorytype=@categorytype OR categorytype IS NULL) 
--OR (categorytype>0)) AND (categorytype=@categorytype or categorytype=0)
-- AND ((parentid IS NULL AND parentid=0) OR parentid=@parentid)
parentid=@parentid
		ORDER BY CreateDate DESC

		SET ROWCOUNT @size
		SELECT ID,'SiteID'=Kid,[content],Title,CreateDate,IP,Status,UserName,E_Mail,ContractPhone,Address,categorytype,parentid,userid
		FROM kmp..GraduateMessage g join @tmptable on g.ID=tmptableid WHERE row > @ignore ORDER BY CreateDate DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT ID,'SiteID'=Kid,[content],Title,CreateDate,IP,Status,UserName,E_Mail,ContractPhone,Address,categorytype,parentid,userid
		FROM kmp..GraduateMessage 
		WHERE Kid=@siteid AND parentid=@parentid
		ORDER BY CreateDate DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT ID,'SiteID'=Kid,[content],Title,CreateDate,IP,Status,UserName,E_Mail,ContractPhone,Address,categorytype,parentid,userid
		FROM kmp..GraduateMessage 
		WHERE Kid=@siteid and parentid=@parentid
		ORDER BY CreateDate DESC
	END
 
 END
 ELSE
  BEGIN
 
	IF(@page>1)
	BEGIN
		
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) SELECT ID FROM kmp..GraduateMessage 
		WHERE Kid=@siteid  AND categorytype=@categorytype AND ((parentid IS NULL AND @parentid=0) OR parentid=@parentid)
		ORDER BY CreateDate DESC

		SET ROWCOUNT @size
		SELECT ID,'SiteID'=Kid,[content],Title,CreateDate,IP,Status,UserName,E_Mail,ContractPhone,Address,categorytype,parentid,userid
		FROM kmp..GraduateMessage g join @tmptable on g.ID=tmptableid WHERE row > @ignore ORDER BY CreateDate DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT ID,'SiteID'=Kid,[content],Title,CreateDate,IP,Status,UserName,E_Mail,ContractPhone,Address,categorytype,parentid,userid
		FROM kmp..GraduateMessage 
		WHERE Kid=@siteid AND categorytype=@categorytype AND ((parentid IS NULL AND @parentid=0) OR parentid=@parentid)
		ORDER BY CreateDate DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT ID,'SiteID'=Kid,[content],Title,CreateDate,IP,Status,UserName,E_Mail,ContractPhone,Address,categorytype,parentid,userid
		FROM kmp..GraduateMessage 
		WHERE Kid=@siteid AND ((categorytype=@categorytype OR categorytype IS NULL) OR (categorytype>0)) AND (categorytype=@categorytype or categorytype=0) AND ((parentid IS NULL AND @parentid=0) OR parentid=@parentid)
		ORDER BY CreateDate DESC
	END
  END
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_graduatemessage_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_graduatemessage_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
