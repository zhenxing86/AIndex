USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[users_Exist]    Script Date: 2014/11/24 23:27:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[users_Exist]  
 @account varchar(100)  
, @password varchar(100)  
 AS   
  
declare @p int,@r int  
  
set @p=0  
set @r = 0  
SELECT @p =ID FROM ossapp..users u  
where  account=@account and password=@password and deletetag=1  
and (u.bid=0 or (u.roleid=9 and u.bid>0) or u.id=4)  
  
if @p>0  
begin  
   set @r =1  
end  
else  
begin  
 select @p =u.userid from ossapp..BasicData_user u where account=@account and pwd=@password  
 if @p>0  
 begin  
  set @r =2  
 end  
end  
  
select @r,@p  


SELECT * FROM ossapp..users u  
where  deletetag=1  
and ((u.roleid=8 and u.bid=0) or (u.roleid=9 and u.bid>0) or u.id=4) 
  
  
GO
