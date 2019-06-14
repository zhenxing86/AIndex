USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[user_tips_GetModel]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[user_tips_GetModel]
	@userid int,
	@tiptype varchar(100)
AS 
BEGIN
	SET NOCOUNT ON
	declare @result int=0
	select @result=userid from dbo.user_tips where userid=@userid and tiptype=@tiptype
	select @result
end



GO
