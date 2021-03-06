USE [KinInfoApp]
GO
/****** Object:  StoredProcedure [dbo].[group_notice_GetModel]    Script Date: 2014/11/24 23:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






------------------------------------
--用途：得到实体对象的详细信息 
--项目名称：
--说明：
--时间：2012/2/6 11:47:05
------------------------------------
CREATE PROCEDURE [dbo].[group_notice_GetModel] 
@g_kid int
,@p_kid int
,@istype int
,@nid int
 AS 
 
 
if(@g_kid<0)--教育局的进来(@p_kid=教育局的用户名，可以查看自己发出去的)
begin

select nid,title,[content],istype,inuserid,n.intime,[username],p_kid,[dbo].[GetknameByid](p_kid)
 from [group_notice] n
where deletetag=1
and inuserid=@p_kid and nid=@nid 

end
else
begin

select 
nid,title,[content],istype,inuserid,n.intime,[username],p_kid,[dbo].[GetknameByid](p_kid)
 from [group_notice] n
where deletetag=1 and (istype=@istype or istype=0)
and ','+p_kid+',' like '%,'+convert(varchar,@p_kid)+',%'  
and nid=@nid and g_kid=0
end
 



GO
