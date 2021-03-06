USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[ArticleList_Add]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：增加一条记录 
--名称：ArticleList
------------------------------------
CREATE PROCEDURE [dbo].[ArticleList_Add] 

	@typeid int ,   
	@title varchar (200),   
	@body varchar(MAX),   
	@describe varchar (500),   
	@autor varchar (50),   
	@level int ,   
	@isMaster int ,   
	@orderID int ,   
	@reMark varchar (300),   
	@uid int ,   
	@createtime datetime ,   
	@deletetag int,  	
	@returnvalue int =0  output,
	@clickcount int
	 AS 
INSERT INTO [ArticleList]
(  [typeid],   [title],   [body],   [describe],   [autor],   [level],   [isMaster],   [orderID],   [reMark],   [uid],   [createtime],   [deletetag] ,clickcount )
VALUES
(   @typeid,   @title,   @body,   @describe,   @autor,   @level,   @isMaster,   @orderID,   @reMark,   @uid,   @createtime,   @deletetag , @clickcount)	
	

		set @returnvalue = @@identity
		
	RETURN  @returnvalue






GO
