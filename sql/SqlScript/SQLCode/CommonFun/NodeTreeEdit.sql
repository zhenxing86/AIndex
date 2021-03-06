USE [CommonFun]
GO
/****** Object:  StoredProcedure [dbo].[NodeTreeEdit]    Script Date: 2014/11/24 22:58:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	新增、删除、移动节点
-- Memo:	
EXEC NodeTreeEdit @Type = 2, @ID = 9, @Name = 'D', @NewID = 4
SELECT NODE.ToString() 层次结构,* from NodeTree	
*/
create PROC [dbo].[NodeTreeEdit]
	@Type int, --0新增子节点，1新增平行节点, 2删除某节点及其子节点, 3移动某个节点, 4移动某个节点下的子节点
	@ID INT,
	@NewID INT = null,
	@Name varchar(50) = null
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Root hierarchyid,@NewRoot hierarchyid
	IF @Type IN(0,1)
	BEGIN
		SELECT @Root = Node.GetAncestor(@Type) 
			FROM NodeTree
			WHERE NodeID = @ID;

		INSERT NodeTree(Node,Name)
			VALUES(@Root.GetDescendant(@Root.ToString() + CAST(dbo.fn_GetMaxNodeID() as varchar(20)) + '/', NULL), @Name)
	END
	ELSE IF @Type = 2
	BEGIN
		SELECT @Root		= Node FROM NodeTree WHERE NodeID = @ID	
		DELETE NodeTree
			WHERE Node.IsDescendantOf(@Root) = 1;
	END
	ELSE IF @Type IN(3,4)
	BEGIN
		SELECT @Root		= Node FROM NodeTree WHERE NodeID = @ID		
		SELECT @NewRoot	= Node FROM NodeTree WHERE NodeID = @NewID
		IF @Type = 3
		UPDATE NodeTree 
			SET Node = Node.GetReparentedValue(@Root.GetAncestor(1), @NewRoot)
			WHERE Node.IsDescendantOf(@Root) = 1
		ELSE IF @Type = 4
		UPDATE NodeTree 
			SET Node = Node.GetReparentedValue(NODE.GetAncestor(1), @NewRoot)
			WHERE Node.IsDescendantOf(@Root) = 1
				AND Node <> @Root
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新增、删除、移动节点  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'NodeTreeEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0新增子节点，1新增平行节点, 2删除某节点及其子节点, 3移动某个节点, 4移动某个节点下的子节点' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'NodeTreeEdit', @level2type=N'PARAMETER',@level2name=N'@Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'NodeTreeEdit', @level2type=N'PARAMETER',@level2name=N'@ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新节点ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'NodeTreeEdit', @level2type=N'PARAMETER',@level2name=N'@NewID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'节点名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'NodeTreeEdit', @level2type=N'PARAMETER',@level2name=N'@Name'
GO
