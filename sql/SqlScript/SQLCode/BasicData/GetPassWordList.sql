USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[GetPassWordList]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:		
*/
CREATE PROC [dbo].[GetPassWordList]
AS
Begin
	set nocount on
	select userid, password 
		from BasicData..[user] 
		where IsNeedTransferPassword = 1
	
END
GO
