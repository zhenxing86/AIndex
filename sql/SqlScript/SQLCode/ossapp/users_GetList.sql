USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[users_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
--GetList  
------------------------------------  
CREATE PROCEDURE [dbo].[users_GetList]  
 @bid int  
 AS   
  
SELECT   
 1 ,g.[ID]    ,[account]    ,[password]      
,[usertype]    ,[roleid]    ,[bid]    ,g.[name]      
,[mobile]    ,g.[qq]    ,g.[remark]    ,[regdatetime]      
,g.[deletetag],r.[name],a.[name] aname    
,g.seruid,(select top 1 s.[name] from [users] s where s.ID=g.seruid)  
,(select count(1) from users_belong ub where ub.puid=g.ID)  
,(select top 1 name from dbo.agentjxs j where j.ID=g.jxsid)  
FROM [users] g  
inner join [role] r on r.ID=g.roleid  
left join agentbase a on a.ID=g.bid  
where g.deletetag=1 and g.bid=@bid  
 order by ID asc,bid asc  
GO
