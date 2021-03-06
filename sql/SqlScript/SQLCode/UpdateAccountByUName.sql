USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[UpdateAccountByUName]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--根据姓名修改账号 2014-7-30         
CREATE proc [dbo].[UpdateAccountByUName]        
@kid int ,        
@uname nvarchar(50),        
@account varchar(50),      
@id int=0          
as        
begin        
declare @count int,@accountflag int=0       
select @count=COUNT(1) from BasicData..[user] where kid=@kid and name=@uname and deletetag=1        
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
select @accountflag=COUNT(1) from BasicData..[user]  where account=@account   
if(@accountflag>0)    
begin    
 return -3--账号已被使用    
end    
else    
begin    
 update BasicData..[user] set account=@account where kid=@kid and name=@uname and deletetag=1       
 if(@id>0)      
 begin      
 update ossapp..excel_upgrade_child set account=@account where id=@id and uname=@uname and deletag=1      
 end     
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
