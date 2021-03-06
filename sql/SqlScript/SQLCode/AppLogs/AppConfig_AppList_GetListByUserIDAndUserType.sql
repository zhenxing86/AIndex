USE [AppConfig]
GO
/****** Object:  StoredProcedure [dbo].[AppConfig_AppList_GetListByUserIDAndUserType]    Script Date: 2014/11/24 21:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:	lx
-- Create date: 2011-5-21
-- Description:根据班级和用户类型取出对应应用集合(站点为0说明没有加入幼儿园)
--exec AppConfig_AppList_GetListByUserIDAndUserType 58	,1
-- =============================================
CREATE PROCEDURE [dbo].[AppConfig_AppList_GetListByUserIDAndUserType]
@userid int,
@usertype int
AS
BEGIN
  DECLARE @appuserid int
  IF(@usertype=0)
  BEGIN
   SET @appuserid=0
  END
  ELSE IF (@usertype=1)
  BEGIN 
   SET  @appuserid=1
  END
    ELSE IF (@usertype=2)
  BEGIN 
   SET  @appuserid=2
  END
  
  
     SELECT t1.appname,t1.controller,t1.[action],t1.appclass from applist as t1 
     inner join   personalapp t2 on t1.id=t2.appid 
     WHERE t1.[status]<>0 AND (t2.userid=@appuserid or t2.userid=@userid)
     and not exists(select * from tem_personalapp where  oppid=t1.id and userid=@userid)
     order by sort desc
END

GO
