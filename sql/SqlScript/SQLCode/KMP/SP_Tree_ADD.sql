USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SP_Tree_ADD]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_Tree_ADD]
@NodeID int ,
@Text varchar(100) ,
@ParentID int ,
@Location varchar(50) ,
@OrderID int ,
@comment varchar(50) ,
@Url varchar(100) ,
@PermissionID int ,
@ImageUrl varchar(100) ,
@KindergartenID int ,
@Status int ,
@MenuType int,
@TargetType varchar(50)
 AS 
	INSERT INTO T_Tree(
	[NodeID],[Text],[ParentID],[Location],[OrderID],[comment],[Url],[PermissionID],[ImageUrl],[KindergartenID],[Status],[MenuType],[TargetType]
	)VALUES(
	@NodeID,@Text,@ParentID,@Location,@OrderID,@comment,@Url,@PermissionID,@ImageUrl,@KindergartenID,@Status, @MenuType,@TargetType
	)
GO
