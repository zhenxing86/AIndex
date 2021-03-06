USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[Delete_WebSite]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<along>
-- Create date: <2007-04-12>
-- Description:	<删除网站>
-- =============================================
CREATE PROCEDURE [dbo].[Delete_WebSite]	
	@Kid int
AS
declare @roleid int
declare @userid int
BEGIN
delete doc_categories_parents where categoryid in (select categoryid from doc_categories where kid = @kid)
delete doc_document_incategories where categoryid in (select categoryid from doc_categories where kid = @kid)
delete doc_document where userid in (select userid from t_staffer where kindergartenid = @kid)
delete doc_categories where kid = @kid
delete t_tree where kindergartenid = @kid
delete t_rolepermissions where roleid in (select id from t_role where kindergarten = @kid)
delete t_permissions where kindergartenid = @kid
delete t_role where kindergarten = @kid
delete articles where articlecategoryid in (select articlecategoryid from articlecategory where kid = @kid)
delete articlecategory where kid = @kid
delete t_staffer where kindergartenid = @kid
delete t_child where kindergartenid = @Kid
delete t_department where kindergartenid = @kid
delete t_class where kindergartenid =@kid
delete graduatemessage where kid = @kid
delete kinmastermessage where kid = @kid
delete friendhref where kid = @kid
delete classpagesetting where kid = @kid
delete doc_template_file where recordid not in (select recordid from doc_document)
delete doc_document_photo where recordid not in (select recordid from doc_document)
delete doc_template_bookmarks where recordid not in (select recordid from doc_document)
delete doc_version_file where recordid not in (select recordid from doc_document)
delete messageboard where kid = @kid
delete siteaccesscount where kid = @kid
delete siteaccessdetail where kid = @kid
delete t_stafferaward where kindergartenid = @kid
delete t_staffertrain where kindergartenid = @kid

delete t_kindergarten where id = @kid

delete t_userroles where userid in (
select id from t_users where id not in 
(select userid from t_staffer where kindergartenid in 
(select id from t_kindergarten)) and usertype = 1)

delete t_users where id not in 
(select userid from t_staffer where kindergartenid in 
(select id from t_kindergarten)) and usertype = 1

delete t_userroles where userid in (
select id from t_users where id not in 
(select userid from t_child where kindergartenid in 
(select id from t_kindergarten)) and usertype = 0)

delete t_users where id not in 
(select userid from t_child where kindergartenid in 
(select id from t_kindergarten)) and usertype = 0

delete t_userroles where userid in (
select id from t_users where id not in 
(select userid from t_staffer where kindergartenid in 
(select id from t_kindergarten)) and usertype = 98)

delete t_users where id not in 
(select userid from t_staffer where kindergartenid in 
(select id from t_kindergarten)) and usertype = 98


END

GO
