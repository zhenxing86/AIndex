USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[TransferPassWord]    Script Date: 2014/11/24 21:18:47 ******/
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
CREATE PROC [dbo].[TransferPassWord]
	@userid int,
	@password nvarchar(50)
AS
Begin
	set nocount on
	IF EXISTS(SELECT * FROM  BasicData..[user] WHERE userid = @userid AND IsNeedTransferPassword = 1)
	begin
		UPDATE BasicData..[user]
			set password = @password,
					IsNeedTransferPassword = null
		where userid = @userid
	end
END
GO
