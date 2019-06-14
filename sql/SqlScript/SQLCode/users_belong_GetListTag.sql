USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[users_belong_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--GetListTag
------------------------------------
CREATE PROCEDURE [dbo].[users_belong_GetListTag]
 @page int
,@size int
,@uid int
,@bid int
 AS 



select 1,b.[ID],b.[puid],u.ID [cuid]
,r.[duty],b.[uid],u.[bid],b.[intime] ,b.[deletetag],u.[name]   
from users u
inner join [role] r on r.ID=u.roleid
left join users_belong b on u.ID=b.cuid and b.deletetag=1
where u.bid=@bid and u.ID <>@uid 


GO
