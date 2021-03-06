USE [KinInfoApp]
GO
/****** Object:  StoredProcedure [dbo].[GetUserInfoMode_ByUserID]    Script Date: 2014/11/24 23:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lx
-- Create date: 2011-06-28
-- Description: 获取用户基本信息
--exec [GetUserInfoMode_ByUserID] 84557
-- =============================================
CREATE PROCEDURE [dbo].[GetUserInfoMode_ByUserID] 
@userid int
AS
BEGIN
   
    DECLARE @bloguserid int
    select @bloguserid=bloguserid from BasicData..user_bloguser where  userid=@userid
    
    select @userid as userid,t2.name,t2.kid,@bloguserid,t2.usertype,t4.sitedns
,t5.area,t6.serverurl,t5.kname,(select title from BasicData..Area where ID=t5.residence)
,t5.residence,t5.city
  from 
  BasicData..[user] t2,
  BasicData..kindergarten t5
    left join server_city_url t6 on t6.city=t5.city
    left join kwebcms..[site] t4 on t4.siteid=t5.kid
where  t2.userid=@userid and t5.kid=t2.kid 
  


END

GO
