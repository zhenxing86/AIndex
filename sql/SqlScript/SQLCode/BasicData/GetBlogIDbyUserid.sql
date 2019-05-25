USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[GetBlogIDbyUserid]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:	   liaoxin
-- Create date: 2011-08-1
-- Description:	GetBlogIDbyUserid
-- =============================================
CREATE PROCEDURE [dbo].[GetBlogIDbyUserid]
@bloguserid  int 
AS
BEGIN 
declare @userid int
select  @userid=userid from user_bloguser where bloguserid=@bloguserid
return @userid
END



GO
