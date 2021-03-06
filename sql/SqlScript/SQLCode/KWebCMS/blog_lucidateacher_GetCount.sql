USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_lucidateacher_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-22
-- Description:	获取学生数量
-- =============================================
CREATE PROCEDURE [dbo].[blog_lucidateacher_GetCount]
@kid int
AS
BEGIN
	Declare @count int
	SELECT @count=count(1)	FROM blog_lucidaUser_log t1
left join basicdata..[user] t2 on t2.userid=t1.appuserid

where siteid=@kid and t1.usertype<>0 and t2.deletetag=1
	RETURN @count
END


GO
