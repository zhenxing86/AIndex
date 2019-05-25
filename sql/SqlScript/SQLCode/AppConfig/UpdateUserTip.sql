USE [AppConfig]
GO
/****** Object:  StoredProcedure [dbo].[UpdateUserTip]    Script Date: 05/15/2013 16:40:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[Get_User_Tip] 12511,1

ALTER  PROCEDURE [dbo].[UpdateUserTip]
@userid int,
@tip int
 AS 

declare @hastip int
select @hastip = COUNT(1) from user_tip_log where userid=@userid

if(@hastip=0)
begin
	insert into user_tip_log (userid)values(@userid)
end

if(@tip=1)
begin
	update user_tip_log  
		set [admin]=1
			where userid=@userid
end
else if(@tip=2)
begin
update user_tip_log  
	set [master]=2
			where userid=@userid
end
else if(@tip=3)
begin
update user_tip_log  
	set [teacher]=3
			where userid=@userid
end
else if(@tip=4)
begin
update user_tip_log  
	set child=4
			where userid=@userid
end
	

