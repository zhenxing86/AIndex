USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[GetUserInfoMode_ByUserID]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserInfoMode_ByUserID]
@userid int
AS
BEGIN
    DECLARE @bloguserid int
      
    select @userid as userid,t2.name,t2.kid,@bloguserid,t2.usertype,t4.sitedns  
    from  
    BasicData..[user] t2,
    kwebcms..[site] t4
    where  t2.userid=@userid and t4.siteid=t2.kid 
  END

GO
