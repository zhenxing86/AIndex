USE BackupApp
GO
--drop table BackupApp..TableInfo


CREATE TABLE BackupWebInfo(kid int NOT NULL, VersionNo int NOT NULL, BackupDate datetime default getdate())
ALTER TABLE dbo.BackupWebInfo ADD CONSTRAINT	PK_BackupWebInfo PRIMARY KEY CLUSTERED(	kid,VersionNo	) WITH( IGNORE_DUP_KEY = ON) ON [PRIMARY]
CREATE TABLE BackupInnerTable(DBName varchar(125) NOT NULL, TBName varchar(125) NOT NULL)
ALTER TABLE dbo.BackupInnerTable ADD CONSTRAINT	PK_BackupInnerTable PRIMARY KEY CLUSTERED(DBName,TBName	) WITH( IGNORE_DUP_KEY = ON) ON [PRIMARY]
INSERT INTO BackupInnerTable(DBName,TBName)SELECT 'Basicdata','USER'
INSERT INTO BackupInnerTable(DBName,TBName)SELECT 'BlogApp','blog_baseconfig'
INSERT INTO BackupInnerTable(DBName,TBName)SELECT 'BasicData','user_bloguser'


CREATE TABLE BackupApp..TableInfo(	DBName varchar(125) NOT NULL, TBName varchar(125) NOT NULL, Keystr varchar(200) NOT NULL, 
												FilStr varchar(2000) NOT NULL, VersionCtrl varchar(2000) DEFAULT '' NOT NULL, IsCanDel bit NOT NULL default 0)
Alter Table BackupApp..TableInfo add constraint  pk_TableInfo primary key(DBName,TBName)with (IGNORE_DUP_KEY = ON)

INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl )
SELECT 'Basicdata','user_baseinfo','userid', 'INNER JOIN BASICDATA..[USER] b on a.userid = b.userid and b.kid = @kid',' AND a.VersionNo = b.VersionNo '
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl)
SELECT 'Basicdata','user','userid', 'WHERE a.kid = @kid' ,' '
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl )
SELECT 'Basicdata','child','userid', 'INNER JOIN BASICDATA..[USER] b on a.userid = b.userid and b.kid = @kid',' AND a.VersionNo = b.VersionNo '
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl )
SELECT 'Basicdata','teacher','userid', 'INNER JOIN BASICDATA..[USER] b on a.userid = b.userid and b.kid = @kid',' AND a.VersionNo = b.VersionNo '
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl )
SELECT 'Basicdata','ChildDetails','ID', 'INNER JOIN BASICDATA..[USER] b on a.uid = b.userid and b.kid = @kid',' AND a.VersionNo = b.VersionNo '
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl )
SELECT 'Basicdata','TeacherDetails','ID', 'INNER JOIN BASICDATA..[USER] b on a.uid = b.userid and b.kid = @kid',' AND a.VersionNo = b.VersionNo '
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl )
SELECT 'Basicdata','user_bloguser','bloguserid', 'INNER JOIN BASICDATA..[USER] b on a.userid = b.userid and b.kid = @kid',' AND a.VersionNo = b.VersionNo '
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl )
SELECT 'Basicdata','user_bloguser','bloguserid', 'INNER JOIN BASICDATA..[USER] b on a.userid = b.userid and b.kid = @kid',' AND a.VersionNo = b.VersionNo '
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl )
SELECT 'Basicdata','user_class','userid,cid', 'INNER JOIN BASICDATA..[USER] b on a.userid = b.userid and b.kid = @kid',' AND a.VersionNo = b.VersionNo '
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl )
SELECT 'Basicdata','class','cid', 'WHERE a.kid = @kid',' '
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl )
SELECT 'Basicdata','department','did', 'WHERE a.kid = @kid',' '
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'Basicdata','user_kindergarten','userid', 'WHERE a.kid = @kid',' ', 0



INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'BlogApp','album_categories','categoriesid', 'INNER JOIN BasicData..user_bloguser b on a.userid = b.bloguserid inner join BasicData..[user] c on b.userid = c.userid and c.kid = @kid',' AND a.VersionNo = b.VersionNo AND a.VersionNo = c.VersionNo ', 0
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'BlogApp','blog_baseconfig','userid', 'INNER JOIN BasicData..user_bloguser b on a.userid = b.bloguserid inner join BasicData..[user] c on b.userid = c.userid and c.kid = @kid',' AND a.VersionNo = b.VersionNo AND a.VersionNo = c.VersionNo ', 0
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'BlogApp','blog_posts','postid', 'INNER JOIN BasicData..user_bloguser b on a.userid = b.bloguserid inner join BasicData..[user] c on b.userid = c.userid and c.kid = @kid',' AND a.VersionNo = b.VersionNo AND a.VersionNo = c.VersionNo ', 0
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'BlogApp','blog_friendapply','friendapplyid', 'INNER JOIN BasicData..user_bloguser b on a.sourceuserid = b.bloguserid inner join BasicData..[user] c on b.userid = c.userid and c.kid = @kid',' AND a.VersionNo = b.VersionNo AND a.VersionNo = c.VersionNo ', 0
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'BlogApp','blog_friendlist','userid,frienduserid', 'INNER JOIN BasicData..user_bloguser b on a.userid = b.bloguserid inner join BasicData..[user] c on b.userid = c.userid and c.kid = @kid',' AND a.VersionNo = b.VersionNo AND a.VersionNo = c.VersionNo ', 0
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'BlogApp','blog_hotposts','hotpostid', 'inner join BlogApp..blog_posts b on a.postid = b.postid INNER JOIN BasicData..user_bloguser c on b.userid = c.bloguserid inner join BasicData..[user] d on d.userid = c.userid and d.kid = @kid',' AND a.VersionNo = b.VersionNo AND a.VersionNo = c.VersionNo AND a.VersionNo = d.VersionNo  ', 0
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'BlogApp','blog_collection','collectionid', 'inner join BlogApp..blog_posts b on a.postid = b.postid INNER JOIN BasicData..user_bloguser c on b.userid = c.bloguserid inner join BasicData..[user] d on d.userid = c.userid and d.kid = @kid',' AND a.VersionNo = b.VersionNo AND a.VersionNo = c.VersionNo AND a.VersionNo = d.VersionNo  ', 0

INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'BlogApp','blog_messageboard','messageboardid', 'INNER JOIN BasicData..user_bloguser b on a.userid = b.bloguserid inner join BasicData..[user] c on b.userid = c.userid and c.kid = @kid',' AND a.VersionNo = b.VersionNo AND a.VersionNo = c.VersionNo ', 0
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'BlogApp','blog_messagebox','messageboxid', 'INNER JOIN BasicData..user_bloguser b on a.fromuserid = b.bloguserid inner join BasicData..[user] c on b.userid = c.userid and c.kid = @kid',' AND a.VersionNo = b.VersionNo AND a.VersionNo = c.VersionNo ', 0
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'BlogApp','blog_postscategories','categoresid', 'INNER JOIN BasicData..user_bloguser b on a.userid = b.bloguserid inner join BasicData..[user] c on b.userid = c.userid and c.kid = @kid',' AND a.VersionNo = b.VersionNo AND a.VersionNo = c.VersionNo ', 0
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'BlogApp','blog_postscategories','categoresid', 'INNER JOIN BasicData..user_bloguser b on a.userid = b.bloguserid inner join BasicData..[user] c on b.userid = c.userid and c.kid = @kid',' AND a.VersionNo = b.VersionNo AND a.VersionNo = c.VersionNo ', 0
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'BlogApp','blog_postscomments','commentsid', 'inner join BlogApp..blog_posts b on a.postsid = b.postid INNER JOIN BasicData..user_bloguser c on b.userid = c.bloguserid inner join BasicData..[user] d on d.userid = c.userid and d.kid = @kid',' AND a.VersionNo = b.VersionNo AND a.VersionNo = c.VersionNo AND a.VersionNo = d.VersionNo  ', 0
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'BlogApp','album_photos','photoid', 'INNER JOIN BlogApp..album_categories b on a.categoriesid = b.categoriesid INNER JOIN BasicData..user_bloguser c on b.userid = c.bloguserid inner join BasicData..[user] d on c.userid = d.userid and d.kid = @kid',' AND a.VersionNo = b.VersionNo AND a.VersionNo = c.VersionNo AND a.VersionNo = d.VersionNo ', 0
	
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'ClassApp','class_album','albumid',  'WHERE a.kid = @kid' ,' ',0 
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'ClassApp','class_article','articleid',  'WHERE a.kid = @kid' ,' ',0 
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'ClassApp','class_backgroundmusic','id',  'WHERE a.kid = @kid' ,' ',0 
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'ClassApp','class_forum','classforumid',  'WHERE a.kid = @kid' ,' ',0 
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'ClassApp','class_forum_teacher','classforumid',  'WHERE a.kid = @kid' ,' ',0 
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'ClassApp','class_notice','noticeid',  'WHERE a.kid = @kid' ,' ',0 
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'ClassApp','class_schedule','scheduleid',  'WHERE a.kid = @kid' ,' ',0 
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'ClassApp','class_video','videoid',  'WHERE a.kid = @kid' ,' ',0 
	

INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'ClassApp','class_articleattachs','attachid',  'inner join ClassApp..class_article b on a.articleid = b.articleid and b.kid = @kid' ,'  AND a.VersionNo = b.VersionNo  ',0 
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'ClassApp','class_articlecomments','articlecommentid',  'inner join ClassApp..class_article b on a.articleid = b.articleid and b.kid = @kid' ,'  AND a.VersionNo = b.VersionNo  ',0 
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'ClassApp','class_notice_class','id',  'inner join ClassApp..class_notice b on a.noticeid = b.noticeid and b.kid = @kid' ,'  AND a.VersionNo = b.VersionNo  ',0 
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'ClassApp','class_scheduleattach','attachid',  'inner join ClassApp..class_schedule b on a.scheduleid = b.scheduleid and b.kid = @kid' ,'  AND a.VersionNo = b.VersionNo  ',0 
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'ClassApp','class_schedulecomments','schedulecommentid',  'inner join ClassApp..class_schedule b on a.scheduleid = b.scheduleid and b.kid = @kid' ,'  AND a.VersionNo = b.VersionNo  ',0 
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'ClassApp','class_photos','photoid',  'inner join ClassApp..class_album b on a.albumid = b.albumid and b.kid = @kid' ,'  AND a.VersionNo = b.VersionNo  ',0 
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'ClassApp','class_photocomments','photocommentid',  'inner join ClassApp..class_photos b on a.photoid = b.photoid inner join ClassApp..class_album c on b.albumid = c.albumid and c.kid = @kid' ,'  AND a.VersionNo = b.VersionNo  AND a.VersionNo = c.VersionNo  ',0 
INSERT INTO BackupApp..TableInfo(DBName, TBName, Keystr, FilStr, VersionCtrl, IsCanDel )
SELECT 'ClassApp','class_videocomments','videocommentid',  'inner join ClassApp..class_video b on a.videoid = b.videoid and b.kid = @kid' ,'  AND a.VersionNo = b.VersionNo  ',0 



DocApp	kin_doc_category
DocApp	thelp_categories
DocApp	thelp_docattachs
DocApp	thelp_doccomment
DocApp	thelp_documents
DocApp	thelp_mastercomment
EBook	TNB_TeachingNoteBook
GBApp	celllist
GBApp	CellSet
GBApp	CellTarget
GBApp	ChildrenInfo
GBApp	classinfo
GBApp	EBookModule
GBApp	familyinfo
GBApp	foreword
GBApp	garteninfo
GBApp	gblifephoto
GBApp	gbworkphoto
GBApp	GrowthBook
GBApp	HomeBook
GBApp	kidview
GBApp	kidviewtarget
GBApp	ModuleSet
GBApp	section
GBApp	sectionset
GBApp	summary
GBApp	video_temp
GBApp	zlassess











delete BackupApp..TableInfo where tBName in('class_photocomments','','')

UPDATE BackupApp..TableInfo SET IsCanDel = 1 where DBName = 'Basicdata' and TBName = 'user_class'


BasicData

truncate table BackupApp..TableInfo





declare @result int
exec @result = BackUpTable @kid = 12511, @db_name = 'Basicdata', @TBName = 'user_baseinfo', @VersionNo = 1
select @result

[dbo].[Basicdata_user_baseinfo]

