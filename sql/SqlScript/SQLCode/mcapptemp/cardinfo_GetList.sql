USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[cardinfo_GetList]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-09-10
-- Description:	
-- Memo:		
*/
CREATE PROCEDURE [dbo].[cardinfo_GetList]
	@kid int,
	@usest int
 AS 
BEGIN 
	SET NOCOUNT ON
	if(@usest=0)
	begin
		select cardno  
			FROM cardinfo g 
			where kid = @kid 
				and usest = 0
	end 
	else if(@usest=1)	
	begin
		select c.cardno 
			from cardinfo c
				inner join BasicData..User_Child uc 
					on c.userid = uc.userid
			where c.kid = @kid 
				and c.usest=1 
	end
	else if(@usest=2)	
	begin
	select c.cardno 
		from cardinfo c
			inner join BasicData..User_Teacher ut 
				on c.userid = ut.userid
		where c.kid = @kid 
			and c.usest=1 
	end
END

GO
