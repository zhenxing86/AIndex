USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[class_GetList]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[class_GetList]
@kid int
 AS 

if(@kid=14237)
begin

	SELECT 
	cid,cname,grade,sname
	 FROM [class] WHERE  kid=@kid and deletetag=1 and iscurrent=1 order by grade asc, [order] desc
end
else if(@kid=22808)
begin
SELECT 
	cid,cname,grade,sname
	 FROM [class] WHERE kid=@kid and deletetag=1 and iscurrent=1 order by [order] desc
end
else
begin
SELECT 
	cid,cname,grade,sname
	 FROM [class] WHERE kid=@kid and deletetag=1 and iscurrent=1 order by grade asc, [order] desc
end
GO
