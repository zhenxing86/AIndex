USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_SearchClass_GetModelByCid]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[BasicData_SearchClass_GetModelByCid]
@cid int
AS
BEGIN
  
 SELECT t1.kid,t1.cid,t1.cname,t1.gname,t1.teacherlist,t1.childnumber,t2.kname  from search_class t1 join search_kindergarten t2 on t1.kid=t2.kid WHERE t1.cid=@cid
   
END




GO
