USE [SqlAgentDB]
GO
/****** Object:  StoredProcedure [dbo].[config_manage_init]    Script Date: 2014/11/24 23:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      along
-- Create date: 2013-08-02
-- Description:	
-- Paradef: select convert(varchar(20),getdate(),120)
-- Memo:	EXEC config_manage_init
*/
CREATE PROCEDURE [dbo].[config_manage_init] 
AS
BEGIN

	update ossapp..config_manage set syn=1 where syn=0

END		


GO
