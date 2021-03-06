USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_album_GetListByPage]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：分页取相册信息 
--项目名称：ClassHomePage
--说明：
--时间：2009-3-20 10:58:57
------------------------------------
CREATE  PROCEDURE [dbo].[class_album_GetListByPage]
@classid int,
@page int,
@size int
 AS

	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @temtable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			temid bigint
		)
		
		SET ROWCOUNT @prep
		INSERT INTO @temtable(temid)
			SELECT
				albumid
			FROM
				class_album
			WHERE
				classid=@classid and status=1
			ORDER BY
				albumid DESC 

			SET ROWCOUNT @size
			SELECT t2.albumid,t2.title,t2.author,'',t2.createdatetime ,t2.classid,t2.net FROM class_album t2
        --inner join basicdata..class t3 on t2.classid=t3.cid  
		inner join @temtable t4
        ON   t2.albumid=t4.temid
        WHERE t2.classid=@classid AND row>@ignore
        ORDER BY 
			albumid DESC

	END
	ELSE
	BEGIN
		 SET ROWCOUNT @size
       SELECT albumid,title,author,'',createdatetime,t2.classid,t2.net FROM class_album t2
	 --inner join basicdata..class t3  on t2.classid=t3.cid 
       WHERE t2.classid=@classid  AND [status]=1
        ORDER BY 
			 albumid DESC
	END













GO
