USE [NGBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[rep_homebook_week_Report_ClassGetTime]    Script Date: 2014/11/24 23:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-10-08
-- Description:	返回幼儿表现的序号与周次（月份）   
-- Memo:
1.幼儿表现
2.每月进步
3.老师上传
4.观察记录

EXEC rep_homebook_week_Report_ClassGetTime
	@term = '2013-1',
	@kid = 12511
EXEC rep_homebook_week_Report_ClassGetTime
	@term = '2013-1',
	@kid = 12511,
	@type = 2
*/
CREATE PROCEDURE [dbo].[rep_homebook_week_Report_ClassGetTime]
	@term varchar(20),
	@kid int,
	@type int = 1
AS
BEGIN
	SET NOCOUNT ON
	
	declare @y0 varchar(20),@y1 varchar(20)
	set @y0=CONVERT(varchar(4),@term)
	set @y1=CONVERT(varchar(4),dateadd(YYYY,1,@y0),120)
	
	if @type = 1
		select pos, title from dbo.fn_GetCellsetList(@term,@kid)
	ELSE IF RIGHT(@term,1) = '0'
		select pos, @y0+'年'+col title from  CommonFun..f_split('3月,4月,5月,6月,7月,8月',',')  
	ELSE 
		select pos, (case when col in ('1月','2月') then @y1 else @y0 end)+'年'+col title from  CommonFun..f_split('9月,10月,11月,12月,1月,2月',',')  
	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'返回幼儿表现的序号与周次（月份）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report_ClassGetTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'学期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report_ClassGetTime', @level2type=N'PARAMETER',@level2name=N'@term'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report_ClassGetTime', @level2type=N'PARAMETER',@level2name=N'@kid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1.幼儿表现  
2.每月进步  
3.老师上传  
4.观察记录  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'rep_homebook_week_Report_ClassGetTime', @level2type=N'PARAMETER',@level2name=N'@type'
GO
