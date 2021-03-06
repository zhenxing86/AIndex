USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[Teacher_Info_GetList]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
Author: xie
DataTime: 2014-09-15
Desitipation:根据kid获取老师列表
--[Teacher_Info_GetList] 12511,0,0,567195  

*/
create PROCEDURE [dbo].[Teacher_Info_GetList]   
@kid int 
as   
begin  
 select u.userid,u.[name] username,u.mobile  
   from BasicData..teacher t  
   inner join BasicData..[user] u   
    on u.userid=t.userid
   where u.kid=@kid   
    and u.deletetag=1  
    and u.usertype in (1,97)  
end  


GO
