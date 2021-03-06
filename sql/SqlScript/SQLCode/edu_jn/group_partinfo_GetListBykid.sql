USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[group_partinfo_GetListBykid]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[group_partinfo_GetListBykid]
@kid int
 AS 
	SELECT 
	pid,gid,g_kid,p_kid,p.[name],p.nickname,privince,city
,(select title from Area where ID=privince)
,(select title from Area where ID=city)
FROM [group_partinfo] p
inner join dbo.gartenlist k on p.p_kid=k.kid
where p.deletetag=1 and  p.g_kid=@kid


GO
