----------------------------------------------------------------
-- Author  :谭磊
-- Date    :2013-06-27 14:21:46
-- Version:
--      Microsoft SQL Server 2008 R2 (SP2) - 10.50.4000.0 (X64) 
--	Jun 28 2012 08:36:30 
--	Copyright (c) Microsoft Corporation
--	Enterprise Edition (64-bit) on Windows NT 6.1 <X64> (Build 7601: Service Pack 1)
--
----------------------------------------------------------------
--> 测试数据：#TA
if object_id('tempdb.dbo.#TA') is not null drop table #TA
go 
create table #TA([数据库] varchar(14),[文件位置] varchar(1))
insert #TA
select 'AppAccessLogs','G' union all
select 'AppConfig','G' union all
select 'AppLogs','G' union all
select 'ASPState','G' union all
select 'BasicData','F' union all
select 'BlogApp','F' union all
select 'CardApp','G' union all
select 'ClassApp','F' union all
select 'CommonFun','G' union all
select 'Company_FAQ','G' union all
select 'DocApp','F' union all
select 'DrawApp','G' union all
select 'EBook','F' union all
select 'edu_dx','G' union all
select 'edu_jn','G' union all
select 'edu_ta','G' union all
select 'ExeSP','G' union all
select 'GameApp','F' union all
select 'GBApp','F' union all
select 'GroupApp','G' union all
select 'gyszq','G' union all
select 'HealthApp','F' union all
select 'KinInfoApp','G' union all
select 'KMP','G' union all
select 'KWebCMS','F' union all
select 'KWebCMS_Right','F' union all
select 'KWebCMS_Temp','F' union all
select 'logdata','G' union all
select 'mcapp','F' union all
select 'mcapp_history','G' union all
select 'MsgApp','F' union all
select 'ossapp','F' union all
select 'ossrep','G' union all
select 'PayApp','F' union all
select 'PayAppDemo','G' union all
select 'ReportApp','F' union all
select 'ResourceApp','G' union all
select 'SBApp','F' union all
select 'SBAppLog','G' union all
select 'settlerep','G' union all
select 'SMS','F' union all
select 'SMS_History','G' union all
select 'SqlAgentDB','G' union all
select 'SSO','G' union all
select 'ZGYEY_OM','F' union all
select 'ZGYEYCMS_Right','F'
--------------开始查询--------------------------
SET NOCOUNT ON
DECLARE @SQL VARCHAR(MAX)
SELECT @SQL = ISNULL(@SQL,'')+
'backup database '+[数据库]+'
		to disk=''E:\backup\'+[文件位置]+'/'+[数据库]+'.bak'''+char(13)+char(10) +'GO'+char(13)+char(10)

 from #TA
print @SQL
----------------结果----------------------------
/* 
*/
