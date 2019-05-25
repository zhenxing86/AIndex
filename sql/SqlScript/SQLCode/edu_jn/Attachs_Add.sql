USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[Attachs_Add]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









------------------------------------
--用途：增加一条记录 
--名称：Attachs
------------------------------------
CREATE PROCEDURE [dbo].[Attachs_Add] 
	@pid int ,   
	@title varchar (30),   
	@filepath varchar (200),   
	@filename varchar (200),   
	@filesize varchar (200),   
	@filetype int ,   
	@createdatetime datetime   		
	 AS 
INSERT INTO [Attachs]
(  [pid],   [title],   [filepath],   [filename],   [filesize],   [filetype],   [createdatetime]  )
VALUES
(   @pid,   @title,   @filepath,   @filename,   @filesize,   @filetype,   @createdatetime  )	
	RETURN 0









GO
