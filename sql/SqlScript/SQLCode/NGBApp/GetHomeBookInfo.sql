USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetHomeBookInfo]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-08-21  
-- Description: 读取家园联系册的数据  
-- Memo:  
[GetCidTermByUserid] 224899 
[GetHomeBookInfo] 405, '2013-1', 'wdbj'
*/  
--  
CREATE PROC [dbo].[GetHomeBookInfo]  
 @cid int,
 @term varchar(6),
 @type varchar(50)
AS  
BEGIN  
	SET NOCOUNT ON 
	IF @type IN('xqjy')  --学期寄语   
	 BEGIN     
		SELECT Foreword,ForewordPic  
		FROM HomeBook       
		WHERE cid = @cid
			AND term = @term  
	 END   
	 ELSE IF @type IN('wdbj')  --我的班级   
	 BEGIN     
		SELECT ClassPic, ClassNotice,ISNULL(Teacher,dbo.GetHomeBookTercher(cid))Teacher  
		FROM HomeBook        
		WHERE cid = @cid
			AND term = @term  
	 END 
END
GO
