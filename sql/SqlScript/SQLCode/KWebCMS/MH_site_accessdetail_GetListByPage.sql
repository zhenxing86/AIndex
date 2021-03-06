USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_accessdetail_GetListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-26
-- Description:	获取网站上月访问排行
-- =============================================
CREATE PROCEDURE [dbo].[MH_site_accessdetail_GetListByPage]
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
			id int,
			num int
		)
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(id,num) 
		SELECT siteid,'num'=count(siteid) FROM site_accessdetail  
		WHERE DATEPART(yy,accessdatetime)=DATEPART(yy,GETDATE()) AND DATEPART(MM,accessdatetime)=DATEPART(MM,DATEADD(MM,-1,GETDATE())) 
		GROUP BY siteid ORDER BY count(siteid)

		SET ROWCOUNT @size
		SELECT siteid,'count'=num,[name],sitedns 
		FROM site JOIN @tmptable ON siteid=id 
		WHERE row > @ignore 
		ORDER BY row ASC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT a.siteid,'count'=count(a.siteid),[name],sitedns 
		FROM site s JOIN site_accessdetail a 
		ON s.siteid=a.siteid 
		GROUP BY a.siteid,s.[name],s.sitedns 
		ORDER BY count(a.siteid) DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT a.siteid,'count'=count(a.siteid),[name],sitedns 
		FROM site s JOIN site_accessdetail a 
		ON s.siteid=a.siteid 
		GROUP BY a.siteid,s.[name],s.sitedns 
		ORDER BY count(a.siteid) DESC
	END		
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_site_accessdetail_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
