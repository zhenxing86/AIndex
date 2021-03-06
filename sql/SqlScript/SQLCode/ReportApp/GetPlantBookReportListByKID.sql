USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[GetPlantBookReportListByKID]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:	lx
-- Create date: 20110818
-- Description:获取家园练习册报表
--
-- =============================================
CREATE PROCEDURE [dbo].[GetPlantBookReportListByKID] 
@kid int,
@gid int,
@page int,
@size int
AS
BEGIN
  	IF (@page>1)
  	BEGIN
  	   DECLARE @prep int,@ignore int
  	   SET @prep=@size*@page
  	   SET @ignore=@prep-@size
  	   
  	   DECLARE @temtable TABLE
  	   (
  	    row int identity(1,1),
  	    temid int
  	   )
  	   SET ROWCOUNT @prep
  	   INSERT INTO @temtable SELECT t1.classid from rep_plantbook t1  INNER JOIN basicdata..class t2 
  	   ON t1.classid=t2.cid where t2.kid=@kid and t2.grade=@gid  and t2.deletetag=1
  	   ORDER BY thisweeknum DESC
  	   
  	   SET ROWCOUNT @size
  	   SELECT t1.cname,t2.thisweeknum,t2.lastweeknum,t2.classid FROM  rep_plantbook t2 inner join basicdata..class t1
  	   ON t1.cid=t2.classid inner join @temtable t3
  	   ON t2.classid=t3.temid WHERE t3.row>@ignore and t1.kid=@kid
  	   ORDER BY t2.thisweeknum DESC
  	   
  	   
  	END
  	ELSE 
  	BEGIN
  	     SET ROWCOUNT @size
  	     SELECT t1.cname,t2.thisweeknum,t2.lastweeknum,t2.classid FROM  rep_plantbook t2 inner join basicdata..class t1
  	      ON t1.cid=t2.classid
  	      WHERE t1.kid=@kid and t1.grade=@gid and t1.deletetag=1
  	     ORDER BY t2.thisweeknum DESC
  	END 
	 
END


GO
