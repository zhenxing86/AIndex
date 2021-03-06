USE [AppConfig]
GO
/****** Object:  StoredProcedure [dbo].[UpdateUserTip]    Script Date: 2014/11/24 21:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--[Get_User_Tip] 12511,1

CREATE  PROCEDURE [dbo].[UpdateUserTip]
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
else if(@tip=5)
begin
update user_tip_log  
	set class=5
			where userid=@userid
end
else if(@tip=6)
begin
update user_tip_log  
	set hut=6
			where userid=@userid
end
	



GO
