USE [fmcapp]
GO
/****** Object:  StoredProcedure [dbo].[fmc_authorityexpert_Update]    Script Date: 06/18/2013 16:11:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：修改专家讲坛信息
--项目名称：家庭教育中心 com.zgyey.fmcapp.cms  
--说明: 
--时间：2013-6-17 15:50:29
--exec fmc_authorityexpert_Update '幼儿成长','幼儿成长专题','sfsadfdsaf','http://www.hao123.com/',123,'2013-06-17 10:00:00',1
------------------------------------

ALTER PROCEDURE [dbo].[fmc_authorityexpert_Update]
@id int,
@name	nvarchar(50),
@post	nvarchar(50),
@direction	nvarchar(500),
@smallimg	nvarchar(100),
@uid	int,
@orderby	int,
@deletetag	int
	
AS 

	UPDATE [fmc_authorityexpert] 
	  SET name=@name,post=@post,direction=@direction,smallimg=@smallimg,
	  [uid]=@uid,orderby=@orderby ,deletetag=@deletetag 
	  FROM [fmc_authorityexpert]  
 	  WHERE ID=@id



