USE SMS
CREATE TABLE test(D DATETIME DEFAULT GETDATE(), MEMO VARCHAR(10))
go
insert into test(memo) select '测试开始'
insert into test(memo) select '全备份'
/*
USE SMS
select * from test	
D                       MEMO
----------------------- ----------
2013-06-29 17:53:05.080 测试开始
2013-06-29 17:53:05.083 全备份
*/
USE BackupApp
exec BackupFull

USE SMS
insert into test(memo) select '差异备份'
/*
USE SMS
select * from test	
D                       MEMO
----------------------- ----------
2013-06-29 17:54:08.140 测试开始
2013-06-29 17:54:08.140 全备份
2013-06-29 17:54:33.277 差异备份
*/
USE BackupApp
exec BackupDIFF

USE SMS
insert into test(memo) select '差异备份后'
/*
USE SMS
select * from test
D                       MEMO
----------------------- ----------
2013-06-29 17:54:08.140 测试开始
2013-06-29 17:54:08.140 全备份
2013-06-29 17:54:33.277 差异备份
2013-06-29 17:55:25.800 差异备份后  
*/
--还原到完整备份
USE BackupApp
exec RestoreDB 'SMS',
'E:\backup\FULL\SMS\SMS_Full_2013_07_01 09_27_24.bak'
/*
USE SMS
select * from test	
D                       MEMO
----------------------- ----------
2013-06-29 17:54:08.140 测试开始
2013-06-29 17:54:08.140 全备份
*/
--还原到差异备份
USE BackupApp
exec RestoreDB 'SMS',
'E:\backup\FULL\SMS\SMS_Full_2013_07_01 09_27_24.bak', 
'E:\backup\DIFF\SMS\SMS_DIFF_2013_07_01 09_28_50.bak'
/*
USE SMS
select * from test	
D                       MEMO
----------------------- ----------
2013-06-29 17:54:08.140 测试开始
2013-06-29 17:54:08.140 全备份
2013-06-29 17:54:33.277 差异备份
*/
--还原到任意LOG备份前的版本
USE BackupApp
exec RestoreDB 'SMS',
'E:\backup\FULL\SMS\SMS_Full_2013_07_01 09_27_24.bak', 
null,'E:\backup\logbackup\SMS_LOG_2013_07_01 09_29_08.bak',
'2013-07-01 09:29:07'

/*
USE SMS
select * from test	
D                       MEMO
----------------------- ----------
2013-06-29 17:54:08.140 测试开始
2013-06-29 17:54:08.140 全备份
2013-06-29 17:54:33.277 差异备份
2013-06-29 17:55:25.800 差异备份后
*/
--还原到现时间前的任意时间版本
USE SMS
insert into test(memo) select '即席还原前'
WAITFOR DELAY '00:00:05'
insert into test(memo) select '即席还原后'

USE BackupApp
exec RestoreDB 'SMS',
'E:\backup\FULL\SMS\SMS_Full_2013_07_01 09_27_24.bak', 
null,null,
'2013-07-01 09:40:01.963'

/*
USE SMS
select * from test	
D                       MEMO
----------------------- ----------
2013-06-29 17:54:08.140 测试开始
2013-06-29 17:54:08.140 全备份
2013-07-01 09:39:57.943 即席还原前
*/

