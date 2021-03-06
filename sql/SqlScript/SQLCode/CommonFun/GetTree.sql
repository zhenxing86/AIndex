USE [CommonFun]
GO
/****** Object:  StoredProcedure [dbo].[GetTree]    Script Date: 2014/11/24 22:58:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	查看相关业务节点下的对象
-- Memo:	
EXEC GetTree '数据字典'
*/
CREATE PROC [dbo].[GetTree]
	@TreeName varchar(50)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Root hierarchyid
	SELECT @Root	= Node FROM NodeTree WHERE Name = @TreeName
		SELECT	n.NodeID,n.Name, n1.NodeID ParentNodeID, n.NodeLevel
			FROM NodeTree n 
				left join NodeTree n1 on n.Node.GetAncestor(1) = n1.Node 
			WHERE n.Node.IsDescendantOf(@Root) = 1
			ORDER BY n.NodeLevel,ParentNodeID,n.NodeID;
END

GO
