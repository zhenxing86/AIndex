USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[UserVIPServer_GetModel]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:     mh
-- Create date: 2013-08-01
-- Description:	
-- Memo:		
UserVIPServer_GetModel 236
*/
create PROCEDURE [dbo].[UserVIPServer_GetModel]
	@userid int
AS
	SET NOCOUNT ON 
	select a2,a3,a4,a5,a6,a7,a8,a9 from ossapp..addservice
		where [uid]=@userid
			and deletetag=1
			and describe='开通'
	
	
	

GO
