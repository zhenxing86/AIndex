USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thome_period_GetCurrentByDate]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：查询记录信息 
--项目名称：zgyeyblog
--说明：
--时间：2009-06-22 13:14:22
------------------------------------
CREATE PROCEDURE [dbo].[thome_period_GetCurrentByDate]
@kid int,
@date datetime
 AS 
	
declare @rtn int
	SELECT 
		top 1 @rtn= period
	 FROM thome_category
	WHERE kid=@kid and startdate<=@date and enddate>=@date

IF @@ERROR <> 0 
	BEGIN			
	   RETURN(-1)
	END
	ELSE
	BEGIN		
	   RETURN Isnull(@rtn, 0)
	END





GO
