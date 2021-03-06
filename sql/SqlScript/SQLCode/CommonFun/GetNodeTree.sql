USE [CommonFun]
GO
/****** Object:  StoredProcedure [dbo].[GetNodeTree]    Script Date: 2014/11/24 22:58:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	查看相关业务节点下的对象
-- Memo:	
EXEC GetNodeTree 8
*/
CREATE PROC [dbo].[GetNodeTree]
	@NodeID INT
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Root hierarchyid
	SELECT @Root		= Node FROM NodeTree WHERE NodeID = @NodeID	
		SELECT	ol.DBName, ol.Object_id, ol.Type, ol.Name, ol.Descript, 
						ol.UpdateTime, ol.Is_FullFill, ol.Is_Abolish 
			FROM NodeTree n 
			inner join Object_Node o 
				on n.NodeID = o.NodeID
			inner join Object_List ol
				on o.DBName = ol.DBName
				and o.Object_id = ol.Object_id
			WHERE Node.IsDescendantOf(@Root) = 1;
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'查看相关业务节点下的对象  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetNodeTree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'GetNodeTree', @level2type=N'PARAMETER',@level2name=N'@NodeID'
GO
