USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[UpdateMZSPMenu]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<along>
-- Create date: <2007-07-26>
-- Description:	<更新每周食谱>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateMZSPMenu]

@Kid int
AS
BEGIN
declare @TreeMaxID int
declare @PermissionID int
declare @KinManageRoleID int
declare @TeacherRoleID int
declare @ParentID int
declare @WeekFoodList int



    SELECT @KinManageRoleID=ID FROM T_Role WHERE (Name = '管理员') and (kindergarten = @Kid)
    SELECT @TeacherRoleID=ID FROM T_Role WHERE (Name = '老师') and (kindergarten = @Kid)    
    SELECT @ParentID = NodeID FROM T_Tree WHERE (Text = '家园互动') AND (KindergartenID = @Kid)
	--获取菜单树ID
			select @TreeMaxID = max(NodeID)+1 from T_Tree
		   --新增角色权限
		   INSERT INTO [T_Permissions]([Code],[Title],[CategoriesID],[KindergartenID])
			 VALUES(@TreeMaxID,'每周食谱',6,@Kid)
		   --获取权限ID	
			Select @PermissionID = @@IDENTITY
			INSERT INTO [T_RolePermissions]([RoleID],[PermissionID])
			 VALUES(@KinManageRoleID,@PermissionID)--管理员权限
			INSERT INTO [T_RolePermissions]([RoleID],[PermissionID])
			 VALUES(@TeacherRoleID,@PermissionID)--老师权限
		   --新增菜单树 
			INSERT INTO [T_Tree]([NodeID],[Text],[ParentID],[ParentPath],[Location],[OrderID],[comment],[Url],[PermissionID],[ImageUrl],[KindergartenID],[Status],[MenuType],[TargetType])
			VALUES(@TreeMaxID,'每周食谱',@ParentID,null,convert(nvarchar, @ParentID)+'.2',2,'自动生成','DocManage/docCookbookList.aspx?CategoryID='+convert(nvarchar, @TreeMaxID),@PermissionID,'Images/MenuImg/folder16.gif',@Kid,1,0,'destopFrame')
		   --新增文档目录树 
			INSERT INTO doc_Categories (CategoryID, Name, IsEnabled, ParentID, [Description], [Path], KID, IsLock, AttachType, ShowProperty,IsCommonMenu)
			VALUES (@TreeMaxID, '每周食谱', 1, @ParentID, '自动生成', '/'+convert(nvarchar, @ParentID)+'/'+convert(nvarchar, @TreeMaxID)+'/', @Kid, 1, 0, 0, 0)
			Select @WeekFoodList = @TreeMaxID
			
			update [ClassPageSetting] set [WeekFoodList] = @WeekFoodList where KID = @Kid
			
			EXEC dbo.doc_Categories_Parents_RebuildIndex
			update articlecategory set categorytype = 6 where kid  = @Kid and typecode = 'mzsp'
END


GO
