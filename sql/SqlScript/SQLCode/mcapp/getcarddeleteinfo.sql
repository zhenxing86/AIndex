USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[getcarddeleteinfo]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
[getcarddeleteinfo] 12511,'001251100'
*/
CREATE PROCEDURE [dbo].[getcarddeleteinfo]   
@kid int,  
@devid varchar(20)  
 AS    
 
  SELECT CAST( userid AS varchar),CAST( usertype AS varchar),@kid,updatetime  
    FROM  BasicData..User_Del  
    where kid = @kid     
    and updatetime >= '2008-7-8'
    
--SELECT TOP(0) [oid]        
--      ,CAST( [usertype] AS varchar)
--      ,[kid]  
--      ,[adate]  
--  FROM [mcapp].[dbo].[card_delete_tmp]   
--return  
--create table #cardinfolist  
--(  
--oid int  
--)  
  
--insert into #cardinfolist(oid)  
--select oid from userdelete_tmp where devid=@devid  
  
--SELECT [oid]        
--      ,[usertype]  
--      ,[kid]  
--      ,[adate]  
--  FROM [mcapp].[dbo].[card_delete_tmp]   
--where kid=@kid and oid not in(select oid from #cardinfolist)  


GO
