USE [AppConfig]
GO
/****** Object:  StoredProcedure [dbo].[AppConfig_AppList_GetListByClassIDAndUserType]    Script Date: 2014/11/24 21:11:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:	lx
-- Create date: 2011-5-21
-- Description:根据班级和用户类型取出对应应用集合(站点为说明没有加入幼儿园)
--exec [AppConfig_AppList_GetListByClassIDAndUserType] 58,2
-- =============================================
CREATE PROCEDURE [dbo].[AppConfig_AppList_GetListByClassIDAndUserType]
@classid int,
@usertype int
AS
BEGIN
  DECLARE @appclassid int
  --小朋友
  IF(@usertype=0)
  BEGIN
   SET @appclassid=0
  END
  --老师
  ELSE IF(@usertype=1)
  BEGIN
   SET  @appclassid=1
  END
  
  ELSE IF(@usertype=2)
  BEGIN
   SET @appclassid=2
  END
     SELECT t1.appname,t1.controller,t1.[action],t1.appclass from applist as t1
      inner join  classapp t2 on t1.id=t2.appid
      WHERE t1.[status]<>0 AND (t2.opclassid=@appclassid or t2.opclassid=@classid)
     AND  NOT  EXISTS(select  * from  tem_classapp  where opclassid=@classid AND oppid=t1.id )
     order by t1.sort desc
END

     



GO
