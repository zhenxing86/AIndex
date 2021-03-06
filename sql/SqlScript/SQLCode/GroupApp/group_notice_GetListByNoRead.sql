USE [KinInfoApp]
GO
/****** Object:  StoredProcedure [dbo].[group_notice_GetListByNoRead]    Script Date: 2014/11/24 23:11:00 ******/
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
 
 declare @istype int
 

select @istype=(CASE lx.role_name WHEN '管理员' then 0 when '园长' then 1 when '老师' then 2 when '医生' then 2  end) 
	from KWebCMS..site_user su
		inner join KWebCMS_Right.dbo.sac_user ux on ux.[user_id] = su.UID
		inner join KWebCMS_Right.dbo.sac_user_role rx on rx.[user_id] = ux.[user_id]
		inner join KWebCMS_Right.dbo.sac_role lx on lx.role_id=rx.role_id
	where su.appuserid =@uid
	order by (CASE lx.role_name WHEN '管理员' then 0 when '园长' then 1 when '老师' then 2 when '医生' then 2 end) desc 



select count(n.nid) from [group_notice] n
left join group_notice_state a on a.nid = n.nid  and  a.p_kid = @uid
where n.deletetag=1  
and (','+n.p_kid+',' like '%,'+convert(varchar,@uid)+',%')
and (a.deletefag=1 or a.deletefag is null) 
and (a.isread=0 or a.isread is null) 
and istype=@istype




GO
