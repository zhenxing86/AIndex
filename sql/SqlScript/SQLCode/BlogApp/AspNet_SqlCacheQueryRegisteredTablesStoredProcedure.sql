USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[AspNet_SqlCacheQueryRegisteredTablesStoredProcedure]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AspNet_SqlCacheQueryRegisteredTablesStoredProcedure] 
         AS
         SELECT tableName FROM dbo.AspNet_SqlCacheTablesForChangeNotification   




GO
