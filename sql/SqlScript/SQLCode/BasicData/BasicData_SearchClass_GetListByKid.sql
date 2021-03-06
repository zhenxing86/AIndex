USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_SearchClass_GetListByKid]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[BasicData_SearchClass_GetListByKid]
@kid int,
@page int,
@size int
AS
BEGIN
     DECLARE @ignore int,@pre int
     SET @pre=@page*@size
     SET @ignore=@pre-@size
    
     IF @page>1
     BEGIN
     DECLARE @temtable TABLE
     (
      row int IDENTITY(1,1),
      temid int
      )
      SET ROWCOUNT @pre
      INSERT INTO @temtable SELECT cid from search_class WHERE kid=@kid
      
      SET ROWCOUNT @size
      SELECT t1.kid,t1.cid,t1.cname,t1.gname,t1.teacherlist,t1.childnumber,t3.kname FROM search_class t1 join kindergarten t3
      on t1.kid=t3.kid join @temtable t2 on t1.cid=t2.temid WHERE row>@ignore
      
      
     END
     ELSE
     BEGIN
      SET ROWCOUNT @size
      SELECT t1.kid,t1.cid,t1.cname,t1.gname,t1.teacherlist,t1.childnumber,t2.kname  from search_class t1 join kindergarten t2 on t1.kid=t2.kid where t1.kid=@kid
     END
     
END





GO
