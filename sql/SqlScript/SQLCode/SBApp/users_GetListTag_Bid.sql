USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[users_GetListTag_Bid]    Script Date: 2014/11/24 23:27:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
------------------------------------  
--select * from [role]  
------------------------------------  
CREATE PROCEDURE [dbo].[users_GetListTag_Bid]  
 @page int  
,@size int  
,@bid int   
,@infofrom varchar(100)  
 AS   
  
declare @pcount int,@infofrom1 varchar(100)  
  
if @infofrom='0'  
begin  
 set @infofrom1='全部'  
end  
else if @infofrom='1'  
begin  
 set @infofrom1='市场人员'  
end  
else if @infofrom='2'  
begin  
 set @infofrom1='客服人员'  
end  
else if @infofrom='3'  
begin  
 set @infofrom1=''  
end  
  
SELECT g.[ID] ,g.[name],g.roleid    
FROM ossapp..users g   
inner join ossapp..[role] r on r.ID=g.roleid  
left join ossapp..agentbase a on a.ID=g.bid  
where g.deletetag=1  
 and bid=@bid and (r.[name] =@infofrom1 or @infofrom1='')  
 order by ID asc,bid asc  
  
  
  
  
  
GO
