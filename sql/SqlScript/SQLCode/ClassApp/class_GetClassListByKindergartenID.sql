USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_GetClassListByKindergartenID]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-18
-- Description:	取幼儿园所有班级信息
-- Memo:		
class_GetClassListByKindergartenID 12511
*/
CREATE PROCEDURE [dbo].[class_GetClassListByKindergartenID]
	@kid int
AS	
BEGIN
	SET NOCOUNT ON
	if(@kid=5810 or @kid=21260)  
	begin  
		SELECT	c.cid, c.kid, c.cname, '' as theme, 
						g.gname AS classgradetitle, c.grade   
			FROM BasicData.dbo.class c 
				inner join BasicData.dbo.grade g 
					on c.grade = g.gid  
			WHERE c.kid = @kid 
				and deletetag = 1 
				and c.iscurrent = 1 
			ORDER BY c.grade, c.[order]  
		end  
		else  
		begin  
		SELECT	c.cid, c.kid, c.cname, '' as theme, 
						g.gname AS classgradetitle,c.grade   
			FROM BasicData.dbo.class c 
				inner join BasicData.dbo.grade g 
					on c.grade=g.gid  
			WHERE g.gid <> 38 
				and c.kid = @kid 
				and deletetag = 1 
				and c.iscurrent = 1 
			ORDER BY c.grade, c.[order]  
  
end
END

GO
