USE BackupApp
GO
--select a.* from ClassApp..class_articleattachs a inner join ClassApp..class_article b on a.articleid = b.articleid and b.kid = 12511
SELECT * FROM BlogApp..album_photos WHERE photoid = 2147455
/*
姜一诺ys1
*/
exec BackupWeb @KID = 12511, @VersionNo = 3
GO
delete BlogApp..album_photos WHERE photoid = 2147455

SELECT * FROM BlogApp..album_photos WHERE photoid = 2147455
/*
姜一诺ys1还原测试
*/
GO
exec RestoreWeb @KID = 12511, @VersionNo = 3
GO
SELECT * FROM BlogApp..album_photos WHERE photoid = 2147455
/*
姜一诺ys1
*/