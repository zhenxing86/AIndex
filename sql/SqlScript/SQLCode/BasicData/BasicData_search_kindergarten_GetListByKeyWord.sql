USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_search_kindergarten_GetListByKeyWord]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		lx
-- Create date: 2011-5-25
-- Description:	根据条件筛选获取幼儿园列表
--EXEC BasicData_search_kindergarten_GetListByKeyWord 290,308,-1,'',1,2
-- =============================================
CREATE PROCEDURE [dbo].[BasicData_search_kindergarten_GetListByKeyWord]
@provice int,
@city int,
@area int,
@keyword VARCHAR(50),
@page int,
@size int
AS
BEGIN
      DECLARE @prep int,@ignore int
	  SET @prep=@page*@size
      SET @ignore=@prep-@size
      
      DECLARE @temStr varchar(500) 
          
      IF(@provice<>-1 AND @city<>-1 AND @area<>-1)
      BEGIN
        SET @temStr='SELECT kid FROM  search_kindergarten  WHERE privince=' +CONVERT(nvarchar(50),@provice)+' AND city='+CONVERT(nvarchar(50),@city)+' AND area='+CONVERT(nvarchar(50),@area)+' and kname like''%'+@keyword+'%'''
	  END	
	  ELSE IF(@provice<>-1 AND @city<>-1 AND @area=-1)
	  BEGIN
	      SET @temStr='SELECT kid FROM  search_kindergarten  WHERE privince='+CONVERT(nvarchar(50),@provice)+' AND city='+CONVERT(nvarchar(50),@city)+'  AND  kname like ''%'+@keyword+'%'''
	  END
	   ELSE IF(@provice<>-1 AND @city=-1 AND @area=-1)
	  BEGIN
	      SET @temStr='SELECT kid FROM  search_kindergarten  WHERE privince='+CONVERT(nvarchar(50),@provice)+'   AND  kname like ''%'+@keyword+'%'''
	  END
	  
	   ELSE IF(@provice=-1 AND @city=-1 AND @area=-1)
	  BEGIN
	      SET @temStr='SELECT kid FROM  search_kindergarten  WHERE  kname like ''%'+@keyword+'%'''
	  END
	  
		IF(@page>1)
		BEGIN
		DECLARE @temTable table(
		 row int IDENTITY(1,1),
		 temtableid int
		)
	    
		SET ROWCOUNT @prep 
		INSERT INTO @temTable execute(@temStr)
		
		SET ROWCOUNT @size
		SELECT t1.kid,t1.kname,t1.classnumber,t1.childnumber,t1.teachernumber from search_kindergarten t1  
		JOIN @temTable t3 ON t1.kid=t3.temtableid WHERE row>@ignore
		END
		
		ELSE IF(@page=1)
		BEGIN
		
		SET ROWCOUNT @prep 
	    INSERT INTO @temTable execute(@temStr)
	    
		SET ROWCOUNT @prep 
		SELECT t1.kid,t1.kname,t1.classnumber,t1.childnumber,t1.teachernumber  from search_kindergarten t1 
		JOIN @temTable t3 ON t1.kid=t3.temtableid
		END
END





GO
