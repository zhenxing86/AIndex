USE CommonFun
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master̷
-- Create date: 
-- Description:	
-- Memo:		
*/
create function fn_GetMaxNodeID()
returns int
as
begin
	DECLARE @NodeID INT
	SELECT @NodeID = MAX(NodeID) FROM NodeTree
	RETURN @NodeID
end
GO