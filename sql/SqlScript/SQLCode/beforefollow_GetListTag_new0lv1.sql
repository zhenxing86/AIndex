USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[beforefollow_GetListTag_new0lv1]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[beforefollow_GetListTag_new0lv1]
 @page int
,@size int
,@uid int
,@kname varchar(100)
,@name varchar(100)
,@mobile varchar(100)
,@developer varchar(100)
,@privince varchar(100)
,@city varchar(100)
,@area varchar(100)
 AS 

create table #ulist
(puid int,[name] varchar(100))


GO
