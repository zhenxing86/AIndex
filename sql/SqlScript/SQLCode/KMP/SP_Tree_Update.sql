USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SP_Tree_Update]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_Tree_Update]
@NodeID int,
@Text varchar(100),
@ParentID int,
@Location varchar(50),
@OrderID int,
@comment varchar(50),
@Url varchar(100),
@PermissionID int,
@ImageUrl varchar(100),
@KindergartenID int,
@Status int,
@MenuType int,
@TargetType varchar(50)
 AS 
	UPDATE T_Tree SET 
	[Text] = @Text,[ParentID] = @ParentID,[Location] = @Location,[OrderID] = @OrderID,[comment] = @comment,[Url] = @Url,[PermissionID] = @PermissionID,[ImageUrl] = @ImageUrl,[KindergartenID] = @KindergartenID,[Status] = @Status, [MenuType]=@MenuType, [TargetType]=@TargetType
	WHERE [NodeID] = @NodeID


GO
