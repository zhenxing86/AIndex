USE [AppConfig]
GO
/****** Object:  StoredProcedure [dbo].[Get_User_Tip]    Script Date: 2014/11/24 21:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--[Get_User_Tip] 86095,1
CREATE  PROCEDURE [dbo].[Get_User_Tip] 
@userid int,
@tip int
 AS 

declare @hastip int
select @hastip = COUNT(1) from user_tip_log where userid=@userid

if(@hastip=0)
begin
	insert into user_tip_log (userid)values(@userid)
end

	if(@userid in(288556,479936,295765,296418,295767,567195,466920,560725))
	begin	
		select 0	
		return
	end

	declare @admin int,@master int,@teacher int,@child int,
			@class int,@hut int

	select @admin=[admin],@master=[master],@teacher=teacher,@child=child,
			@class=class,@hut=hut
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
	else if (@tip=5)
	begin
		select @class
	end
	else if (@tip=6)
	begin
		select @hut
	end
	return



GO
