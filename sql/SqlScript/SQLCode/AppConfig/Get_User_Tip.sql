set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go


--[Get_User_Tip] 288556,2
ALTER  PROCEDURE [dbo].[Get_User_Tip] 
@userid int,
@tip int
 AS 

	if(@userid in(288556,479936,295765,296418))
	begin	
		select 0	
		return
	end

	declare @admin int,@master int,@teacher int,@child int

	select @admin=[admin],@master=[master],@teacher=teacher,@child=child
		from user_tip_log
			where userid=@userid
	if(@tip=1)
	begin
		select @admin
	end
	else if(@tip=2)
	begin
		select @master
	end
	else if(@tip=3)
	begin
		select @teacher
	end
	else if (@tip=4)
	begin
		select @child
	end
	return
