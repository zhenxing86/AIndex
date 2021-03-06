USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[ArticleType_Add]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：增加一条记录 
--名称：ArticleType
------------------------------------
CREATE PROCEDURE [dbo].[ArticleType_Add] 
	@orderby int ,   
	@parentid int ,   
	@articleTypeName varchar (50),   
	@describe varchar (2000),   
	@level int ,   
	@contentype int ,   
	@createuserid int ,   
	@createtime datetime ,   
	@webDictID int ,
	@deletefag int  		
	 AS 
	 
	 
	 select @orderby = MAX(orderby)+1 from [ArticleType]
	 
INSERT INTO [ArticleType]
(   [orderby],   [parentid],   [articleTypeName],   [describe],   [level],   [contentype],   [createuserid],   [createtime],   [webDictID] ,deletefag )
VALUES
(   @orderby,   @parentid,   @articleTypeName,   @describe,   @level,   @contentype,   @createuserid,   @createtime,   @webDictID ,@deletefag )	
	RETURN 0






GO
