USE [master]
GO
/****** Object:  StoredProcedure [dbo].[p_killspid]    Script Date: 07/17/2013 11:20:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   proc [dbo].[p_killspid] 
@dbname varchar(200)    --要关闭进程的数据库名 
as  
    declare @sql  nvarchar(500)  
    declare @spid nvarchar(20) 

    declare #tb cursor for 
        select spid=cast(spid as varchar(20)) from master..sysprocesses where dbid=db_id(@dbname) 
    open #tb 
    fetch next from #tb into @spid 
    while @@fetch_status=0 
    begin  
        exec('kill '+@spid) 
        fetch next from #tb into @spid 
    end  
    close #tb 
    deallocate #tb 

