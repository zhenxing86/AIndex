USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[excel_upgrade_child_delete]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--升班导资料删除  
CREATE proc  [dbo].[excel_upgrade_child_delete]  
@id  int  
as  
begin  
declare @tb table(id int identity(1,1),userid int)  
  
 update dbo.excel_upgrade_child set deletag=0 where deletag=1 and id =@id and onepass<>1  
 if(@@ERROR<>0)  
 begin  
 return 0  
 end  
 else  
 begin  
 return 1  
 end  
end
GO
