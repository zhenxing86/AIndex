USE [SqlAgentDB]
GO
/****** Object:  StoredProcedure [dbo].[ClassAccessMonthTask]    Script Date: 2014/11/24 23:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      mh
-- Create date: 2014-01-14
-- Description:	
-- Paradef: select convert(varchar(20),getdate(),120)
-- Memo:	EXEC ClassAccessMonthTask
*/
create PROCEDURE [dbo].[ClassAccessMonthTask] 
AS
BEGIN

insert into classapp..class_config_month(cid,accessnum)		
select cid,accessnum from classapp..class_config 


END		


GO
