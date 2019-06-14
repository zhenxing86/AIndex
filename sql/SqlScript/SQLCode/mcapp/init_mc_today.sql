USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[init_mc_today]    Script Date: 05/14/2013 14:54:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-04-20
-- Description:	
-- Memo: 				
*/
CREATE PROCEDURE [dbo].[init_mc_today]
	@kid int
AS 	
BEGIN
	SET NOCOUNT ON
	declare @dotime datetime 
	set @dotime = getdate()
	exec init_rep_mc_child_checked_detail_New @kid, @dotime

END
GO
