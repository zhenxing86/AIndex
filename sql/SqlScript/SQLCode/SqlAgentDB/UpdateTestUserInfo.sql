USE [SqlAgentDB]
GO
/****** Object:  StoredProcedure [dbo].[UpdateTestUserInfo]    Script Date: 2014/11/24 23:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      along
-- Create date: 2013-11-02
-- Description:	
-- Paradef: 
-- Memo:	EXEC sqlagentdb..[UpdateTestUserInfo]
*/
create PROCEDURE [dbo].[UpdateTestUserInfo] 
AS
BEGIN
	SET NOCOUNT ON

update basicdata..[User]
	 set deletetag=1, 
	password='7C4A8D09CA3762AF61E59520943DC26494F8941B'
		where account in('gly','gly1','yz','yz1','ls','ls1','jz','jz1')
			and kid=12511
			
end
GO
