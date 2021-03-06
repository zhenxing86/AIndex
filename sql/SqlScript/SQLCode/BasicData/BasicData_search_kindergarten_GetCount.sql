USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[BasicData_search_kindergarten_GetCount]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		lx
-- Create date: 2011-5-25
-- Description:	根据条件筛选获取幼儿园列表总数
-- EXEC 
-- =============================================
CREATE  PROCEDURE [dbo].[BasicData_search_kindergarten_GetCount]
@provice int,
@city int,
@area int,
@keyword VARCHAR(50)
AS
BEGIN
      DECLARE @returnvalue int
      DECLARE @temStr varchar(500) 
          
      IF(@provice<>-1 AND @city<>-1 AND @area<>-1)
      BEGIN
        SET @temStr='SELECT count(*) FROM  search_kindergarten  WHERE privince=' +CONVERT(nvarchar(50),@provice)+' AND city='+CONVERT(nvarchar(50),@city)+' AND area='+CONVERT(nvarchar(50),@area)+' and kname like''%'+@keyword+'%'''
	  END	
	  ELSE IF(@provice<>-1 AND @city<>-1 AND @area=-1)
	  BEGIN
	      SET @temStr='SELECT  count(*) FROM  search_kindergarten  WHERE privince='+CONVERT(nvarchar(50),@provice)+' AND city='+CONVERT(nvarchar(50),@city)+'  AND  kname like ''%'+@keyword+'%'''
	  END
	   ELSE IF(@provice<>-1 AND @city=-1 AND @area=-1)
	  BEGIN
	      SET @temStr='SELECT  count(*) FROM  search_kindergarten  WHERE privince='+CONVERT(nvarchar(50),@provice)+'   AND  kname like ''%'+@keyword+'%'''
	  END
	  
	   ELSE IF(@provice=-1 AND @city=-1 AND @area=-1)
	  BEGIN
	      SET @temStr='SELECT  count(*)  FROM  search_kindergarten  WHERE  kname like ''%'+@keyword+'%'''
	  END
	 
      execute(@temStr)
END





GO
