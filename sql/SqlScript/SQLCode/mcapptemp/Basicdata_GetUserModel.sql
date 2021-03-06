USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[Basicdata_GetUserModel]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Basicdata_GetUserModel]
@userid int
AS
BEGIN

SELECT top 1 k.kid,k.kname,c.cid,c.cname,u.userid,u.[name],c.cid,u.usertype,t.title 
FROM BasicData..[user] u
left join BasicData..user_class uc on uc.userid=u.userid
left join BasicData..class c on c.cid=uc.cid
left join BasicData..kindergarten k on k.kid=u.kid
left join BasicData..teacher t on t.userid=u.userid
where u.userid=@userid

END

GO
