USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[get_mc_content]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_mc_content]  
	@kid int,  
	@cid int,  
	@checktime1 datetime  
as
BEGIN  
SET NOCOUNT ON
	IF @cid = -1 
	select rm.formatecontent as content 
		from record_mc_kid_day rm
		where rm.kid = @kid 
			and rm.cdate = @checktime1
	ELSE
		select rm.formatecontent 
		from rep_mc_class_checked_sum rm
		where rm.kid = @kid 
			and rm.cid = @cid
			and rm.cdate = @checktime1

END 

GO
