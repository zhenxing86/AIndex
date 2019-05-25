USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[users_GetModel]    Script Date: 08/10/2013 10:21:40 ******/
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

SELECT 1,ID,0,bid,name FROM ossapp..users u
where  u.ID=@userid and deletetag=1 
and ((u.roleid=8 and u.bid=0) or (u.roleid=9 and u.bid>0) or u.ID=4)

end

if @tid =2
begin 
select 2,u.userid,u.kid,0,u.username from ossapp..BasicData_user u 
where  u.userid=@userid 
end
GO
