USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[excel_upgrade_child_update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--添加资料后修改导入资料中的信息  
create proc [dbo].[excel_upgrade_child_update]  
@id int  
as  
update excel_upgrade_child set nopass=0,onepass=1 where id=@id and deletag=1  
if(@@CONNECTIONS<>0)  
begin  
 return 0  
end  
else  
begin  
 return 1  
end
GO
