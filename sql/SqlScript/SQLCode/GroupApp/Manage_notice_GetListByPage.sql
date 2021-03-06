USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_notice_GetListByPage]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询通知 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-2-23 16:50:46
------------------------------------
CREATE PROCEDURE [dbo].[Manage_notice_GetListByPage]
@status int,
@page int,
@size int
 AS 
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
		INSERT INTO @tmptable(tmptableid)
		SELECT noticeid FROM [notice] WHERE  status=@status ORDER BY orderno DESC,createdatetime DESC

		SET ROWCOUNT @size
			SELECT 	noticeid,title,author,titlecolor,content,createdatetime,viewcount,orderno,status
			FROM [notice] t1 INNER JOIN @tmptable as tmptable ON t1.noticeid=tmptable.tmptableid
			WHERE
				row>@ignore ORDER BY t1.orderno DESC,t1.createdatetime DESC	

	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		noticeid,title,author,titlecolor,content,createdatetime,viewcount,orderno,status
		 FROM [notice] WHERE status=@status ORDER BY orderno DESC,createdatetime DESC
	END


GO
