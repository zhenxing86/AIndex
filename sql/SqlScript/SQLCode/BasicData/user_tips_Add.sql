USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_tips_Add]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--[user_tips_Add] 295767,'newgb_tip'
CREATE PROCEDURE [dbo].[user_tips_Add]
	@userid int,
	@tiptype varchar(100)
AS 
BEGIN
	SET NOCOUNT ON
	insert into user_tips (userid,tiptype)
	select @userid,@tiptype where not exists(select 1 from user_tips
	where userid=@userid and tiptype=@tiptype)
	
end




GO
