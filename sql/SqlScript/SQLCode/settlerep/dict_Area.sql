USE [settlerep]
GO
/****** Object:  StoredProcedure [dbo].[dict_Area]    Script Date: 08/10/2013 10:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[dict_Area]
 @superior int
 ,@utype int
 ,@gid int 
 ,@level int
 
 AS 

if @utype=1  --管理员、代理
begin
	if @gid=0 --管理员
	begin
		select 0,ID,Title,Code,Superior,[Level],1 from basicdata..area
		where Superior=@superior
	end
	else --代理
	begin
	
	    if @level =0 --根据找省
	    begin
			select distinct 0,a.ID,a.Title,a.Code,a.Superior,a.[Level],1 
			from  [ossapp]..[agentarea] aa
			inner join basicdata..area a on a.ID = aa.province
			where gid=@gid
		end
		else if @level =1 --根据省找市
	    begin
			select 0,aa.city,a.Title,a.Code,a.Superior,a.[Level],1 from  [ossapp]..[agentarea] aa
			inner join basicdata..area a on a.ID = aa.city
			where aa.province =@superior  and gid=@gid
		end
		else if @level =2 --根据市找县
		begin
			select 0,ID,Title,Code,Superior,[Level],1 from basicdata..area
			where Superior=@superior
		end
	end
end
else if @utype=2 --幼儿园园长
begin
   select 0,0,'','',0,0,1
end
GO
