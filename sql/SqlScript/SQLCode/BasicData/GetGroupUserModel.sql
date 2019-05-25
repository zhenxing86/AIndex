USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[GetGroupUserModel]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[GetGroupUserModel]
@userid int
AS
BEGIN
  select t1.userid,t1.account,t1.pwd,100 as usertype,t1.gid,t2.kid,t2.name,t1.username
from groupapp..group_user t1,groupapp..group_baseinfo t2 where t1.gid=t2.gid and  userid=@userid
END


GO
