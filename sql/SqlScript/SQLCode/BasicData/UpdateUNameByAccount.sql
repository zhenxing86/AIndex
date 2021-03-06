USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[UpdateUNameByAccount]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--根据账号修改姓名 2014-7-30      
CREATE proc [dbo].[UpdateUNameByAccount]      
@kid int ,      
@uname nvarchar(50),      
@account varchar(50),  
@id int=0      
as      
begin      
declare @count int      
select @count=COUNT(1) from BasicData..[user] where kid=@kid and account=@account and deletetag=1      
if(@count<1)      
 begin      
  return -1--找不到      
 end      
else if(@count>1)      
begin      
 return -2--找到多条记录      
end      
else       
begin      
 update BasicData..[user] set name=@uname where kid=@kid and account=@account and deletetag=1   
 if(@id>0)  
 begin  
 update ossapp..excel_upgrade_child set uname=@uname where id=@id and account=@account and deletag=1  
 end     
end      
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
