USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[getcarddeleteinfo]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getcarddeleteinfo] 
@kid int,
@devid varchar(20)
 AS 	
SELECT TOP(0) [oid]      
      ,[usertype]
      ,[kid]
      ,[adate]
  FROM [mcapp].[dbo].[card_delete_tmp] 
return
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
