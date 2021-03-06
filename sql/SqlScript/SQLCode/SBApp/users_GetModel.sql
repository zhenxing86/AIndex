USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[users_GetModel]    Script Date: 2014/11/24 23:27:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------    
    
------------------------------------    
CREATE PROCEDURE [dbo].[users_GetModel]    
@tid int,    
@userid int    
 AS     
    
if @tid =1    
begin     
    
SELECT 1,ID,0,bid,name,HealthApp.dbo.getTerm_New(58,GETDATE()),roleid FROM ossapp..users u    
where  u.ID=@userid and deletetag=1     
and (u.bid=0 or (u.roleid=9 and u.bid>0) or u.ID=4)    
    
end    
    
if @tid =2    
begin     
select 2,u.userid,u.kid,0,u.username,HealthApp.dbo.getTerm_New(u.kid,GETDATE()),99 from ossapp..BasicData_user u     
where  u.userid=@userid     
end    
    
if @tid =3    
begin     
select 3,u.userid,u.kid,0,u.name,HealthApp.dbo.getTerm_New(u.kid,GETDATE()),100 from Basicdata..[user] u     
where  u.userid=@userid and u.deletetag=1     
end 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'<p>
	用于晨检监控平台mcpt.zgyey.com
</p>
<p>
	&nbsp;
</p>
<p>
	登录后，获取登录用户信息
</p>' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'users_GetModel'
GO
