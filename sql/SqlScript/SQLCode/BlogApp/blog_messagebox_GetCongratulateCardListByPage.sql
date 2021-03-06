USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_GetCongratulateCardListByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：取温馨贺卡列表 
--项目名称：ZGYEYBLOG
--说明：
--时间：2009-3-25 15:30:07
------------------------------------
CREATE PROCEDURE [dbo].[blog_messagebox_GetCongratulateCardListByPage]
@cardtype nvarchar(50),
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
		SELECT
			ID
		FROM
			ResourceApp.dbo.CongratulateCard
		WHERE
			cardtype=@cardtype


		SET ROWCOUNT @size
		SELECT
			ID,Title,FilePath,SmallPicPath,CardType,SendCount,createdatetime
		FROM
			@tmptable as tmptable
		INNER JOIN
			ResourceApp.dbo.CongratulateCard t1
		ON
			tmptable.tmptableid = t1.ID
		WHERE
			row > @ignore
END
ELSE
BEGIN
	SET ROWCOUNT @size
	SELECT
		ID,Title,FilePath,SmallPicPath,CardType,SendCount,createdatetime
	FROM
		ResourceApp.dbo.CongratulateCard
	where cardtype=@cardtype	
END





GO
