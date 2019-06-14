USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[GetUserInfoMode_ByUserID]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lx
-- Create date: 2011-06-28
-- Description: 获取用户基本信息
--exec ClassApp_GetUserInfoMode_ByUserID 84557
-- =============================================
CREATE PROCEDURE [dbo].[GetUserInfoMode_ByUserID]
@userid int
AS
BEGIN
     

     
    DECLARE @bloguserid int
    select @bloguserid=bloguserid from BasicData..user_bloguser where  userid=@userid
      
    select @userid as userid,t2.name,t2.kid,@bloguserid,t2.usertype,t4.sitedns  
    from  
    BasicData..[user] t2,
    kwebcms..[site] t4
    where t2.userid=@userid and t4.siteid=t2.kid 
  END

GO
