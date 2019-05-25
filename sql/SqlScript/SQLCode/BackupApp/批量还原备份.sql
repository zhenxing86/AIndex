USE master
GO
-- 允许配置高级选项 
EXEC sp_configure 'show advanced options', 1
GO 
-- 重新配置 
RECONFIGURE 
GO 
-- 启用xp_cmdshell 
EXEC sp_configure 'xp_cmdshell', 1 
GO 
--重新配置 
RECONFIGURE 
GO
EXEC sp_restoredatabase2
    'E:\backup\F', --
    'F:\MSSQL\Data', --
    'G:\MSSQL\Logs'
go
EXEC sp_restoredatabase2
    'E:\backup\G', --
    'G:\MSSQL\Data', --
    'G:\MSSQL\Logs'
go
EXEC sp_configure 'show advanced options', 1
GO 
-- 重新配置 
RECONFIGURE 
GO 
-- 关闭xp_cmdshell 
EXEC sp_configure 'xp_cmdshell', 0