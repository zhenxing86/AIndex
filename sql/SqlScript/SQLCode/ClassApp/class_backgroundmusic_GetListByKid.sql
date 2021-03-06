USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_backgroundmusic_GetListByKid]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：取班级背景音乐列表 
--项目名称：ClassHomePage
--说明：
--时间：2009-1-15 16:21:36
-- EXEC [class_backgroundmusic_GetListByKid] 5380,2,10
------------------------------------
CREATE PROCEDURE [dbo].[class_backgroundmusic_GetListByKid]
@kid int,
@page int,
@size int
 AS 
  DECLARE @igrone int,@prep int 
  SET @prep=@page*@size
  SET @igrone=@prep-@size
  
  IF(@page>1)
    BEGIN
     DECLARE @temtable table(
      row int identity(1,1),
      temid int
     ) 
   
  
     SET ROWCOUNT @prep
     INSERT INTO @temtable SELECT  id FROM class_backgroundmusic 
     WHERE  kid=@kid and [status]=1
     ORDER BY uploaddatetime DESC
    
     SET ROWCOUNT @size
     SELECT t1.id,t1.kid,t1.classid,t1.backgroundmusicpath,t1.backgroundmusictitle,t1.isdefault,t1.datatype,t2.cname as classname,t1.uploaddatetime
     FROM class_backgroundmusic t1 inner join  basicdata..class t2 on t1.classid=t2.cid and t2.deletetag=1
     INNER JOIN @temtable t3 ON  t1.id=t3.temid  
     WHERE  t3.row>@igrone AND t1.kid=@kid and t1.status=1 
     ORDER BY uploaddatetime DESC
	 END
	
	ELSE
	BEGIN
	  SET ROWCOUNT @size 
	  SELECT t1.id,t1.kid,t1.classid,t1.backgroundmusicpath,t1.backgroundmusictitle,t1.isdefault,t1.datatype,t2.cname as classname,t1.uploaddatetime
      FROM class_backgroundmusic t1 inner join  basicdata..class t2 on t1.classid=t2.cid and t2.deletetag=1
      WHERE t1.kid=@kid and t1.status=1 
	  ORDER BY uploaddatetime DESC
	END
	
	
	








GO
