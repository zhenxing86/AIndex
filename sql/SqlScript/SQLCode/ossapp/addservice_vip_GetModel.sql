USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_vip_GetModel]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[addservice_vip_GetModel]
@uid int
as 

select * from 
(

select [a1],[a2],[a3],[a4],[a5],[a6],[a7],[a8],pname
,(select top 1 info from dbo.dict where ID=a2) a2str
,(select top 1 info from dbo.dict where ID=a3) a3str
,(select top 1 info from dbo.dict where ID=a4) a4str
,(select top 1 info from dbo.dict where ID=a5) a5str
,(select top 1 info from dbo.dict where ID=a6) a6str
,(select top 1 info from dbo.dict where ID=a7) a7str
,(select top 1 info from dbo.dict where ID=a8) a8str
,ftime,ltime,u.[name],dotime,describe
,isfree,normalprice,vippaystate,[dbo].[addservice_proxysettlement](a.kid) issettlement
,a9,(select top 1 info from dbo.dict where ID=a9) a9str
,a10,(select top 1 info from dbo.dict where ID=a10) a10str
,a11,(select top 1 info from dbo.dict where ID=a11) a11str
,a12,(select top 1 info from dbo.dict where ID=a12) a12str
,a13,(select top 1 info from dbo.dict where ID=a13) a13str
 from dbo.addservice a
 inner join dbo.users u on a.userid=u.ID
 where uid=@uid
 union all 
 select [a1],[a2],[a3],[a4],[a5],[a6],[a7],[a8],pname
,(select top 1 info from dbo.dict where ID=a2)
,(select top 1 info from dbo.dict where ID=a3)
,(select top 1 info from dbo.dict where ID=a4)
,(select top 1 info from dbo.dict where ID=a5)
,(select top 1 info from dbo.dict where ID=a6)
,(select top 1 info from dbo.dict where ID=a7)
,(select top 1 info from dbo.dict where ID=a8)
,ftime,ltime,u.[name],dotime,describe
,isfree,normalprice,vippaystate,[dbo].[addservice_proxysettlement](l.kid)
,a9,(select top 1 info from dbo.dict where ID=a9)
,a10,(select top 1 info from dbo.dict where ID=a10) a10str
,a11,(select top 1 info from dbo.dict where ID=a11) a11str
,a12,(select top 1 info from dbo.dict where ID=a12) a12str
,a13,(select top 1 info from dbo.dict where ID=a13) a13str
 from dbo.addservicelog l
 inner join dbo.users u on l.userid=u.ID
 where uid=@uid
 
  union all 
 select [a1],[a2],[a3],[a4],[a5],[a6],[a7],[a8],pname
,(select top 1 info from dbo.dict where ID=a2)
,(select top 1 info from dbo.dict where ID=a3)
,(select top 1 info from dbo.dict where ID=a4)
,(select top 1 info from dbo.dict where ID=a5)
,(select top 1 info from dbo.dict where ID=a6)
,(select top 1 info from dbo.dict where ID=a7)
,(select top 1 info from dbo.dict where ID=a8)
,ftime,ltime,u.[name],dotime,describe
,isfree,normalprice,vippaystate,[dbo].[addservice_proxysettlement](l.kid)
,a9,(select top 1 info from dbo.dict where ID=a9)
,a10,(select top 1 info from dbo.dict where ID=a10) a10str
,a11,(select top 1 info from dbo.dict where ID=a11) a11str
,a12,(select top 1 info from dbo.dict where ID=a12) a12str
,a13,(select top 1 info from dbo.dict where ID=a13) a13str
 from LogData..ossapp_addservice_log l
 inner join dbo.users u on l.userid=u.ID
 where uid=@uid
  ) as p order by dotime desc


GO
