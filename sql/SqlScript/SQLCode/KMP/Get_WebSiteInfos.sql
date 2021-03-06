USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[Get_WebSiteInfos]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<along>
-- Create date: <2007-04-12>
-- Description:	<获取新建网站的信息>
-- =============================================
CREATE PROCEDURE [dbo].[Get_WebSiteInfos]	
	@Kid int
AS
BEGIN
select * from doc_categories where kid = @kid
select * from t_tree where kindergartenid = @kid
select * from t_role where kindergarten = @kid
select * from t_rolepermissions where roleid in (select id from t_role where kindergarten = @kid )
select * from t_permissions where kindergartenid = @kid
select * from articlecategory where kid = @kid
select * from t_users where id in  (select userid from t_staffer where kindergartenid = @kid)
select * from t_staffer where kindergartenid = @kid
select * from t_department where kindergartenid = @kid
select * from t_kindergarten where id = @kid
select * from t_class where kindergartenid = @kid
select * from t_child where kindergartenid = @kid
select * from t_stafferclass where UserID in (select userid from t_staffer where kindergartenid = @kid)
END


GO
