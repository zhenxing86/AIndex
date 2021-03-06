USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[LogInfo_Ex_Add]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*          
-- Author:     xie
-- Create date: 2014-07-21          
-- Description:  新增异常日志     
-- Memo:            
exec Loginfo_Ex_Add '2014-6-1 00:00:00','2014-6-2 23:59:59'  

select* from mcapp..loginfo_ex  where logtype=10 and smalllogtype =1  
*/ 

create PROC [dbo].[LogInfo_Ex_Add]                
 @kid int                
,@devid nvarchar(50)  
,@logtype int  
,@smalllogtype int  
,@logmsg nvarchar(4000)  
AS                
BEGIN    
  
 insert into LogInfo_ex(kid,devid,logtype,smalllogtype,logmsg,logtime,uploadtime,devicetype)  
  select @kid,@devid,@logtype,@smalllogtype,@logmsg,GETDATE(),GETDATE(),3    
    
 if @@ERROR<>0  
   return -1  
 else return 1  
END    
GO
