USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thome_remark_tmp_GetPrivateListByPage]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：查询私有评语模板列表 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-20 16:10:54
------------------------------------
CREATE PROCEDURE [dbo].[thome_remark_tmp_GetPrivateListByPage]
@userid int,
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
					id
				FROM 
					thome_remark_tmp			
				WHERE userid=@userid 
				ORDER BY id DESC	

			SET ROWCOUNT @size
			SELECT 
				t1.id,t1.remarkcontent,t1.userid
			 FROM 
				@tmptable AS tmptable		
			 INNER JOIN
 				thome_remark_tmp t1
			 ON 
				tmptable.tmptableid=t1.id 		 
			WHERE
				row>@ignore 
			
		END
		ELSE
		BEGIN
			SET ROWCOUNT @size
			SELECT 
				id,remarkcontent,userid
			FROM thome_remark_tmp
			WHERE userid=@userid 
			ORDER BY id DESC	
		END






GO
