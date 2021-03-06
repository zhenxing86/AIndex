USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[theme_GetListByPage]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：分页列出所有模板 
--项目名称：ServicePlatform
--说明：
--时间：2010-02-14 16:28:40
------------------------------------
CREATE PROCEDURE [dbo].[theme_GetListByPage]
@page int,
@size int

 AS 

	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint		
		)
	
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
			SELECT 
				themeid
			FROM 
				theme	
			WHERE status=1		
			order by
				themeid desc

		SET ROWCOUNT @size
		SELECT 
			t1.themeid,t1.themename,t1.description,t1.status,t1.thumb,t1.usecount
		 FROM 
			@tmptable AS tmptable		
		 INNER JOIN
 			theme t1
		 ON 
			tmptable.tmptableid=t1.themeid 		 
		WHERE
			row>@ignore 
		
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
			themeid,themename,description,status,thumb,usecount
		FROM theme
		where status=1
		order by themeid desc		
	END

GO
