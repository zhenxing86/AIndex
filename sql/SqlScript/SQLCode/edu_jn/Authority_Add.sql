USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[Authority_Add]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：增加一条记录 
--名称：Authority
------------------------------------
CREATE PROCEDURE [dbo].[Authority_Add] 
 
	@gid int ,   
	@menuid int ,   
	@allow int ,   
	@key int ,   
	@reMark int   		
	 AS 
INSERT INTO [Authority]
(   [gid],   [menuid],   [allow],   [key],   [reMark]  )
VALUES
(  @gid,   @menuid,   @allow,   @key,   @reMark  )	
	RETURN 0







GO
