USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_GetList]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--鐢ㄩ€旓細鏌ヨ璁板綍淇℃伅 
--椤圭洰鍚嶇О锛?
--璇存槑锛?
--鏃堕棿锛?012/3/8 9:13:44
------------------------------------
CREATE PROCEDURE [dbo].[cms_contentattachs_GetList]
 @contentid int
 AS 

SELECT 
	1,attid    ,contentid    ,title    ,filepath    ,[filename]    ,filesize    ,filetype    ,createdatetime  	 

FROM [cms_contentattachs] g  where contentid=@contentid









GO
