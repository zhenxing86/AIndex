USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[LoginUser_Info_GetModel]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
Author: xie
DataTime: 2014-09-15
Desitipation:根据userid获取老师登录信息
select * from blogapp..permissionsetting where ptype = 100

[LoginUser_Info_GetModel] 567195  

*/
CREATE PROCEDURE [dbo].[LoginUser_Info_GetModel]   
@userid int 
as   
begin  
 declare @usertype int = CommonFun.dbo.[fn_KWebCMS_Right_max](@userid)
 select u.kid,u.userid,u.[name] username,@usertype usertype,ISNULL(ptype,0) openWebSms
   from BasicData..[user] u 
    left join blogapp..permissionsetting p 
     on p.kid = u.kid and p.ptype= 100
    --left join KWebCMS.dbo.site_config s
    -- on u.kid = s.siteid   
    where u.userid = @userid
end  


GO
