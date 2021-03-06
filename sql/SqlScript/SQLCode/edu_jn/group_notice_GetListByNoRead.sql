USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[group_notice_GetListByNoRead]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012/2/6 11:47:05
------------------------------------

CREATE PROCEDURE [dbo].[group_notice_GetListByNoRead]
@uid int

 AS

select count(n.nid) from [group_notice] n
left join group_notice_state a on a.nid = n.nid  and  a.p_kid = @uid
where n.deletetag=1  
and (','+n.p_kid+',' like '%,'+convert(varchar,@uid)+',%')
and (a.deletefag=1 or a.deletefag is null) 
and (a.isread=0 or a.isread is null) 

GO
