USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_advertise_GetListByPage]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询广告列表 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-1-27 15:25:27
------------------------------------
CREATE PROCEDURE [dbo].[Manage_advertise_GetListByPage]
@position int,
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
		SELECT advertiseid FROM [advertise] WHERE position=@position and status=1 ORDER BY orderno ASC

		SET ROWCOUNT @size
		SELECT t1.advertiseid,t1.titile,t1.links,t1.filepath,t1.filename,t1.position,t1.filetype,t1.isshow,t1.orderno,t1.status,t1.begintime,t1.endtime,t1.createdatetime
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			[advertise] t1 ON tmptable.tmptableid=t1.advertiseid
		WHERE 
			row >  @ignore ORDER BY t1.orderno ASC
	
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
			advertiseid,titile,links,filepath,filename,position,filetype,isshow,orderno,status,begintime,endtime,createdatetime
		 FROM [advertise] WHERE position=@position and status=1 ORDER BY orderno ASC
	END
GO
